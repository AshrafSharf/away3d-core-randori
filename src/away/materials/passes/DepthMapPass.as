/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.passes
{
	import away.textures.Texture2DBase;
	import away.core.display3D.Context3DTextureFormat;
	import away.core.base.IRenderable;
	import away.managers.Stage3DProxy;
	import away.cameras.Camera3D;
	import away.core.geom.Matrix3D;
	import away.core.display3D.Context3D;
	import away.core.math.Matrix3DUtils;
	import away.core.display3D.Context3DProgramType;

	//use namespace arcane;

	/**	 * DepthMapPass is a pass that writes depth values to a depth map as a 32-bit value exploded over the 4 texture channels.	 * This is used to render shadow maps, depth maps, etc.	 */
	public class DepthMapPass extends MaterialPassBase
	{
		private var _data:Vector.<Number>;
		private var _alphaThreshold:Number = 0;
		private var _alphaMask:Texture2DBase;

		/**		 * Creates a new DepthMapPass object.		 */
		public function DepthMapPass():void
		{
			super(false);


			this._data = new <Number>[1, 255.0, 65025.0, 16581375.0, 1.0/255.0, 1.0/255.0, 1.0/255.0, 0.0, 0.0, 0.0, 0, 0];

		}
		
		/**		 * The minimum alpha value for which pixels should be drawn. This is used for transparency that is either		 * invisible or entirely opaque, often used with textures for foliage, etc.		 * Recommended values are 0 to disable alpha, or 0.5 to create smooth edges. Default value is 0 (disabled).		 */
		public function get alphaThreshold():Number
		{
			return this._alphaThreshold;
		}
		
		public function set alphaThreshold(value:Number):void
		{
			if (value < 0)
            {

                value = 0;

            }
			else if (value > 1)
            {

                value = 1;

            }

			if (value == this._alphaThreshold)
            {

                return;

            }

			
			if (value == 0 || this._alphaThreshold == 0)
            {

                this.iInvalidateShaderProgram();

            }

			
			this._alphaThreshold = value;
            this._data[8] = this._alphaThreshold;

		}

		/**		 * A texture providing alpha data to be able to prevent semi-transparent pixels to write to the alpha mask.		 * Usually the diffuse texture when alphaThreshold is used.		 */
		public function get alphaMask():Texture2DBase
		{
			return this._alphaMask;
		}
		
		public function set alphaMask(value:Texture2DBase):void
		{
			this._alphaMask = value;
		}
		
		/**		 * @inheritDoc		 */
		override public function iGetVertexCode():String
		{
			var code:String = "";
			// project

            //TODO: AGAL <> GLSL conversion

			code = "m44 vt1, vt0, vc0		\n" +
				"mov op, vt1	\n";
			
			if (this._alphaThreshold > 0)
            {
                this._pNumUsedTextures = 1;
                this._pNumUsedStreams = 2;
				code += "mov v0, vt1\n" +
					"mov v1, va1\n";
				
			}
            else
            {

                this._pNumUsedTextures = 0;
                this._pNumUsedStreams = 1;
				code += "mov v0, vt1\n";

			}

			return code;
		}
		
		/**		 * @inheritDoc		 */
		override public function iGetFragmentCode(code:String):String
		{
			
			var wrap:String = this._pRepeat? "wrap" : "clamp";
			var filter:String;
			
			if (this._pSmooth){

                filter = this._pMipmap? "linear,miplinear" : "linear";

            }
			else
            {

                filter = this._pMipmap? "nearest,mipnearest" : "nearest";

            }

            // TODO: AGAL<>GLSL
			
			var codeF:String =
				"div ft2, v0, v0.w		\n" +
				"mul ft0, fc0, ft2.z	\n" +
				"frc ft0, ft0			\n" +
				"mul ft1, ft0.yzww, fc1	\n";
			
			if (this._alphaThreshold > 0)
            {

				var format:String;

				switch (this._alphaMask.format)
                {

					case Context3DTextureFormat.COMPRESSED:
						format = "dxt1,";
						break;

					case "compressedAlpha":
						format = "dxt5,";
						break;

					default:
						format = "";

				}

				codeF += "tex ft3, v1, fs0 <2d," + filter + "," + format + wrap + ">\n" +
					"sub ft3.w, ft3.w, fc2.x\n" +
					"kil ft3.w\n";
			}
			
			codeF += "sub oc, ft0, ft1		\n";
			
			return codeF;
		}
		
		/**		 * @inheritDoc		 */
		override public function iRender(renderable:IRenderable, stage3DProxy:Stage3DProxy, camera:Camera3D, viewProjection:Matrix3D):void
		{
			if (this._alphaThreshold > 0)
            {

                renderable.activateUVBuffer(1, stage3DProxy);

            }

			
			var context:Context3D = stage3DProxy._iContext3D;
			var matrix:Matrix3D = Matrix3DUtils.CALCULATION_MATRIX;

			matrix.copyFrom(renderable.getRenderSceneTransform(camera));
			matrix.append(viewProjection);
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matrix, true);
			renderable.activateVertexBuffer(0, stage3DProxy);
			context.drawTriangles(renderable.getIndexBuffer(stage3DProxy), 0, renderable.numTriangles);

		}
		
		/**		 * @inheritDoc		 */
		override public function iActivate(stage3DProxy:Stage3DProxy, camera:Camera3D):void
		{

			var context:Context3D = stage3DProxy._iContext3D;

			super.iActivate(stage3DProxy, camera);
			
			if ( this._alphaThreshold > 0)
            {

                context.setTextureAt(0, this._alphaMask.getTextureForStage3D(stage3DProxy));
                context.setProgramConstantsFromArray(Context3DProgramType.FRAGMENT, 0, this._data, 3);

			}
            else
            {

                context.setProgramConstantsFromArray(Context3DProgramType.FRAGMENT, 0, this._data, 2);
            }

		}
	}
}

/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.methods
{
	import away.textures.CubeTextureBase;
	import away.textures.Texture2DBase;
	import away.managers.Stage3DProxy;
	import away.core.display3D.Context3D;
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterElement;

	/**
	public class EnvMapMethod extends EffectMethodBase
	{
		private var _cubeTexture:CubeTextureBase;
		private var _alpha:Number = 0;
		private var _mask:Texture2DBase;

		/**
		public function EnvMapMethod(envMap:CubeTextureBase, alpha:Number = 1):void
		{
			alpha = alpha || 1;

			super();
			this._cubeTexture = envMap;
            this._alpha = alpha;

		}

		/**
		public function get mask():Texture2DBase
		{
			return this._mask;
		}
		
		public function set mask(value:Texture2DBase):void
		{
            if ( value != this._mask ||
                (value && this._mask && (value.hasMipMaps != this._mask.hasMipMaps || value.format != this._mask.format))) {

                this.iInvalidateShaderProgram();
            }

            /*

			this._mask = value;
		}

		/**
		override public function iInitVO(vo:MethodVO):void
		{
			vo.needsNormals = true;
			vo.needsView = true;
			vo.needsUV = this._mask != null;
		}
		
		/**
		public function get envMap():CubeTextureBase
		{
			return this._cubeTexture;
		}
		
		public function set envMap(value:CubeTextureBase):void
		{
            this._cubeTexture = value;
		}
		
		/**
		override public function dispose():void
		{
		}
		
		/**
		public function get alpha():Number
		{
			return this._alpha;
		}
		
		public function set alpha(value:Number):void
		{
			this._alpha = value;
		}

		/**
		override public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
			var context:Context3D = stage3DProxy._iContext3D;
			vo.fragmentData[vo.fragmentConstantsIndex] = this._alpha;

			context.setTextureAt(vo.texturesIndex, this._cubeTexture.getTextureForStage3D(stage3DProxy));
			if (this._mask)
            {
				context.setTextureAt(vo.texturesIndex + 1, this._mask.getTextureForStage3D(stage3DProxy));
            }
		}

		/**
		override public function iGetFragmentCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			var dataRegister:ShaderRegisterElement = regCache.getFreeFragmentConstant();
			var temp:ShaderRegisterElement = regCache.getFreeFragmentVectorTemp();
			var code:String = "";
			var cubeMapReg:ShaderRegisterElement = regCache.getFreeTextureReg();

			    vo.texturesIndex = cubeMapReg.index;
			vo.fragmentConstantsIndex = dataRegister.index*4;
			
			regCache.addFragmentTempUsages(temp, 1);
			var temp2:ShaderRegisterElement = regCache.getFreeFragmentVectorTemp();
			
			// r = I - 2(I.N)*N
			code += "dp3 " + temp + ".w, " + this._sharedRegisters.viewDirFragment + ".xyz, " + this._sharedRegisters.normalFragment + ".xyz		\n" +
				"add " + temp + ".w, " + temp + ".w, " + temp + ".w											\n" +
				"mul " + temp + ".xyz, " + this._sharedRegisters.normalFragment + ".xyz, " + temp + ".w						\n" +
				"sub " + temp + ".xyz, " + temp + ".xyz, " + this._sharedRegisters.viewDirFragment + ".xyz					\n" +
                this.pGetTexCubeSampleCode(vo, temp, cubeMapReg, this._cubeTexture, temp) +
				"sub " + temp2 + ".w, " + temp + ".w, fc0.x									\n" +               	// -.5
				"kil " + temp2 + ".w\n" +	// used for real time reflection mapping - if alpha is not 1 (mock texture) kil output
				"sub " + temp + ", " + temp + ", " + targetReg + "											\n";
			
			if (this._mask) {
				var maskReg:ShaderRegisterElement = regCache.getFreeTextureReg();
				code += this.pGetTex2DSampleCode(vo, temp2, maskReg, this._mask, this._sharedRegisters.uvVarying) +
					"mul " + temp + ", " + temp2 + ", " + temp + "\n";
			}
			code += "mul " + temp + ", " + temp + ", " + dataRegister + ".x										\n" +
				"add " + targetReg + ", " + targetReg + ", " + temp + "										\n";
			
			regCache.removeFragmentTempUsage(temp);
			
			return code;
		}
	}
}
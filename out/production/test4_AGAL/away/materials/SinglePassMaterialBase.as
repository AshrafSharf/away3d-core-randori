/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials
{
	import away.materials.passes.SuperShaderPass;
	import away.core.display.BlendMode;
	import away.managers.Stage3DProxy;
	import away.cameras.Camera3D;
	import away.core.geom.ColorTransform;
	import away.materials.methods.BasicAmbientMethod;
	import away.materials.methods.ShadowMapMethodBase;
	import away.materials.methods.BasicDiffuseMethod;
	import away.materials.methods.BasicNormalMethod;
	import away.materials.methods.BasicSpecularMethod;
	import away.materials.methods.EffectMethodBase;
	import away.textures.Texture2DBase;
	import away.errors.Error;
	import away.core.display3D.Context3D;
	import away.materials.lightpickers.LightPickerBase;

	/**
	public class SinglePassMaterialBase extends MaterialBase
	{
		public var _pScreenPass:SuperShaderPass;
		private var _alphaBlending:Boolean = false;
		
		/**
		public function SinglePassMaterialBase():void
		{
			super();

            this.pAddPass( this._pScreenPass = new SuperShaderPass(this) );
		}
		
		/**
		public function get enableLightFallOff():Boolean
		{
			return this._pScreenPass.enableLightFallOff;
		}
		
		public function set enableLightFallOff(value:Boolean):void
		{
            this._pScreenPass.enableLightFallOff = value;
		}
		
		/**
		public function get alphaThreshold():Number
		{

			return this._pScreenPass.diffuseMethod.alphaThreshold;

		}
		
		public function set alphaThreshold(value:Number):void
		{



            this._pScreenPass.diffuseMethod.alphaThreshold = value;

            this._pDepthPass.alphaThreshold = value;
            this._pDistancePass.alphaThreshold = value;


		}

		/**
		override public function set blendMode(value:String):void
		{

            super.setBlendMode( value );
			this._pScreenPass.setBlendMode( ( this._pBlendMode == BlendMode.NORMAL ) && this.requiresBlending?  BlendMode.LAYER : this._pBlendMode);

		}

		/**
		override public function set depthCompareMode(value:String):void
		{

			this._pDepthCompareMode = value;
			this._pScreenPass.depthCompareMode = value;
		}

		/**
		override public function iActivateForDepth(stage3DProxy:Stage3DProxy, camera:Camera3D, distanceBased:Boolean = false):void
		{
			distanceBased = distanceBased || false;


			if (distanceBased){

                this._pDistancePass.alphaMask = this._pScreenPass.diffuseMethod.texture;

            }
			else
            {

                this._pDepthPass.alphaMask = this._pScreenPass.diffuseMethod.texture;

            }

			super.iActivateForDepth(stage3DProxy, camera, distanceBased);

		}

		/**
		public function get specularLightSources():Number
		{
			return this._pScreenPass.specularLightSources;
		}
		
		public function set specularLightSources(value:Number):void
		{
			this._pScreenPass.specularLightSources = value;
		}

		/**
		public function get diffuseLightSources():Number
		{
			return this._pScreenPass.diffuseLightSources;
		}
		
		public function set diffuseLightSources(value:Number):void
		{
            this._pScreenPass.diffuseLightSources = value;
		}

		/**
		override public function get requiresBlending():Boolean
		{
			return this.getRequiresBlending();
		}

        override public function getRequiresBlending():Boolean
        {

            var ct : ColorTransform = this._pScreenPass.colorTransform;

            if ( ct )
            {
                return ( this._pBlendMode != BlendMode.NORMAL ) || this._alphaBlending || ( ct.alphaMultiplier < 1);
            }
            return ( this._pBlendMode != BlendMode.NORMAL ) || this._alphaBlending ;

            //return super.getRequiresBlending() || this._alphaBlending || ( this._pScreenPass.colorTransform && this._pScreenPass.colorTransform.alphaMultiplier < 1);

        }

		/**
		public function get colorTransform():ColorTransform
		{
			return this._pScreenPass.colorTransform;
		}

        public function set colorTransform(value:ColorTransform):void
        {
            this.setColorTransform( value )
        }

        public function setColorTransform(value:ColorTransform):void
        {
            this._pScreenPass.colorTransform = value;
        }

		/**

		public function get ambientMethod():BasicAmbientMethod
		{
			return this._pScreenPass.ambientMethod;
		}
		
		public function set ambientMethod(value:BasicAmbientMethod):void
		{
			this._pScreenPass.ambientMethod = value;
		}

		/**
		public function get shadowMethod():ShadowMapMethodBase
		{
			return this._pScreenPass.shadowMethod;
		}
		
		public function set shadowMethod(value:ShadowMapMethodBase):void
		{
			this._pScreenPass.shadowMethod = value;
		}

		/**

		public function get diffuseMethod():BasicDiffuseMethod
		{
			return this._pScreenPass.diffuseMethod;
		}
		
		public function set diffuseMethod(value:BasicDiffuseMethod):void
		{
			this._pScreenPass.diffuseMethod = value;
		}

		/**

		public function get normalMethod():BasicNormalMethod
		{
			return this._pScreenPass.normalMethod;
		}
		
		public function set normalMethod(value:BasicNormalMethod):void
		{
			this._pScreenPass.normalMethod = value;
		}

		/**

		public function get specularMethod():BasicSpecularMethod
		{
			return this._pScreenPass.specularMethod;
		}
		
		public function set specularMethod(value:BasicSpecularMethod):void
		{
			this._pScreenPass.specularMethod = value;
		}

		/**
		public function addMethod(method:EffectMethodBase):void
		{
			this._pScreenPass.addMethod(method);
		}

		/**

		public function get numMethods():Number
		{
			return this._pScreenPass.numMethods;
		}

		/**
		public function hasMethod(method:EffectMethodBase):Boolean
		{
			return this._pScreenPass.hasMethod(method);
		}

		/**
		public function getMethodAt(index:Number):EffectMethodBase
		{
			return this._pScreenPass.getMethodAt(index);
		}

		/**
		public function addMethodAt(method:EffectMethodBase, index:Number):void
		{
			this._pScreenPass.addMethodAt(method, index);
		}

		/**
		public function removeMethod(method:EffectMethodBase):void
		{
			this._pScreenPass.removeMethod(method);
		}
		
		/**
		override public function set mipmap(value:Boolean):void
		{
			if (this._pMipmap == value)
				return;

			this.setMipMap( value );
		}

		/**
		public function get normalMap():Texture2DBase
		{
			return this._pScreenPass.normalMap;
		}
		
		public function set normalMap(value:Texture2DBase):void
		{
			this._pScreenPass.normalMap = value;
		}
		
		/**

		public function get specularMap():Texture2DBase
		{
			return this._pScreenPass.specularMethod.texture;
		}
		
		public function set specularMap(value:Texture2DBase):void
		{
			if (this._pScreenPass.specularMethod)
            {

                this._pScreenPass.specularMethod.texture = value;
            }
			else
            {

                throw new away.errors.Error("No specular method was set to assign the specularGlossMap to");

            }

		}

		/**

		public function get gloss():Number
		{
			return this._pScreenPass.specularMethod? this._pScreenPass.specularMethod.gloss : 0;
		}
		
		public function set gloss(value:Number):void
		{
			if (this._pScreenPass.specularMethod)
                this._pScreenPass.specularMethod.gloss = value;
		}

		/**

		public function get ambient():Number
		{
			return this._pScreenPass.ambientMethod.ambient;
		}
		
		public function set ambient(value:Number):void
		{
            this._pScreenPass.ambientMethod.ambient = value;
		}

		/**

		public function get specular():Number
		{
			return this._pScreenPass.specularMethod? this._pScreenPass.specularMethod.specular : 0;
		}
		
		public function set specular(value:Number):void
		{
			if (this._pScreenPass.specularMethod)
                this._pScreenPass.specularMethod.specular = value;
		}

		/**

		public function get ambientColor():Number
		{
			return this._pScreenPass.ambientMethod.ambientColor;
		}
		
		public function set ambientColor(value:Number):void
		{
            this._pScreenPass.ambientMethod.ambientColor = value;
		}

		/**

		public function get specularColor():Number
		{
			return this._pScreenPass.specularMethod.specularColor;
		}
		
		public function set specularColor(value:Number):void
		{
			this._pScreenPass.specularMethod.specularColor = value;
		}

		/**

        public function get alphaBlending():Boolean
		{

			return this._alphaBlending;

		}
		
		public function set alphaBlending(value:Boolean):void
		{

			this._alphaBlending = value;
			this._pScreenPass.setBlendMode(this.getBlendMode() == BlendMode.NORMAL && this.requiresBlending? BlendMode.LAYER : this.getBlendMode() );
			this._pScreenPass.preserveAlpha = this.requiresBlending;

		}
		
		/**
		override public function iUpdateMaterial(context:Context3D):void
		{
			if (this._pScreenPass._iPassesDirty)
            {

                this.pClearPasses();

				if (this._pScreenPass._iPasses)
                {

					var len:Number = this._pScreenPass._iPasses.length;

					for (var i:Number = 0; i < len; ++i)
                    {

                        this.pAddPass(this._pScreenPass._iPasses[i]);

                    }

				}
				
				this.pAddPass(this._pScreenPass);
				this._pScreenPass._iPassesDirty = false;
			}
		}

		/**
		override public function set lightPicker(value:LightPickerBase):void
		{

			super.setLightPicker( value );
			this._pScreenPass.lightPicker = value;
		}
	}
}
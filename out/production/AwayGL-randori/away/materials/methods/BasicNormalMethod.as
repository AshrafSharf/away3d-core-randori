/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.methods
{
	import away.textures.Texture2DBase;
	import away.materials.compilation.ShaderRegisterElement;
	import away.managers.Stage3DProxy;
	import away.core.display3D.Context3DWrapMode;
	import away.core.display3D.Context3DTextureFilter;
	import away.core.display3D.Context3DMipFilter;
	import away.materials.compilation.ShaderRegisterCache;

	/**
	public class BasicNormalMethod extends ShadingMethodBase
	{
		private var _texture:Texture2DBase;
		private var _useTexture:Boolean = false;
		public var _pNormalTextureRegister:ShaderRegisterElement;

		/**
		public function BasicNormalMethod():void
		{
			super();
		}

		/**
		override public function iInitVO(vo:MethodVO):void
		{
            if ( this._texture )
            {

                vo.needsUV = true;

            }
            else
            {

                vo.needsUV = false;

            }

			//vo.needsUV = Boolean(_texture);
		}

		/**
		public function get iTangentSpace():Boolean
		{
			return true;
		}
		
		/**
		public function get iHasOutput():Boolean
		{
			return this._useTexture;
		}

		/**
		override public function copyFrom(method:ShadingMethodBase):void
		{

            var s : * = method;
            var bnm : BasicNormalMethod = (method as BasicNormalMethod);

            this.normalMap = bnm.normalMap;

		}

		/**
		public function get normalMap():Texture2DBase
		{
			return this._texture;
		}
		
		public function set normalMap(value:Texture2DBase):void
		{

            this.setNormalMap( value );

		}

        public function setNormalMap(value:Texture2DBase):void
        {

            var b : Boolean =  ( value != null );

            if ( b != this._useTexture ||
                (value && this._texture && (value.hasMipMaps != this._texture.hasMipMaps || value.format != this._texture.format))) {
                this.iInvalidateShaderProgram();//invalidateShaderProgram();
            }
            this._useTexture = Boolean(value);
            this._texture = value;

        }

		/**
		override public function iCleanCompilationData():void
		{
			super.iCleanCompilationData();
			this._pNormalTextureRegister = null;
		}

		/**
		override public function dispose():void
		{
			if (this._texture)
            {

                this._texture = null;

            }

		}


		/**
		override public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
			if (vo.texturesIndex >= 0)
            {

                stage3DProxy._iContext3D.setSamplerStateAt( vo.texturesIndex ,
                        vo.repeatTextures ?  Context3DWrapMode.REPEAT :  Context3DWrapMode.CLAMP,
                        vo.useSmoothTextures ? Context3DTextureFilter.LINEAR : Context3DTextureFilter.NEAREST ,
                        vo.useMipmapping ? Context3DMipFilter.MIPLINEAR : Context3DMipFilter.MIPNONE );
                stage3DProxy._iContext3D.setTextureAt( vo.texturesIndex, this._texture.getTextureForStage3D(stage3DProxy));

            }

		}

		/**
		public function iGetFragmentCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			this._pNormalTextureRegister = regCache.getFreeTextureReg();

			vo.texturesIndex = this._pNormalTextureRegister.index;

            // TODO: AGAL <> GLSL

			return this.pGetTex2DSampleCode(vo, targetReg, this._pNormalTextureRegister, this._texture) +
				"sub " + targetReg.toString() + ".xyz, " + targetReg.toString() + ".xyz, " + this._sharedRegisters.commons.toString() + ".xxx	\n" +
				"nrm " + targetReg.toString() + ".xyz, " + targetReg.toString() + ".xyz							\n";

		}
	}
}
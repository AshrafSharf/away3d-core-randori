///<reference path="../../_definitions.ts"/>

package away.materials.methods
{
	import away.events.ShadingMethodEvent;
	import away.materials.passes.MaterialPassBase;
	import away.textures.Texture2DBase;
	import away.managers.Stage3DProxy;
	import away.materials.compilation.ShaderRegisterData;
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterElement;
	
	/**
	public class CompositeSpecularMethod extends BasicSpecularMethod
	{
		private var _baseMethod:BasicSpecularMethod;
		
		/**
		public function CompositeSpecularMethod():void
		{
			super();

            /*

		}

        public function initCompositeSpecularMethod(scope:Object, modulateMethod:Function, baseSpecularMethod:BasicSpecularMethod = null):void
        {
			baseSpecularMethod = baseSpecularMethod || null;


            this._baseMethod = baseSpecularMethod || new BasicSpecularMethod();
            this._baseMethod._iModulateMethod = modulateMethod;
            this._baseMethod._iModulateMethodScope = scope;
            this._baseMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );

        }

		/**
		override public function iInitVO(vo:MethodVO):void
		{
			this._baseMethod.iInitVO(vo);
		}

		/**
		override public function iInitConstants(vo:MethodVO):void
		{
			this._baseMethod.iInitConstants(vo);
		}
		
		/**
		public function get baseMethod():BasicSpecularMethod
		{
			return this._baseMethod;
		}
		
		public function set baseMethod(value:BasicSpecularMethod):void
		{
			if (this._baseMethod == value)
				return;
            this._baseMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );
            this._baseMethod = value;
            this._baseMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated, this);
            this.iInvalidateShaderProgram();
		}
		
		/**
		override public function get gloss():Number
		{
			return this._baseMethod.gloss;
		}
		
		override public function set gloss(value:Number):void
		{
			this._baseMethod.gloss = value;
		}
		
		/**
		override public function get specular():Number
		{
			return this._baseMethod.specular;
		}
		
		override public function set specular(value:Number):void
		{
			this._baseMethod.specular = value;
		}
		
		/**
		override public function get passes():Vector.<MaterialPassBase>
		{
			return this._baseMethod.passes;
		}
		
		/**
		override public function dispose():void
		{
			this._baseMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );
			this._baseMethod.dispose();
		}
		
		/**
		override public function get texture():Texture2DBase
		{
			return this._baseMethod.texture;
		}
		
		override public function set texture(value:Texture2DBase):void
		{
			this._baseMethod.texture = value;
		}
		
		/**
		override public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
			this._baseMethod.iActivate(vo, stage3DProxy);
		}

		/**
		override public function iDeactivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
			this._baseMethod.iDeactivate(vo, stage3DProxy);
		}
		
		/**
        override public function set iSharedRegisters(value:ShaderRegisterData):void
        {
            super.setISharedRegisters( value );
            this._baseMethod.setISharedRegisters(value );
        }
        override public function setISharedRegisters(value:ShaderRegisterData):void
        {
            super.setISharedRegisters( value );
            this._baseMethod.setISharedRegisters(value );
        }
		
		/**
		override public function iGetVertexCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			return this._baseMethod.iGetVertexCode(vo, regCache);
		}
		
		/**
		override public function iGetFragmentPreLightingCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			return this._baseMethod.iGetFragmentPreLightingCode(vo, regCache);
		}
		
		/**
		override public function iGetFragmentCodePerLight(vo:MethodVO, lightDirReg:ShaderRegisterElement, lightColReg:ShaderRegisterElement, regCache:ShaderRegisterCache):String
		{
			return this._baseMethod.iGetFragmentCodePerLight(vo, lightDirReg, lightColReg, regCache);
		}
		
		/**
		override public function iGetFragmentCodePerProbe(vo:MethodVO, cubeMapReg:ShaderRegisterElement, weightRegister:String, regCache:ShaderRegisterCache):String
		{
			return this._baseMethod.iGetFragmentCodePerProbe(vo, cubeMapReg, weightRegister, regCache);
		}
		
		/**
		override public function iGetFragmentPostLightingCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			return this._baseMethod.iGetFragmentPostLightingCode(vo, regCache, targetReg);
		}
		
		/**
		override public function iReset():void
		{
            this._baseMethod.iReset();
		}

		/**
		override public function iCleanCompilationData():void
		{
			super.iCleanCompilationData();
			this._baseMethod.iCleanCompilationData();
		}

		/**
		override public function set iShadowRegister(value:ShaderRegisterElement):void
		{

			this.setIShadowRegister( value );
			this._baseMethod.setIShadowRegister( value );
		}

		/**
		private function onShaderInvalidated(event:ShadingMethodEvent):void
		{
			this.iInvalidateShaderProgram();
		}
	}
}
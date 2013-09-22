///<reference path="../../_definitions.ts"/>
package away.materials.methods
{
	import away.events.ShadingMethodEvent;
	import away.textures.Texture2DBase;
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterElement;
	import away.managers.Stage3DProxy;
	import away.materials.compilation.ShaderRegisterData;

	/**
	public class CompositeDiffuseMethod extends BasicDiffuseMethod
	{
		public var pBaseMethod:BasicDiffuseMethod;

		/**
		public function CompositeDiffuseMethod(modulateMethod:Function = null, baseDiffuseMethod:BasicDiffuseMethod = null):void
		{
			modulateMethod = modulateMethod || null;
			baseDiffuseMethod = baseDiffuseMethod || null;


            super();

			this.pBaseMethod = baseDiffuseMethod || new BasicDiffuseMethod();
            this.pBaseMethod._iModulateMethod = modulateMethod;
            this.pBaseMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );
		}

		/**
		public function get baseMethod():BasicDiffuseMethod
		{
			return this.pBaseMethod;
		}

		public function set baseMethod(value:BasicDiffuseMethod):void
		{
			if (this.pBaseMethod == value)
				return;
            this.pBaseMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );
            this.pBaseMethod = value;
            this.pBaseMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated, this );
			this.iInvalidateShaderProgram();//invalidateShaderProgram();
		}

		/**
		override public function iInitVO(vo:MethodVO):void
		{
            this.pBaseMethod.iInitVO(vo);
		}

		/**
		override public function iInitConstants(vo:MethodVO):void
		{
            this.pBaseMethod.iInitConstants(vo);
		}
		
		/**
		override public function dispose():void
		{
            this.pBaseMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );
            this.pBaseMethod.dispose();
		}

		/**
		override public function get alphaThreshold():Number
		{
			return this.pBaseMethod.alphaThreshold;
		}
		
		override public function set alphaThreshold(value:Number):void
		{
            this.pBaseMethod.alphaThreshold = value;
		}
		
		/**
		override public function get texture():Texture2DBase
		{
			return this.pBaseMethod.texture;
		}
		
		/**
		override public function set texture(value:Texture2DBase):void
		{
            this.pBaseMethod.texture = value;
		}
		
		/**
		override public function get diffuseAlpha():Number
		{
			return this.pBaseMethod.diffuseAlpha;
		}
		
		/**
		override public function get diffuseColor():Number
		{
			return this.pBaseMethod.diffuseColor;
		}
		
		/**
		override public function set diffuseColor(diffuseColor:Number):void
		{
            this.pBaseMethod.diffuseColor = diffuseColor;
		}
		
		/**
		override public function set diffuseAlpha(value:Number):void
		{
            this.pBaseMethod.diffuseAlpha = value;
		}
		
		/**
		override public function iGetFragmentPreLightingCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			return this.pBaseMethod.iGetFragmentPreLightingCode(vo, regCache);
		}
		
		/**
		override public function iGetFragmentCodePerLight(vo:MethodVO, lightDirReg:ShaderRegisterElement, lightColReg:ShaderRegisterElement, regCache:ShaderRegisterCache):String
		{
			var code:String = this.pBaseMethod.iGetFragmentCodePerLight(vo, lightDirReg, lightColReg, regCache);
			this.pTotalLightColorReg = this.pBaseMethod.pTotalLightColorReg;
			return code;
		}
		
		/**
		override public function iGetFragmentCodePerProbe(vo:MethodVO, cubeMapReg:ShaderRegisterElement, weightRegister:String, regCache:ShaderRegisterCache):String
		{
			var code:String = this.pBaseMethod.iGetFragmentCodePerProbe(vo, cubeMapReg, weightRegister, regCache);
			this.pTotalLightColorReg = this.pBaseMethod.pTotalLightColorReg;
			return code;
		}
		
		/**
		override public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
            this.pBaseMethod.iActivate(vo, stage3DProxy);
		}

		/**
		override public function iDeactivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
            this.pBaseMethod.iDeactivate(vo, stage3DProxy);
		}
		
		/**
		override public function iGetVertexCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			return this.pBaseMethod.iGetVertexCode(vo, regCache);
		}
		
		/**
		override public function iGetFragmentPostLightingCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			return this.pBaseMethod.iGetFragmentPostLightingCode(vo, regCache, targetReg);
		}
		
		/**
		override public function iReset():void
		{
            this.pBaseMethod.iReset();
		}

		/**
		override public function iCleanCompilationData():void
		{
			super.iCleanCompilationData();
            this.pBaseMethod.iCleanCompilationData();
		}
		
		/**

        override public function set iSharedRegisters(value:ShaderRegisterData):void
        {
            this.pBaseMethod.setISharedRegisters( value );
            super.setISharedRegisters( value ) ;

        }

        override public function setISharedRegisters(value:ShaderRegisterData):void
        {
            this.pBaseMethod.setISharedRegisters( value );
            super.setISharedRegisters( value ) ;

        }

		/**
		override public function set iShadowRegister(value:ShaderRegisterElement):void
		{
			super.setIShadowRegister( value );
            this.pBaseMethod.setIShadowRegister( value );
		}

		/**
		private function onShaderInvalidated(event:ShadingMethodEvent):void
		{
			this.iInvalidateShaderProgram();
		}
	}
}
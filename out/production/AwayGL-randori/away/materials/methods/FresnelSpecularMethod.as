/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.methods
{
	import away.materials.compilation.ShaderRegisterElement;
	import away.managers.Stage3DProxy;
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterData;
	import randori.webkit.page.Window;

	/**
	public class FresnelSpecularMethod extends CompositeSpecularMethod
	{
		private var _dataReg:ShaderRegisterElement;
		private var _incidentLight:Boolean = false;
		private var _fresnelPower:Number = 5;
		private var _normalReflectance:Number = 028;// default value for skin
		
		/**
		public function FresnelSpecularMethod(basedOnSurface:Boolean = true, baseSpecularMethod:BasicSpecularMethod = null):void
		{
			baseSpecularMethod = baseSpecularMethod || null;

			// may want to offer diff speculars
			super();

            this.initCompositeSpecularMethod( this , modulateSpecular, baseSpecularMethod);
			this._incidentLight = !basedOnSurface;
		}

		/**
		override public function iInitConstants(vo:MethodVO):void
		{
            
			var index:Number = vo.secondaryFragmentConstantsIndex;
			vo.fragmentData[index + 2] = 1;
			vo.fragmentData[index + 3] = 0;
		}
		
		/**
		public function get basedOnSurface():Boolean
		{
			return !this._incidentLight;
		}
		
		public function set basedOnSurface(value:Boolean):void
		{
			if (this._incidentLight != value)
				return;
			
			this._incidentLight = !value;

            this.iInvalidateShaderProgram();
		}

		/**
		public function get fresnelPower():Number
		{
			return this._fresnelPower;
		}
		
		public function set fresnelPower(value:Number):void
		{
			this._fresnelPower = value;
		}

		/**
		override public function iCleanCompilationData():void
		{
			super.iCleanCompilationData();
			this._dataReg = null;
		}
		
		/**
		public function get normalReflectance():Number
		{
			return this._normalReflectance;
		}
		
		public function set normalReflectance(value:Number):void
		{
			this._normalReflectance = value;
		}
		
		/**
		override public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
			super.iActivate(vo, stage3DProxy);
			var fragmentData:Vector.<Number> = vo.fragmentData;

			var index:Number = vo.secondaryFragmentConstantsIndex;
			fragmentData[index] = this._normalReflectance;
			fragmentData[index + 1] = this._fresnelPower;
		}
		
		/**
		override public function iGetFragmentPreLightingCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			this._dataReg = regCache.getFreeFragmentConstant();

            Window.console.log( 'FresnelSpecularMethod' , 'iGetFragmentPreLightingCode' , this._dataReg ) ;

			vo.secondaryFragmentConstantsIndex = this._dataReg.index*4;
			return super.iGetFragmentPreLightingCode(vo, regCache);
		}
		
		/**
		private function modulateSpecular(vo:MethodVO, target:ShaderRegisterElement, regCache:ShaderRegisterCache, sharedRegisters:ShaderRegisterData):String
		{
			var code:String;
			
			code = "dp3 " + target + ".y, " + sharedRegisters.viewDirFragment + ".xyz, " + (this._incidentLight? target + ".xyz\n" : sharedRegisters.normalFragment + ".xyz\n") +   // dot(V, H)
				"sub " + target + ".y, " + this._dataReg + ".z, " + target + ".y\n" +             // base = 1-dot(V, H)
				"pow " + target + ".x, " + target + ".y, " + this._dataReg + ".y\n" +             // exp = pow(base, 5)
				"sub " + target + ".y, " + this._dataReg + ".z, " + target + ".y\n" +             // 1 - exp
				"mul " + target + ".y, " + this._dataReg + ".x, " + target + ".y\n" +             // f0*(1 - exp)
				"add " + target + ".y, " + target + ".x, " + target + ".y\n" +          // exp + f0*(1 - exp)
				"mul " + target + ".w, " + target + ".w, " + target + ".y\n";


            Window.console.log( 'FresnelSpecularMethod' , 'modulateSpecular' , code );

			return code;
		}
	
	}
}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.methods
{
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterElement;
	//import away3d.arcane;
	//import away3d.materials.compilation.ShaderRegisterCache;
	//import away3d.materials.compilation.ShaderRegisterElement;
	
	//use namespace arcane;
	
	/**
	public class LightingMethodBase extends ShadingMethodBase
	{
		/**
        public var _iModulateMethod;
        public var _iModulateMethodScope:Object;

		/**
		public function LightingMethodBase():void
		{
			super();
		}
		
		/**
		public function iGetFragmentPreLightingCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			return "";
		}
		
		/**
		public function iGetFragmentCodePerLight(vo:MethodVO, lightDirReg:ShaderRegisterElement, lightColReg:ShaderRegisterElement, regCache:ShaderRegisterCache):String
		{
			return "";
		}
		
		/**
		public function iGetFragmentCodePerProbe(vo:MethodVO, cubeMapReg:ShaderRegisterElement, weightRegister:String, regCache:ShaderRegisterCache):String
		{
			return "";
		}
		
		/**
		public function iGetFragmentPostLightingCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			return "";
		}
	}
}
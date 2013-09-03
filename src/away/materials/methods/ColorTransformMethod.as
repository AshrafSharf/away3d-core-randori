///<reference path="../../_definitions.ts"/>
package away.materials.methods
{
	import away.geom.ColorTransform;
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterElement;
	import away.managers.Stage3DProxy;
	//import away3d.arcane;
	//import away3d.managers.Stage3DProxy;
	//import away3d.materials.compilation.ShaderRegisterCache;
	//import away3d.materials.compilation.ShaderRegisterElement;
	
	//import flash.geom.ColorTransform;
	
	//use namespace arcane;
	
	/**
	public class ColorTransformMethod extends EffectMethodBase
	{
		private var _colorTransform:ColorTransform;
		
		/**
		public function ColorTransformMethod():void
		{
			super();
		}
		
		/**
		public function get colorTransform():ColorTransform
		{
			return _colorTransform;
		}
		
		public function set colorTransform(value:ColorTransform):void
		{
            this._colorTransform = value;
		}
		
		/**
		override public function iGetFragmentCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			var code:String = "";
			var colorMultReg:ShaderRegisterElement = regCache.getFreeFragmentConstant();
			var colorOffsReg:ShaderRegisterElement = regCache.getFreeFragmentConstant();

			vo.fragmentConstantsIndex = colorMultReg.index*4;

            //TODO: AGAL <> GLSL

			code += "mul " + targetReg.toString() + ", " + targetReg.toString() + ", " + colorMultReg.toString() + "\n" +
				"add " + targetReg.toString() + ", " + targetReg.toString() + ", " + colorOffsReg.toString() + "\n";

			return code;
		}
		
		/**
		override public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
			var inv:Number = 1/0xff;
			var index:Number = vo.fragmentConstantsIndex;
			var data:Vector.<Number> = vo.fragmentData;

			data[index] = _colorTransform.redMultiplier;
			data[index + 1] = _colorTransform.greenMultiplier;
			data[index + 2] = _colorTransform.blueMultiplier;
			data[index + 3] = _colorTransform.alphaMultiplier;
			data[index + 4] = _colorTransform.redOffset*inv;
			data[index + 5] = _colorTransform.greenOffset*inv;
			data[index + 6] = _colorTransform.blueOffset*inv;
			data[index + 7] = _colorTransform.alphaOffset*inv;

		}
	}
}
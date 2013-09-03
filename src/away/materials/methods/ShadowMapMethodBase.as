///<reference path="../../_definitions.ts"/>

package away.materials.methods
{
	import away.library.assets.IAsset;
	import away.lights.LightBase;
	import away.lights.shadowmaps.ShadowMapperBase;
	import away.library.assets.AssetType;
	import away.materials.compilation.ShaderRegisterCache;
	import away.materials.compilation.ShaderRegisterElement;
	import away.errors.AbstractMethodError;
	//import away3d.*;
	//import away3d.errors.*;
	//import away3d.library.assets.*;
	//import away3d.lights.*;
	//import away3d.lights.shadowmaps.*;
	//import away3d.materials.compilation.*;
	
	//use namespace arcane;

	/**
	public class ShadowMapMethodBase extends ShadingMethodBase implements IAsset
	{
		private var _castingLight:LightBase;
		private var _shadowMapper:ShadowMapperBase;
		
		private var _epsilon:Number = 02;
		private var _alpha:Number = 1;

		/**
		public function ShadowMapMethodBase(castingLight:LightBase):void
		{
			super();
			this._castingLight = castingLight;
			castingLight.castsShadows = true;
            this._shadowMapper = castingLight.shadowMapper;

		}

		/**
		override public function get assetType():String
		{
			return AssetType.SHADOW_MAP_METHOD;
		}

		/**
		public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha(value:Number):void
		{
            this._alpha = value;
		}

		/**
		public function get castingLight():LightBase
		{
			return _castingLight;
		}

		/**
		public function get epsilon():Number
		{
			return _epsilon;
		}
		
		public function set epsilon(value:Number):void
		{
            this._epsilon = value;
		}

		/**
		public function iGetFragmentCode(vo:MethodVO, regCache:ShaderRegisterCache, targetReg:ShaderRegisterElement):String
		{
			throw new AbstractMethodError();
			return null;
		}
	}
}
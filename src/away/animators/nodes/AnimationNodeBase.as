///<reference path="../../_definitions.ts"/>
package away.animators.nodes
{
	import away.library.assets.NamedAssetBase;
	import away.library.assets.IAsset;
	import away.library.assets.AssetType;

	/**
	public class AnimationNodeBase extends NamedAssetBase implements IAsset
	{
		private var _stateClass:*;
		
		public function get stateClass():*
		{
			return _stateClass;
		}
		
		/**
		public function AnimationNodeBase():void
		{

            super();

		}
		
		/**
		override public function dispose():void
		{
		}
		
		/**
		override public function get assetType():String
		{
			return AssetType.ANIMATION_NODE;
		}
	}
}
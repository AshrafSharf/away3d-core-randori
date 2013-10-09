/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

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
			return this._stateClass;
		}
		
		/**
		public function AnimationNodeBase():void
		{

            super(null);

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
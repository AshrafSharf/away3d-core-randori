
///<reference path="../../_definitions.ts"/>

package away.library.naming
{
	import away.library.assets.IAsset;
	import away.errors.AbstractMethodError;
	import away.events.AssetEvent;

	/**
	public class ConflictStrategyBase
	{
		
		public function ConflictStrategyBase():void
		{
		}
		
		/**
		public function resolveConflict(changedAsset:IAsset, oldAsset:IAsset, assetsDictionary:Object, precedence:String):void
		{

			throw new AbstractMethodError();

		}
		
		/**
		public function create():ConflictStrategyBase
		{

            throw new AbstractMethodError();

		}
		
		/**
		public function _pUpdateNames(ns:String, nonConflictingName:String, oldAsset:IAsset, newAsset:IAsset, assetsDictionary:Object, precedence:String):void
		{
			var loser_prev_name : String;
			var winner : IAsset;
            var loser : IAsset;
			
			winner = (precedence === ConflictPrecedence.FAVOR_NEW)? newAsset : oldAsset;
			loser = (precedence === ConflictPrecedence.FAVOR_NEW)? oldAsset : newAsset;
			
			loser_prev_name = loser.name;
			
			assetsDictionary[winner.name] = winner;
			assetsDictionary[nonConflictingName] = loser;
			loser.resetAssetPath(nonConflictingName, ns, false);
			
			loser.dispatchEvent(new AssetEvent( AssetEvent.ASSET_CONFLICT_RESOLVED, loser, loser_prev_name));
		}
	}
}
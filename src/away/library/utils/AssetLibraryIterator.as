
///<reference path="../../_definitions.ts"/>

package away.library.utils
{
	import away.library.assets.IAsset;
	//import away3d.library.assets.IAsset;
	
	public class AssetLibraryIterator
	{

        private var _assets:Vector.<IAsset>;//private  _assets:Vector.<IAsset>;
		private var _idx:Number;
		
		public function AssetLibraryIterator(assets:Vector.<IAsset>, assetTypeFilter:String, namespaceFilter:String, filterFunc):void
		{
			this._assets = assets;
			this.filter(assetTypeFilter, namespaceFilter, filterFunc);
		}
		
		public function get currentAsset():IAsset
		{
			// Return current, or null if no current
			return ( _idx < _filtered.length ) ? _filtered[ _idx ] : null;
		}
		
		public function get numAssets():Number
		{
			return _filtered.length;
		}
		
		public function next():IAsset
		{
			var next:IAsset = null;
			
			if (_idx < _filtered.length)
				next = _filtered[_idx];

            _idx++;
			
			return next;
		}
		
		public function reset():void
		{
            _idx = 0;
		}
		
		public function setIndex(index:Number):void
		{
            _idx = index;
		}
		
		private function filter(assetTypeFilter:String, namespaceFilter:String, filterFunc):void
		{
			if (assetTypeFilter || namespaceFilter) {

				var idx:Number;
				var asset:IAsset;


				idx = 0;
                _filtered = new Vector.<IAsset>();//new Vector.<IAsset>;

                var l : Number = _assets.length;

                for ( var c : Number = 0 ; c < l ; c ++ )
                {

                    asset = IAsset(_assets[c]);

                    // Skip this assets if filtering on type and this is wrong type
                    if (assetTypeFilter && asset.assetType != assetTypeFilter)
                        continue;

                    // Skip this asset if filtering on namespace and this is wrong namespace
                    if (namespaceFilter && asset.assetNamespace != namespaceFilter)
                        continue;

                    // Skip this asset if a filter func has been provided and it returns false
                    if (filterFunc != null && !filterFunc(asset))
                        continue;

                    _filtered[idx++] = asset;

                }

                /*

			} else {

                _filtered = _assets;

            }

		}
	}
}
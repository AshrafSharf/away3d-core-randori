///<reference path="../../_definitions.ts"/>


package away.library.naming
{
	import away.library.assets.IAsset;

	public class NumSuffixConflictStrategy extends ConflictStrategyBase
	{
		private var _separator:String;
		private var _next_suffix:Object;
		
		public function NumSuffixConflictStrategy(separator:String = '.'):void
		{
			super();
			
			_separator = separator;
            _next_suffix = {};
		}
		
		override public function resolveConflict(changedAsset:IAsset, oldAsset:IAsset, assetsDictionary:Object, precedence:String):void
		{
			var orig        : String;
			var new_name    : String;
			var base        : String;
            var suffix      : Number;
			
			orig = changedAsset.name;

			if (orig.indexOf(_separator) >= 0)
            {
				// Name has an ocurrence of the separator, so get base name and suffix,
				// unless suffix is non-numerical, in which case revert to zero and 
				// use entire name as base
				base    = orig.substring(0, orig.lastIndexOf(_separator));
				suffix  = parseInt(orig.substring(base.length - 1));

				if (isNaN(suffix))
                {
					base = orig;
					suffix = 0;
				}

			}
            else
            {
				base = orig;
				suffix = 0;
			}
			
			if (suffix == 0 && _next_suffix.hasOwnProperty(base))
            {

                suffix = _next_suffix[base];

            }

			// Find the first suffixed name that does
			// not collide with other names.
			do {

				suffix++;

				new_name = base.concat( _separator , suffix.toString() );

			} while (assetsDictionary.hasOwnProperty( new_name ) );
			
			_next_suffix[ base ] = suffix;
			_pUpdateNames( oldAsset.assetNamespace, new_name, oldAsset, changedAsset, assetsDictionary, precedence);

		}
		
		override public function create():ConflictStrategyBase
		{
			return new NumSuffixConflictStrategy( _separator );
		}
	}
}

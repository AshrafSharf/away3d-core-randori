package away.loaders.misc
{

	public class AssetLoaderContext
	{
		public static var UNDEFINED:Number = 0;
		public static var SINGLEPASS_MATERIALS:Number = 1;
		public static var MULTIPASS_MATERIALS:Number = 2;

		private var _includeDependencies:Boolean;
		private var _dependencyBaseUrl:String;
		private var _embeddedDataByUrl:Object;
		private var _remappedUrls:Object;
		private var _materialMode:Number;
		
		private var _overrideAbsPath:Boolean;
		private var _overrideFullUrls:Boolean;
		
		/**
		public function AssetLoaderContext(includeDependencies:Boolean = true, dependencyBaseUrl:String = null):void
		{
			this._includeDependencies   = includeDependencies;
            this._dependencyBaseUrl     = dependencyBaseUrl || '';
            this._embeddedDataByUrl     = {};
            this._remappedUrls          = {};
            this._materialMode          = AssetLoaderContext.UNDEFINED;
		}
		
		/**
		public function get includeDependencies():Boolean
		{
			return _includeDependencies;
		}
		
		public function set includeDependencies(val:Boolean):void
		{
            this._includeDependencies = val;
		}
		
		/**
		public function get materialMode():Number
		{
			return _materialMode;
		}
		
		public function set materialMode(materialMode:Number):void
		{
            this._materialMode = materialMode;
		}
		
		/**
		public function get dependencyBaseUrl():String
		{
			return _dependencyBaseUrl;
		}
		
		public function set dependencyBaseUrl(val:String):void
		{
            this._dependencyBaseUrl = val;
		}
		
		/**
		public function get overrideAbsolutePaths():Boolean
		{
			return _overrideAbsPath;
		}
		
		public function set overrideAbsolutePaths(val:Boolean):void
		{
            this._overrideAbsPath = val;
		}
		
		/**
		public function get overrideFullURLs():Boolean
		{
			return _overrideFullUrls;
		}
		
		public function set overrideFullURLs(val:Boolean):void
		{
            this._overrideFullUrls = val;
		}
		
		/**
		public function mapUrl(originalUrl:String, newUrl:String):void
		{
            _remappedUrls[originalUrl] = newUrl;
		}
		
		/**
		public function mapUrlToData(originalUrl:String, data:*):void
		{
			_embeddedDataByUrl[originalUrl] = data;
		}
		
		/**
		public function _iHasDataForUrl(url:String):Boolean
		{
			return _embeddedDataByUrl.hasOwnProperty(url);
		}
		
		/**
		public function _iGetDataForUrl(url:String):*
		{
			return _embeddedDataByUrl[url];
		}
		
		/**
		public function _iHasMappingForUrl(url:String):Boolean
		{
			return _remappedUrls.hasOwnProperty(url);
		}
		
		/**
		public function _iGetRemappedUrl(originalUrl:String):String
		{
			return _remappedUrls[originalUrl];
		}
	}
}
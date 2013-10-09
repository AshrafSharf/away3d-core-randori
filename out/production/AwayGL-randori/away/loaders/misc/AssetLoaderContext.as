/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.misc
{

	public class AssetLoaderContext
	{
		public static var UNDEFINED:Number = 0;
		public static var SINGLEPASS_MATERIALS:Number = 1;
		public static var MULTIPASS_MATERIALS:Number = 2;

		private var _includeDependencies:Boolean = false;
		private var _dependencyBaseUrl:String = null;
		private var _embeddedDataByUrl:Object;
		private var _remappedUrls:Object;
		private var _materialMode:Number = 0;
		
		private var _overrideAbsPath:Boolean = false;
		private var _overrideFullUrls:Boolean = false;
		
		/**
		public function AssetLoaderContext(includeDependencies:Boolean = true, dependencyBaseUrl:String = null):void
		{
			dependencyBaseUrl = dependencyBaseUrl || null;

			this._includeDependencies   = includeDependencies;
            this._dependencyBaseUrl     = dependencyBaseUrl || '';
            this._embeddedDataByUrl     = {};
            this._remappedUrls          = {};
            this._materialMode          = AssetLoaderContext.UNDEFINED;
		}
		
		/**
		public function get includeDependencies():Boolean
		{
			return this._includeDependencies;
		}
		
		public function set includeDependencies(val:Boolean):void
		{
            this._includeDependencies = val;
		}
		
		/**
		public function get materialMode():Number
		{
			return this._materialMode;
		}
		
		public function set materialMode(materialMode:Number):void
		{
            this._materialMode = materialMode;
		}
		
		/**
		public function get dependencyBaseUrl():String
		{
			return this._dependencyBaseUrl;
		}
		
		public function set dependencyBaseUrl(val:String):void
		{
            this._dependencyBaseUrl = val;
		}
		
		/**
		public function get overrideAbsolutePaths():Boolean
		{
			return this._overrideAbsPath;
		}
		
		public function set overrideAbsolutePaths(val:Boolean):void
		{
            this._overrideAbsPath = val;
		}
		
		/**
		public function get overrideFullURLs():Boolean
		{
			return this._overrideFullUrls;
		}
		
		public function set overrideFullURLs(val:Boolean):void
		{
            this._overrideFullUrls = val;
		}
		
		/**
		public function mapUrl(originalUrl:String, newUrl:String):void
		{
            this._remappedUrls[originalUrl] = newUrl;
		}
		
		/**
		public function mapUrlToData(originalUrl:String, data:*):void
		{
			this._embeddedDataByUrl[originalUrl] = data;
		}
		
		/**
		public function _iHasDataForUrl(url:String):Boolean
		{
			return this._embeddedDataByUrl.hasOwnProperty(url);
		}
		
		/**
		public function _iGetDataForUrl(url:String):*
		{
			return this._embeddedDataByUrl[url];
		}
		
		/**
		public function _iHasMappingForUrl(url:String):Boolean
		{
			return this._remappedUrls.hasOwnProperty(url);
		}
		
		/**
		public function _iGetRemappedUrl(originalUrl:String):String
		{
			return this._remappedUrls[originalUrl];
		}
	}
}
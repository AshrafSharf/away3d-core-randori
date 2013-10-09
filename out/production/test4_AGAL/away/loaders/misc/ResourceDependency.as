/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.misc
{
	import away.core.net.URLRequest;
	import away.library.assets.IAsset;
	import away.loaders.parsers.ParserBase;
	//import away3d.arcane;
	//import away3d.library.assets.IAsset;
	//import away3d.loaders.parsers.ParserBase;
	
	//import flash.net.URLRequest;

	//use namespace arcane;
	
	/**
	public class ResourceDependency
	{
		private var _id:String = null;
		private var _req:URLRequest;
		private var _assets:Vector.<IAsset>;//Vector.<IAsset>
		private var _parentParser:ParserBase;
		private var _data:*;
		private var _retrieveAsRawData:Boolean = false;
		private var _suppressAssetEvents:Boolean = false;
		private var _dependencies:Vector.<ResourceDependency>;

		public var _iLoader:SingleFileLoader;
		public var _iSuccess:Boolean = false;

		
		public function ResourceDependency(id:String, req:URLRequest, data:*, parentParser:ParserBase, retrieveAsRawData:Boolean = false, suppressAssetEvents:Boolean = false):void
		{
			retrieveAsRawData = retrieveAsRawData || false;
			suppressAssetEvents = suppressAssetEvents || false;


			this._id = id;
            this._req = req;
            this._parentParser = parentParser;
            this._data = data;
            this._retrieveAsRawData = retrieveAsRawData;
            this._suppressAssetEvents = suppressAssetEvents;

            this._assets = new Vector.<IAsset>();//new Vector.<IAsset>();
            this._dependencies = new Vector.<ResourceDependency>();
		}
		
		
		public function get id():String
		{
			return this._id;
		}
		
		
		public function get assets():Vector.<IAsset>//Vector.<IAsset>
			return this._assets;
		}
		
		
		public function get dependencies():Vector.<ResourceDependency>//Vector.<ResourceDependency>
			return this._dependencies;
		}
		
		
		public function get request():URLRequest
		{
			return this._req;
		}
		
		
		public function get retrieveAsRawData():Boolean
		{
			return this._retrieveAsRawData;
		}
		
		
		public function get suppresAssetEvents():Boolean
		{
			return this._suppressAssetEvents;
		}
		
		
		/**
		public function get data():*
		{
			return this._data;
		}
		
		
		/**
		public function _iSetData(data:*):void
		{
			this._data = data;
		}
		
		/**
		public function get parentParser():ParserBase
		{
			return this._parentParser;
		}
		
		/**
		public function resolve():void
		{

			if (this._parentParser) this._parentParser._iResolveDependency(this);
		}
		
		/**
		public function resolveFailure():void
		{
			if (this._parentParser) this._parentParser._iResolveDependencyFailure(this);
		}
		
		/**
		public function resolveName(asset:IAsset):String
		{
			if (this._parentParser) return this._parentParser._iResolveDependencyName(this, asset);
			return asset.name;
		}
		
	}
}
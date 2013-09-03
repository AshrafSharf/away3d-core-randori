


///<reference path="../../_definitions.ts"/>

package away.loaders.misc
{
	import away.net.URLRequest;
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
		private var _id:String;
		private var _req:URLRequest;
		private var _assets:Vector.<IAsset>;//Vector.<IAsset>;
		private var _data:*;
		private var _retrieveAsRawData:Boolean;
		private var _suppressAssetEvents:Boolean;
		private var _dependencies:Vector.<ResourceDependency>;

		public var _iLoader:SingleFileLoader;
		public var _iSuccess:Boolean;

		
		public function ResourceDependency(id:String, req:URLRequest, data:*, parentParser:ParserBase, retrieveAsRawData:Boolean = false, suppressAssetEvents:Boolean = false):void
		{

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
			return _id;
		}
		
		
		public function get assets():Vector.<IAsset>//Vector.<IAsset>
			return _assets;
		}
		
		
		public function get dependencies():Vector.<ResourceDependency>//Vector.<ResourceDependency>
			return _dependencies;
		}
		
		
		public function get request():URLRequest
		{
			return _req;
		}
		
		
		public function get retrieveAsRawData():Boolean
		{
			return _retrieveAsRawData;
		}
		
		
		public function get suppresAssetEvents():Boolean
		{
			return _suppressAssetEvents;
		}
		
		
		/**
		public function get data():*
		{
			return _data;
		}
		
		
		/**
		public function _iSetData(data:*):void
		{
			_data = data;
		}
		
		/**
		public function get parentParser():ParserBase
		{
			return _parentParser;
		}
		
		/**
		public function resolve():void
		{

			if (_parentParser) _parentParser._iResolveDependency(this);
		}
		
		/**
		public function resolveFailure():void
		{
			if (_parentParser) _parentParser._iResolveDependencyFailure(this);
		}
		
		/**
		public function resolveName(asset:IAsset):String
		{
			if (_parentParser) return _parentParser._iResolveDependencyName(this, asset);
			return asset.name;
		}
		
	}
}
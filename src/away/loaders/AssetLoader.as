

///<reference path="../_definitions.ts"/>

package away.loaders
{
	import away.events.EventDispatcher;
	import away.loaders.misc.AssetLoaderContext;
	import away.loaders.misc.AssetLoaderToken;
	import away.loaders.misc.ResourceDependency;
	import away.loaders.misc.SingleFileLoader;
	import away.net.URLRequest;
	import away.loaders.parsers.ParserBase;
	import away.events.LoaderEvent;
	import away.errors.Error;
	import away.events.ParserEvent;
	import away.events.AssetEvent;
	//import away3d.*;
	//import away3d.events.*;
	//import away3d.loaders.misc.*;
	//import away3d.loaders.parsers.*;
	
	//import flash.events.*;
	//import flash.net.*;
	
	//use namespace arcane;
	
	/**
	//[Event(name="assetComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="resourceComplete", type="away3d.events.LoaderEvent")]
	
	
	/**
	//[Event(name="dependencyComplete", type="away3d.events.LoaderEvent")]
	
	
	/**
	//[Event(name="loadError", type="away3d.events.LoaderEvent")]
	
	
	/**
	//[Event(name="parseError", type="away3d.events.ParserEvent")]
	
	
	/**
	//[Event(name="skyboxComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="cameraComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="meshComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="geometryComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="skeletonComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="skeletonPoseComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="containerComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="textureComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="textureProjectorComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="materialComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animatorComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animationSetComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animationStateComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animationNodeComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="stateTransitionComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="lightComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="lightPickerComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="effectMethodComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="shadowMapMethodComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="textureSizeError", type="away3d.events.AssetEvent")]
	
	/**
	public class AssetLoader extends EventDispatcher
	{
		private var _context:AssetLoaderContext;
		private var _token:AssetLoaderToken;
		private var _uri:String;
		
		private var _errorHandlers:Vector.<Function>;//Vector.<Function>;
		private var _stack:Vector.<ResourceDependency>;//Vector.<ResourceDependency>;
		private var _loadingDependency:ResourceDependency;
		private var _namespace:String;
		
		/**
		public function get baseDependency():ResourceDependency
		{
			return _baseDependency;
		}
		
		/**
		public function AssetLoader():void
		{
            super();

			this._stack                 = new Vector.<ResourceDependency>();
            this._errorHandlers         = new Vector.<Function>();
            this._parseErrorHandlers    = new Vector.<Function>();
		}
		
		/**
		public static function enableParser(parserClass):void
		{
			SingleFileLoader.enableParser( parserClass );
		}
		
		/**

		public static function enableParsers(parserClasses:Vector.<Object>):void
		{

			SingleFileLoader.enableParsers(parserClasses);

		}
		
		/**
		public function load(req:URLRequest, context:AssetLoaderContext = null, ns:String = null, parser:ParserBase = null):AssetLoaderToken
		{
			if ( ! _token ) {

				_token = new AssetLoaderToken(this);
				
				_uri       = req.url = req.url.replace(/\\/g, "/");
				_context   = context;
				_namespace = ns;
				
				_baseDependency = new ResourceDependency( '' , req , null , null );
				retrieveDependency( _baseDependency , parser );
				
				return _token;
			}
			
			// TODO: Throw error (already loading)
			return null;
		}
		
		/**
		public function loadData(data:*, id:String, context:AssetLoaderContext = null, ns:String = null, parser:ParserBase = null):AssetLoaderToken
		{
			if (!_token) {
				_token = new AssetLoaderToken(this);
				
				_uri = id;
                _context = context;
                _namespace = ns;

                _baseDependency = new ResourceDependency(id, null, data, null);
                retrieveDependency(_baseDependency, parser);
				
				return _token;
			}
			
			// TODO: Throw error (already loading)
			return null;
		}
		
		/**
		private function retrieveNext(parser:ParserBase = null):void
		{
			if (_loadingDependency.dependencies.length) {

				var dep:ResourceDependency = _loadingDependency.dependencies.pop();

                _stack.push(_loadingDependency);
                retrieveDependency(dep);

			} else if (_loadingDependency._iLoader.parser && _loadingDependency._iLoader.parser.parsingPaused) {

                _loadingDependency._iLoader.parser._iResumeParsingAfterDependencies();//resumeParsingAfterDependencies();
                _stack.pop();

			} else if (_stack.length) {

				var prev:ResourceDependency = _loadingDependency;

                _loadingDependency = _stack.pop();
				
				if (prev._iSuccess)
                {

                    prev.resolve();

                }

				retrieveNext(parser);

			}
            else
            {

                //console.log( 'AssetLoader.retrieveNext - away.events.LoaderEvent.RESOURCE_COMPLETE');
                dispatchEvent( new LoaderEvent( LoaderEvent.RESOURCE_COMPLETE , _uri ));

            }

		}
		
		/**
		private function retrieveDependency(dependency:ResourceDependency, parser:ParserBase = null):void
		{
			var data    : *;
			var matMode : Number = 0;

			if ( _context && _context.materialMode != 0 )
            {

                matMode = _context.materialMode;

            }

			_loadingDependency             = dependency;
			_loadingDependency._iLoader    = new SingleFileLoader(matMode);

			addEventListeners( _loadingDependency._iLoader ) ;
			
			// Get already loaded (or mapped) data if available
			data = _loadingDependency.data;

			if (_context && _loadingDependency.request && _context._iHasDataForUrl(_loadingDependency.request.url))
            {

                data = _context._iGetDataForUrl(_loadingDependency.request.url);

            }

			
			if (data)
            {
				if ( _loadingDependency.retrieveAsRawData)
                {
					// No need to parse. The parent parser is expecting this
					// to be raw data so it can be passed directly.

					dispatchEvent(new LoaderEvent(LoaderEvent.DEPENDENCY_COMPLETE, _loadingDependency.request.url, true));
					_loadingDependency._iSetData( data );
                    _loadingDependency.resolve();
					
					// Move on to next dependency
					retrieveNext();

				}
                else
                {

                    _loadingDependency._iLoader.parseData( data , parser , _loadingDependency.request );

                }

			}
            else
            {
				// Resolve URL and start loading
				dependency.request.url = resolveDependencyUrl(dependency);
				_loadingDependency._iLoader.load(dependency.request, parser, _loadingDependency.retrieveAsRawData);

			}
		}
		
		private function joinUrl(base:String, end:String):String
		{
			if (end.charAt(0) == '/')
            {

                end = end.substr(1);

            }

			
			if (base.length == 0)
            {

                return end;

            }

			
			if (base.charAt(base.length - 1) == '/')
            {

                base = base.substr(0, base.length - 1);

            }

			return base.concat('/', end);

		}
		
		private function resolveDependencyUrl(dependency:ResourceDependency):String
		{
			var scheme_re:RegExp;
			var base:String;
			var url:String = dependency.request.url;
			
			// Has the user re-mapped this URL?
			if (_context && _context._iHasMappingForUrl(url))
				return _context._iGetRemappedUrl( url );
			
			// This is the "base" dependency, i.e. the actual requested asset.
			// We will not try to resolve this since the user can probably be 
			// thrusted to know this URL better than our automatic resolver. :)
			if (url == _uri)
            {

                return url;

            }



			// Absolute URL? Check if starts with slash or a URL
			// scheme definition (e.g. ftp://, http://, file://)
			scheme_re = new RegExp('/^[a-zA-Z]{3,4}:\/\//');

			if (url.charAt(0) == '/') {
				if (_context && _context.overrideAbsolutePaths)
					return joinUrl( _context.dependencyBaseUrl, url);
				else
					return url;
			} else if (scheme_re.test(url)) {
				// If overriding full URLs, get rid of scheme (e.g. "http://")
				// and replace with the dependencyBaseUrl defined by user.
				if (_context && _context.overrideFullURLs) {
					var noscheme_url:String;
					
					noscheme_url = url['replace'](scheme_re);

					return joinUrl(_context.dependencyBaseUrl, noscheme_url);
				}
			}
			
			// Since not absolute, just get rid of base file name to find it's
			// folder and then concatenate dynamic URL
			if (_context && _context.dependencyBaseUrl) {
				base = _context.dependencyBaseUrl;
				return joinUrl(base, url);
			} else {
				base = _uri.substring(0, _uri.lastIndexOf('/') + 1);
				return joinUrl(base, url);
			}
		}
		
		private function retrieveLoaderDependencies(loader:SingleFileLoader):void
		{
			if (!_loadingDependency) {
				//loader.parser = null;
				//loader = null;
				return;
			}
			var i:Number, len:Number = loader.dependencies.length;
			
			for (i = 0; i < len; i++)
            {

                _loadingDependency.dependencies[i] = loader.dependencies[i];

            }

			
			// Since more dependencies might be added eventually, empty this
			// list so that the same dependency isn't retrieved more than once.
			loader.dependencies.length = 0;
			
			_stack.push(_loadingDependency);
			
			retrieveNext();
		}
		
		/**
		private function onRetrievalFailed(event:LoaderEvent):void
		{
			var handled:Boolean;
			var isDependency:Boolean = (_loadingDependency != _baseDependency);
			var loader:SingleFileLoader = SingleFileLoader(event.target);//TODO: keep on eye on this one
			
			removeEventListeners(loader);
			
			event = new LoaderEvent(LoaderEvent.LOAD_ERROR, _uri, isDependency, event.message);

            // TODO: JS / AS3 Change - debug this code with a fine tooth combe

			//if (this.hasEventListener( away.events.LoaderEvent.LOAD_ERROR , this )) {
				dispatchEvent(event);
				handled = true;
			//} else {

				// TO - Away - Consider not doing this even when AssetLoader does
				// have it's own LOAD_ERROR listener
				var i:Number, len:Number = _errorHandlers.length;
				for (i = 0; i < len; i++)
                {
					var handlerFunction = _errorHandlers[i];

					handled  = handled || Boolean(handlerFunction(event));

				}

			//}
			
			if (handled) {

                //if (isDependency && ! event.isDefaultPrevented()) {
				if ( isDependency ) { // TODO: JS / AS3 Change - we don't have isDefaultPrevented - so will this work

					_loadingDependency.resolveFailure();
					retrieveNext();

				} else {
					// Either this was the base file (last left in the stack) or
					// default behavior was prevented by the handlers, and hence
					// there is nothing more to do than clean up and bail.
					dispose();
					return;
				}
			}
            else
            {

				// Error event was not handled by listeners directly on AssetLoader or
				// on any of the subscribed loaders (in the list of error handlers.)
				throw new away.errors.Error(event.message);

			}
		}
		
		/**
		private function onParserError(event:ParserEvent):void
		{
			var handled:Boolean;

			var isDependency:Boolean = (_loadingDependency != _baseDependency);

			var loader:SingleFileLoader = SingleFileLoader(event.target);
			
			removeEventListeners(loader);
			
			event = new ParserEvent(ParserEvent.PARSE_ERROR, event.message);

            // TODO: keep on eye on this / debug - JS / AS3 Change

			//if (this.hasEventListener(away.events.ParserEvent.PARSE_ERROR)) {
				dispatchEvent(event);
				handled = true;
			//} else {
				// TODO: Consider not doing this even when AssetLoader does
				// have it's own LOAD_ERROR listener
				var i:Number, len:Number = _parseErrorHandlers.length;

				for (i = 0; i < len; i++) {
					var handlerFunction = _parseErrorHandlers[i];

                    handled  = handled || Boolean(handlerFunction(event));

					//handled ||= Boolean(handlerFunction(event));
				}
			//}
			
			if (handled) {
				dispose();
				return;
			} else {
				// Error event was not handled by listeners directly on AssetLoader or
				// on any of the subscribed loaders (in the list of error handlers.)
				throw new away.errors.Error(event.message);
			}
		}
		
		private function onAssetComplete(event:AssetEvent):void
		{
			// Event is dispatched twice per asset (once as generic ASSET_COMPLETE,
			// and once as type-specific, e.g. MESH_COMPLETE.) Do this only once.
			if (event.type == AssetEvent.ASSET_COMPLETE) {
				
				// Add loaded asset to list of assets retrieved as part
				// of the current dependency. This list will be inspected
				// by the parent parser when dependency is resolved
				if (_loadingDependency)
                {

                    _loadingDependency.assets.push(event.asset);

                }

				event.asset.resetAssetPath(event.asset.name, _namespace);

			}

            //console.log( 'AssetLoader.onAssetComplete suppresAssetEvents:' , this._loadingDependency.suppresAssetEvents , event );

			if (!_loadingDependency.suppresAssetEvents)
            {

                dispatchEvent(event.clone());

            }

		}
		
		private function onReadyForDependencies(event:ParserEvent):void
		{
			var loader:SingleFileLoader = SingleFileLoader(event.target); // was event.currentTarget / TODO: AS3 <> JS functionality change - keep on eye on this
			
			if (_context && !_context.includeDependencies)
            {

                loader.parser._iResumeParsingAfterDependencies();
            }
			else
            {

                retrieveLoaderDependencies(loader);

            }

		}
		
		/**
		private function onRetrievalComplete(event:LoaderEvent):void
		{
            var loader:SingleFileLoader = SingleFileLoader(event.target);
            //var loader:SingleFileLoader = SingleFileLoader(event.target);
			
			// Resolve this dependency
			_loadingDependency._iSetData( loader.data );
            _loadingDependency._iSuccess = true;
			
			dispatchEvent(new LoaderEvent(LoaderEvent.DEPENDENCY_COMPLETE, event.url));
			removeEventListeners(loader);
			
			// Retrieve any last dependencies remaining on this loader, or
			// if none exists, just move on.
			if (loader.dependencies.length && (!_context || _context.includeDependencies))
            { //context may be null

				retrieveLoaderDependencies(loader);

			}
            else
            {

                retrieveNext();

            }

		}
		
		/**
		private function onTextureSizeError(event:AssetEvent):void
		{
			event.asset.name = _loadingDependency.resolveName(event.asset);
			dispatchEvent(event);

		}
		
		private function addEventListeners(loader:SingleFileLoader):void
		{
			loader.addEventListener(LoaderEvent.DEPENDENCY_COMPLETE, onRetrievalComplete , this );
			loader.addEventListener(LoaderEvent.LOAD_ERROR, onRetrievalFailed, this );
			loader.addEventListener(AssetEvent.TEXTURE_SIZE_ERROR, onTextureSizeError, this );
			loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.ANIMATION_SET_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.ANIMATION_STATE_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.ANIMATION_NODE_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.STATE_TRANSITION_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.TEXTURE_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.CONTAINER_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.GEOMETRY_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.MATERIAL_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.MESH_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.ENTITY_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.SKELETON_COMPLETE, onAssetComplete, this );
			loader.addEventListener(AssetEvent.SKELETON_POSE_COMPLETE, onAssetComplete, this );
			loader.addEventListener(ParserEvent.READY_FOR_DEPENDENCIES, onReadyForDependencies, this );
			loader.addEventListener(ParserEvent.PARSE_ERROR, onParserError, this );
		}
		
		private function removeEventListeners(loader:SingleFileLoader):void
		{
			loader.removeEventListener(ParserEvent.READY_FOR_DEPENDENCIES, onReadyForDependencies, this);
			loader.removeEventListener(LoaderEvent.DEPENDENCY_COMPLETE, onRetrievalComplete, this);
			loader.removeEventListener(LoaderEvent.LOAD_ERROR, onRetrievalFailed, this);
			loader.removeEventListener(AssetEvent.TEXTURE_SIZE_ERROR, onTextureSizeError, this);
			loader.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.ANIMATION_SET_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.ANIMATION_STATE_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.ANIMATION_NODE_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.STATE_TRANSITION_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.TEXTURE_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.CONTAINER_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.GEOMETRY_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.MATERIAL_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.MESH_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.ENTITY_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.SKELETON_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(AssetEvent.SKELETON_POSE_COMPLETE, onAssetComplete, this);
			loader.removeEventListener(ParserEvent.PARSE_ERROR, onParserError, this);
		}
		
		public function stop():void
		{
			dispose();
		}
		
		private function dispose():void
		{
			_errorHandlers = null;
            _parseErrorHandlers = null;
            _context = null;
            _token = null;
            _stack = null;
			
			if (_loadingDependency && _loadingDependency._iLoader)
            {

                removeEventListeners(_loadingDependency._iLoader);

            }

            _loadingDependency = null;

		}
		
		/**
		
		public function _iAddParseErrorHandler(handler):void
		{

			if (_parseErrorHandlers.indexOf(handler) < 0)
            {

                _parseErrorHandlers.push(handler);

            }

		
		}
		
		public function _iAddErrorHandler(handler):void
		{

			if (_errorHandlers.indexOf(handler) < 0)
            {

                _errorHandlers.push(handler);

            }


		}
	}
}
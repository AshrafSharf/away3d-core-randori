/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.parsers {
	import away.events.EventDispatcher;
	import away.loaders.misc.ResourceDependency;
	import away.utils.Timer;
	import away.errors.AbstractMethodError;
	import away.core.display.BitmapData;
	import away.utils.TextureUtils;
	import away.library.assets.IAsset;
	import away.library.assets.AssetType;
	import away.events.AssetEvent;
	import away.errors.Error;
	import away.events.TimerEvent;
	import away.events.ParserEvent;
	import away.core.net.URLRequest;
	import away.loaders.parsers.utils.ParserUtil;
	import away.utils.ByteArray;
	import randori.webkit.page.Window;

	/**
	public class ParserBase extends EventDispatcher
	{
		public var _iFileName:String = null;// ARCANE
		private var _dataFormat:String = null;
		private var _data:*;
		private var _frameLimit:Number = 0;
		private var _lastFrameTime:Number = 0;

        //----------------------------------------------------------------------------------------------------------------------------------------------------------------
        // TODO: add error checking for the following ( could cause a problem if this function is not implemented )
        //----------------------------------------------------------------------------------------------------------------------------------------------------------------
        // Needs to be implemented in all Parsers (
        //<code>public static supportsType(extension : string) : boolean</code>
        //* Indicates whether or not a given file extension is supported by the parser.
        //----------------------------------------------------------------------------------------------------------------------------------------------------------------

        public static function supportsType(extension:String):Boolean
        {

            throw new AbstractMethodError();
            return false;

        }

        /* TODO: Implement ParserUtil;
		private var _dependencies:Vector.<ResourceDependency>;//Vector.<ResourceDependency>
        private var _loaderType:String = ParserLoaderType.URL_LOADER;// Default loader is URLLoader
		private var _parsingPaused:Boolean = false;
		private var _parsingComplete:Boolean = false;
		private var _parsingFailure:Boolean = false;
		private var _timer:Timer;
		private var _materialMode:Number = 0;
		
		/**
		public static var PARSING_DONE:Boolean = true
		
		/**
        public static var MORE_TO_PARSE:Boolean = false
		
		
		/**
		public function ParserBase(format:String, loaderType:String = null):void
		{
			loaderType = loaderType || null;


            super();

            if ( loaderType )
            {

                this._loaderType = loaderType;

            }

			this._materialMode=0;
			this._dataFormat    = format;
			this._dependencies  = new Vector.<ResourceDependency>();
		}
		
		/**

		public function isBitmapDataValid(bitmapData:BitmapData):Boolean
		{
			var isValid : Boolean = TextureUtils.isBitmapDataValid( bitmapData );

			if( ! isValid )
            {

                Window.console.log (">> Bitmap loaded is not having power of 2 dimensions or is higher than 2048");
            }
			
			return isValid;
		}

		public function set parsingFailure(b:Boolean):void
		{
			this._parsingFailure = b;
		}

		public function get parsingFailure():Boolean
		{
			return this._parsingFailure;
		}

		public function get parsingPaused():Boolean
		{
			return this._parsingPaused;
		}

		public function get parsingComplete():Boolean
		{
			return this._parsingComplete;
		}
		
		public function set materialMode(newMaterialMode:Number):void
		{
            this._materialMode=newMaterialMode;
		}
		
		public function get materialMode():Number
		{
			return this._materialMode;
		}

        public function get loaderType():String
        {

            return this._loaderType;

        }

        public function set loaderType(value:String):void
        {

            this._loaderType = value;

        }

        public function get data():*
        {

            return this._data;

        }

		/**
		public function get dataFormat():String
		{
			return this._dataFormat;
		}
		
		/**
		public function parseAsync(data:*, frameLimit:Number = 30):void
		{
			frameLimit = frameLimit || 30;

            this._data = data;
            this.startParsing(frameLimit);
		}
		
		/**
		public function get dependencies():Vector.<ResourceDependency>
		{
			return this._dependencies;
		}
		
		/**
		public function _iResolveDependency(resourceDependency:ResourceDependency):void
		{

            throw new AbstractMethodError();

		}
		
		/**
		public function _iResolveDependencyFailure(resourceDependency:ResourceDependency):void
		{
            throw new AbstractMethodError();
		}

		/**
		public function _iResolveDependencyName(resourceDependency:ResourceDependency, asset:IAsset):String
		{
			return asset.name;
		}
		
		public function _iResumeParsingAfterDependencies():void
		{
			this._parsingPaused = false;

			if (this._timer){

                this._timer.start();

            }
		}
		
		public function _pFinalizeAsset(asset:IAsset, name:String = null):void
		{
			name = name || null;

			var type_event : String;
			var type_name : String;
			
			if (name != null){

                asset.name = name;

            }

			switch (asset.assetType) {
				case AssetType.LIGHT_PICKER:
					type_name = 'lightPicker';
					type_event = AssetEvent.LIGHTPICKER_COMPLETE;
					break;
				case AssetType.LIGHT:
					type_name = 'light';
					type_event = AssetEvent.LIGHT_COMPLETE;
					break;
				case AssetType.ANIMATOR:
					type_name = 'animator';
					type_event = AssetEvent.ANIMATOR_COMPLETE;
					break;
				case AssetType.ANIMATION_SET:
					type_name = 'animationSet';
					type_event = AssetEvent.ANIMATION_SET_COMPLETE;
					break;
				case AssetType.ANIMATION_STATE:
					type_name = 'animationState';
					type_event = AssetEvent.ANIMATION_STATE_COMPLETE;
					break;
				case AssetType.ANIMATION_NODE:
					type_name = 'animationNode';
					type_event = AssetEvent.ANIMATION_NODE_COMPLETE;
					break;
				case AssetType.STATE_TRANSITION:
					type_name = 'stateTransition';
					type_event = AssetEvent.STATE_TRANSITION_COMPLETE;
					break;
				case AssetType.TEXTURE:
					type_name = 'texture';
					type_event = AssetEvent.TEXTURE_COMPLETE;
					break;
				case AssetType.TEXTURE_PROJECTOR:
					type_name = 'textureProjector';
					type_event = AssetEvent.TEXTURE_PROJECTOR_COMPLETE;
					break;
				case AssetType.CONTAINER:
					type_name = 'container';
					type_event = AssetEvent.CONTAINER_COMPLETE;
					break;
				case AssetType.GEOMETRY:
					type_name = 'geometry';
					type_event = AssetEvent.GEOMETRY_COMPLETE;
					break;
				case AssetType.MATERIAL:
					type_name = 'material';
					type_event = AssetEvent.MATERIAL_COMPLETE;
					break;
				case AssetType.MESH:
					type_name = 'mesh';
					type_event = AssetEvent.MESH_COMPLETE;
					break;
				case AssetType.SKELETON:
					type_name = 'skeleton';
					type_event = AssetEvent.SKELETON_COMPLETE;
					break;
				case AssetType.SKELETON_POSE:
					type_name = 'skelpose';
					type_event = AssetEvent.SKELETON_POSE_COMPLETE;
					break;
				case AssetType.ENTITY:
					type_name = 'entity';
					type_event = AssetEvent.ENTITY_COMPLETE;
					break;
				case AssetType.SKYBOX:
					type_name = 'skybox';
					type_event = AssetEvent.SKYBOX_COMPLETE;
					break;
				case AssetType.CAMERA:
					type_name = 'camera';
					type_event = AssetEvent.CAMERA_COMPLETE;
					break;
				case AssetType.SEGMENT_SET:
					type_name = 'segmentSet';
					type_event = AssetEvent.SEGMENT_SET_COMPLETE;
					break;
				case AssetType.EFFECTS_METHOD:
					type_name = 'effectsMethod';
					type_event = AssetEvent.EFFECTMETHOD_COMPLETE;
					break;
				case AssetType.SHADOW_MAP_METHOD:
					type_name = 'effectsMethod';
					type_event = AssetEvent.SHADOWMAPMETHOD_COMPLETE;
					break;
                default:
                    throw new away.errors.Error('Unhandled asset type '+asset.assetType+'. Report as bug!');
					break;
			};

            //console.log( 'ParserBase' , '_pFinalizeAsset.type_event: ' ,  type_event );

			// If the asset has no name, give it
			// a per-type default name.
			if (!asset.name)
				asset.name = type_name;
			
			this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_COMPLETE, asset));
            this.dispatchEvent(new AssetEvent(type_event, asset));
		}
		
		/**
		public function _pProceedParsing():Boolean
		{

            throw new AbstractMethodError();
			return true;
		}

		public function _pDieWithError(message:String = 'Unknown parsing error'):void
		{
			message = message || 'Unknown parsing error';

            if(this._timer)
            {
			    this._timer.removeEventListener(TimerEvent.TIMER, _pOnInterval , this );
                this._timer.stop();
                this._timer = null;
            }

			this.dispatchEvent(new ParserEvent(ParserEvent.PARSE_ERROR, message));
		}

		public function _pAddDependency(id:String, req:URLRequest, retrieveAsRawData:Boolean = false, data:* = null, suppressErrorEvents:Boolean = false):void
		{
			retrieveAsRawData = retrieveAsRawData || false;
			data = data || null;
			suppressErrorEvents = suppressErrorEvents || false;


			this._dependencies.push(new ResourceDependency(id, req, data, this, retrieveAsRawData, suppressErrorEvents));
		}

		public function _pPauseAndRetrieveDependencies():void
		{
            if(this._timer)
            {
                this._timer.stop();
            }

			this._parsingPaused = true;
			this.dispatchEvent(new ParserEvent(ParserEvent.READY_FOR_DEPENDENCIES));
		}
		
		/**
		public function _pHasTime():Boolean
		{

			return ((new Date().getTime() - this._lastFrameTime) < this._frameLimit);

		}
		
		/**
		public function _pOnInterval(event:TimerEvent = null):void
		{
			event = event || null;

			this._lastFrameTime = new Date().getTime();

			if (this._pProceedParsing() && !this._parsingFailure){

				this._pFinishParsing();

            }
		}
		
		/**
		private function startParsing(frameLimit:Number):void
		{

			this._frameLimit = frameLimit;
			this._timer = new Timer(this._frameLimit, 0);
			this._timer.addEventListener(TimerEvent.TIMER, _pOnInterval , this );
			this._timer.start();

		}

		/**
		public function _pFinishParsing():void
		{

            //console.log( 'ParserBase._pFinishParsing');

            if(this._timer)
            {
			    this._timer.removeEventListener(TimerEvent.TIMER, _pOnInterval , this );
			    this._timer.stop();
            }

			this._timer = null;
			this._parsingComplete = true;

			this.dispatchEvent(new ParserEvent(ParserEvent.PARSE_COMPLETE));

		}

        /**
        public function _pGetTextData():String
        {
            return ParserUtil.toString( this._data);
        }

        /**
        public function _pGetByteData():ByteArray
        {

            return ParserUtil.toByteArray( this._data );

        }

	}

}
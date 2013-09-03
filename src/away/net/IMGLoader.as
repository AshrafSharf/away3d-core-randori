

///<reference path="../_definitions.ts"/>

package away.net
{
	import away.events.EventDispatcher;
	import away.events.Event;
	import away.events.IOErrorEvent;
	import randori.webkit.html.HTMLImageElement;

    // TODO: implement / test cross domain policy

    public class IMGLoader extends EventDispatcher
    {

        private var _image:HTMLImageElement;
        private var _request:URLRequest;
        private var _name:String = '';
        private var _loaded:Boolean = false;
        private var _crossOrigin:String;

        public function IMGLoader(imageName:String = ''):void
        {

            super();
            this._name = imageName;
            this.initImage();

        }

        // Public
        /**
        public function load(request:URLRequest):void
        {

            _loaded = false;
            _request   = request;

            if ( _crossOrigin )
            {

                if ( _image['crossOrigin'] != null )
                {

                    _image['crossOrigin'] = _crossOrigin;

                }


            }

            _image.src = _request.url;

        }

        /**
        public function dispose():void
        {

            if ( _image )
            {

                _image.onabort = null;
                _image.onerror = null;
                _image.onload	= null;
                _image         = null;

            }

            if ( _request )
            {

                _request = null;

            }

        }

        // Get / Set

        /**
        public function get image():HTMLImageElement
        {

            return _image;

        }

        /**
        public function get loaded():Boolean
        {

            return _loaded

        }

        public function get crossOrigin():String
        {

            return _crossOrigin;
        }

        public function set crossOrigin(value:String):void
        {

            this._crossOrigin = value;

        }

        /**
        public function get width():Number
        {

            if ( _image ) {

                return _image.width;

            }

            return null;

        }

        /**
        public function get height():Number
        {

            if ( _image ) {

                return _image.height;

            }

            return null;

        }

        /**
        public function get request():URLRequest
        {

            return _request;

        }

        /**
        public function get name():String
        {

            if ( _image )
            {

                return _image.name;

            }

            return _name;

        }

        /**
        public function set name(value:String):void
        {

            if ( this._image )
            {

                this._image.name = value;

            }

            this._name = value;

        }

        // Private

        /**
        private function initImage():void
        {

            var that:IMGLoader = this;
			if ( ! _image )
            {

                _image         = new HTMLImageElement();
                _image.onabort = function(event) { that.onAbort(event); } //Loading of an image is interrupted
                _image.onerror = function(event) { that.onError(event); } //An error occurs when loading an image
                _image.onload	= function(event) { that.onLoadComplete(event); } //image is finished loading
                _image.name    = _name;

            }

        }

        // Image - event handlers

        /**
        private function onAbort(event):void
        {

            dispatchEvent( new Event( IOErrorEvent.IO_ERROR) );

        }

        /**
        private function onError(event):void
        {

            dispatchEvent( new Event( IOErrorEvent.IO_ERROR) );

        }

        /**
        private function onLoadComplete(event):void
        {
            _loaded = true;
            dispatchEvent( new Event( Event.COMPLETE ));

        }

    }

}
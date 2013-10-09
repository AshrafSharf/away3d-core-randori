/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.net
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
        private var _crossOrigin:String = null;

        public function IMGLoader(imageName:String = ''):void
        {
			imageName = imageName || '';


            super();
            this._name = imageName;
            this.initImage();

        }

        // Public
        /**
        public function load(request:URLRequest):void
        {

            this._loaded = false;
            this._request   = request;

            if ( this._crossOrigin )
            {

                if ( this._image['crossOrigin'] != null )
                {

                    this._image['crossOrigin'] = this._crossOrigin;

                }


            }

            this._image.src = this._request.url;

        }

        /**
        public function dispose():void
        {

            if ( this._image )
            {

                this._image.onabort = null;
                this._image.onerror = null;
                this._image.onload	= null;
                this._image         = null;

            }

            if ( this._request )
            {

                this._request = null;

            }

        }

        // Get / Set

        /**
        public function get image():HTMLImageElement
        {

            return this._image;

        }

        /**
        public function get loaded():Boolean
        {

            return this._loaded

        }

        public function get crossOrigin():String
        {

            return this._crossOrigin;
        }

        public function set crossOrigin(value:String):void
        {

            this._crossOrigin = value;

        }

        /**
        public function get width():Number
        {

            if ( this._image ) {

                return this._image.width;

            }

            return null;

        }

        /**
        public function get height():Number
        {

            if ( this._image ) {

                return this._image.height;

            }

            return null;

        }

        /**
        public function get request():URLRequest
        {

            return this._request;

        }

        /**
        public function get name():String
        {

            if ( this._image )
            {

                return this._image.name;

            }

            return this._name;

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
			if ( ! this._image )
            {

                this._image         = new HTMLImageElement();
                this._image.onabort = function(event) { that.onAbort(event); } //Loading of an image is interrupted
                this._image.onerror = function(event) { that.onError(event); } //An error occurs when loading an image
                this._image.onload	= function(event) { that.onLoadComplete(event); } //image is finished loading
                this._image.name    = this._name;

            }

        }

        // Image - event handlers

        /**
        private function onAbort(event):void
        {

            this.dispatchEvent( new Event( IOErrorEvent.IO_ERROR) );

        }

        /**
        private function onError(event):void
        {

            this.dispatchEvent( new Event( IOErrorEvent.IO_ERROR) );

        }

        /**
        private function onLoadComplete(event):void
        {
            this._loaded = true;
            this.dispatchEvent( new Event( Event.COMPLETE ));

        }

    }

}
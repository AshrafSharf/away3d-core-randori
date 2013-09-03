
///<reference path="../_definitions.ts"/>

package away.net {
	import away.events.EventDispatcher;
	import away.errors.Error;
	import away.events.IOErrorEvent;
	import away.events.HTTPStatusEvent;
	import away.events.ProgressEvent;
	import away.events.Event;
	import randori.webkit.xml.XMLHttpRequest;

    // TODO: implement / test cross domain policy

    public class URLLoader extends EventDispatcher
    {

        private var _XHR:XMLHttpRequest;
        private var _bytesLoaded:Number = 0;
        private var _bytesTotal:Number = 0;
        private var _data:*;
        private var _dataFormat:String = URLLoaderDataFormat.TEXT;
        private var _request:URLRequest;
        private var _loadError:Boolean = false;

        public function URLLoader():void
        {

            super();

        }

        // Public

        /**
        public function load(request:URLRequest):void
        {

            initXHR();
            _request = request;

            if ( request.method === URLRequestMethod.POST ){

                postRequest( request );


            } else {

                getRequest( request );

            }

        }

        /**
        public function close():void
        {

            _XHR.abort();
            disposeXHR();

        }

        /**
        public function dispose():void
        {

            if ( _XHR)
            {

                _XHR.abort();

            }

            disposeXHR();

            _data          = null;
            _dataFormat    = null;
            _bytesLoaded   = null;
            _bytesTotal    = null;

            /*

            _request   = null;

        }

        // Get / Set

        /**
        public function set dataFormat(format:String):void
        {

            if( format === URLLoaderDataFormat.BLOB
                || format === URLLoaderDataFormat.ARRAY_BUFFER
                || format === URLLoaderDataFormat.BINARY
                || format === URLLoaderDataFormat.TEXT
                || format === URLLoaderDataFormat.VARIABLES) {

                this._dataFormat = format;

            } else {

                throw new away.errors.Error( 'URLLoader error: incompatible dataFormat' );

            }

        }

        /**
        public function get dataFormat():String
        {

            return _dataFormat;

        }

        /**
        public function get data():*
        {

            return _data;

        }

        /**
        public function get bytesLoaded():Number
        {

            return _bytesLoaded;

        }

        /**
        public function get bytesTotal():Number
        {

            return _bytesTotal;

        }

        /**
        public function get request():URLRequest
        {

            return _request;

        }

        // Private

        /**
        private function setResponseType(xhr:XMLHttpRequest, responseType:String):void
        {

            switch( responseType )
            {

                case URLLoaderDataFormat.ARRAY_BUFFER:
                case URLLoaderDataFormat.BLOB:
                case URLLoaderDataFormat.TEXT:

                    xhr.responseType = responseType;

                    break;

                case URLLoaderDataFormat.VARIABLES:

                    xhr.responseType = URLLoaderDataFormat.TEXT;

                    break;


                case URLLoaderDataFormat.BINARY:

                    xhr.responseType = '';

                    break;


            }


        }

        /**
        private function getRequest(request:URLRequest):void
        {

            try {

                _XHR.open( request.method , request.url , request.async );
                setResponseType( _XHR , _dataFormat );
                _XHR.send(); // No data to send

            } catch ( e /* <XMLHttpRequestException> */ ) {

                handleXmlHttpRequestException( e);

            }

        }

        /**
        private function postRequest(request:URLRequest):void
        {

            _loadError = false;

            _XHR.open( request.method , request.url , request.async );

            if ( request.data != null )
            {

                if ( request.data instanceof URLVariables )
                {

                    var urlVars : URLVariables = URLVariables(request.data);

                    try {

                        _XHR.responseType = 'text';
                        _XHR.send( urlVars.formData );


                    } catch ( e /* <XMLHttpRequestException> */ ) {

                        handleXmlHttpRequestException( e );

                    }

                }
                else
                {

                    setResponseType( _XHR , _dataFormat );

                    if ( request.data ) {

                        _XHR.send( request.data ); // TODO: Test

                    } else {

                        _XHR.send( ); // no data to send

                    }


                }

            }
            else
            {

                _XHR.send(); // No data to send

            }

        }

        /**
        private function handleXmlHttpRequestException(error /* <XMLHttpRequestException> */):void
        {

            switch ( error.code )
            {

                /******************************************************************************************************************************************************************************************************

                //case 101:

                    // Note: onLoadError event throws IO_ERROR event - this case is already Covered

                    //break;



            }


        }

        /**
        private function initXHR():void
        {

            if ( ! _XHR )
            {

                _XHR = new XMLHttpRequest();

                _XHR.onloadstart = onLoadStart;                 // loadstart	        - When the request starts.
                _XHR.onprogress = onProgress;	                // progress	            - While loading and sending data.
                _XHR.onabort = onAbort;	                        // abort	            - When the request has been aborted, either by invoking the abort() method or navigating away from the page.
                _XHR.onerror = onLoadError;                     // error	            - When the request has failed.
                _XHR.onload = onLoadComplete;                   // load	                - When the request has successfully completed.
                _XHR.ontimeout	= onTimeOut;                     // timeout	            - When the author specified timeout has passed before the request could complete.
                _XHR.onloadend	= onLoadEnd;                     // loadend	            - When the request has completed, regardless of whether or not it was successful.
                _XHR.onreadystatechange = onReadyStateChange;   // onreadystatechange   - When XHR state changes

            }

        }

        /**
        private function disposeXHR():void
        {

            if ( _XHR !== null )
            {

                _XHR.onloadstart   = null;
                _XHR.onprogress    = null;
                _XHR.onabort       = null;
                _XHR.onerror       = null;
                _XHR.onload        = null;
                _XHR.ontimeout	    = null;
                _XHR.onloadend	    = null;
                _XHR               = null;

            }

        }

        /**
        public function decodeURLVariables(source:String):Object
        {

            var result : Object = new Object();

            source = source.split("+").join(" ");

            var tokens, re = /[?&]?([^=]+)=([^&]*)/g;

            while (tokens = re.exec(source))
            {

                result[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);

            }

            return result;

        }

        // XMLHttpRequest - Event Handlers

        /**
        private function onReadyStateChange(event):void
        {
            if (_XHR.readyState==4)
            {

                if (_XHR.status==404)
                {

                    _loadError = true;
                    dispatchEvent( new IOErrorEvent(IOErrorEvent.IO_ERROR ));

                }

                dispatchEvent( new HTTPStatusEvent( HTTPStatusEvent.HTTP_STATUS , _XHR.status ));

            }

        }

        /**
        private function onLoadEnd(event):void
        {

            if( _loadError === true ) return;

        }

        /**
        private function onTimeOut(event):void
        {

            //TODO: Timeout not currently implemented ( also not part of AS3 API )

        }

        /**
        private function onAbort(event):void
        {

            // TODO: investigate whether this needs to be an IOError

        }

        /**
        private function onProgress(event):void
        {

            _bytesTotal    = event.total;
            _bytesLoaded   = event.loaded;

            var progressEvent : ProgressEvent   = new ProgressEvent( ProgressEvent.PROGRESS );
                progressEvent.bytesLoaded                   = _bytesLoaded;
                progressEvent.bytesTotal                    = _bytesTotal;
            dispatchEvent( progressEvent );

        }

        /**
        private function onLoadStart(event):void
        {

            dispatchEvent( new Event( Event.OPEN ));

        }

        /**
        private function onLoadComplete(event):void
        {

            if( _loadError === true ) return;

            // TODO: Assert received data format

            switch ( _dataFormat ){

                case URLLoaderDataFormat.TEXT:

                    _data = _XHR.responseText;

                    break;

                case URLLoaderDataFormat.VARIABLES:

                    _data = decodeURLVariables( _XHR.responseText );

                    break;

                case URLLoaderDataFormat.BLOB:
                case URLLoaderDataFormat.ARRAY_BUFFER:
                case URLLoaderDataFormat.BINARY:

                    _data = _XHR.response;

                    break;

                default:

                    _data = _XHR.responseText;

                    break;

            }

            dispatchEvent( new Event( Event.COMPLETE ));

        }

        /**
        private function onLoadError(event):void
        {

            _loadError = true;
            dispatchEvent( new IOErrorEvent(IOErrorEvent.IO_ERROR ));

        }


    }

}
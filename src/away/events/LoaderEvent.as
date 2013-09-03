///<reference path="../_definitions.ts"/>

package away.events
{	
	public class LoaderEvent extends Event
	{
        /**
        public static var LOAD_ERROR:String = "loadError";

        /**
        public static var RESOURCE_COMPLETE:String = "resourceComplete";

        /**
        public static var DEPENDENCY_COMPLETE:String = "dependencyComplete";

        private var _url:String;
        private var _message:String;
        private var _isDependency:Boolean;
        private var _isDefaultPrevented:Boolean;

        /**
        public function LoaderEvent(type:String, url:String = null, isDependency:Boolean = false, errmsg:String = null):void
		{
			super(type);

            this._url           = url;
            this._message       = errmsg;
            this._isDependency  = isDependency;

		}
        /**
        public function get url():String
        {

            return _url;

        }

        /**
        public function get message():String
        {
            return _message;
        }


        /**
        public function get isDependency():Boolean
        {
            return _isDependency;
        }

        /**
        override public function clone():Event
        {
            return Event(new LoaderEvent(type, _url, _isDependency, _message));

        }

    }

}
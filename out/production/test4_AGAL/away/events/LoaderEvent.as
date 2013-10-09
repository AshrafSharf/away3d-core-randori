/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

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

        private var _url:String = null;
        private var _message:String = null;
        private var _isDependency:Boolean = false;
        private var _isDefaultPrevented:Boolean = false;

        /**
        public function LoaderEvent(type:String, url:String = null, isDependency:Boolean = false, errmsg:String = null):void
		{
			url = url || null;
			isDependency = isDependency || false;
			errmsg = errmsg || null;

			super(type);

            this._url           = url;
            this._message       = errmsg;
            this._isDependency  = isDependency;

		}
        /**
        public function get url():String
        {

            return this._url;

        }

        /**
        public function get message():String
        {
            return this._message;
        }


        /**
        public function get isDependency():Boolean
        {
            return this._isDependency;
        }

        /**
        override public function clone():Event
        {
            return (new LoaderEvent(this.type , this._url , this._isDependency , this._message ) as Event);

        }

    }

}
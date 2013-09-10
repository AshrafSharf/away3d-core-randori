///<reference path="../_definitions.ts"/>
package away.events
{	
	public class LoaderEvent extends Event
	{
        /**
         * Dispatched when loading of a asset failed.
         * Such as wrong parser type, unsupported extensions, parsing errors, malformated or unsupported 3d file etc..
         */
        public static var LOAD_ERROR:String = "loadError";

        /**
         * Dispatched when a resource and all of its dependencies is retrieved.
         */
        public static var RESOURCE_COMPLETE:String = "resourceComplete";

        /**
         * Dispatched when a resource's dependency is retrieved and resolved.
         */
        public static var DEPENDENCY_COMPLETE:String = "dependencyComplete";

        private var _url:String;
        private var _message:String;
        private var _isDependency:Boolean;
        private var _isDefaultPrevented:Boolean;

        /**
         * Create a new LoaderEvent object.
         * @param type The event type.
         * @param resource The loaded or parsed resource.
         * @param url The url of the loaded resource.
         */
        public function LoaderEvent(type:String, url:String = null, isDependency:Boolean = false, errmsg:String = null):void
		{
			super(type);

            _url           = url;
            _message       = errmsg;
            _isDependency  = isDependency;

		}
        /**
         * The url of the loaded resource.
         */
        public function get url():String
        {

            return _url;

        }

        /**
         * The error string on loadError.
         */
        public function get message():String
        {
            return _message;
        }


        /**
         * Indicates whether the event occurred while loading a dependency, as opposed
         * to the base file. Dependencies can be textures or other files that are
         * referenced by the base file.
         */
        public function get isDependency():Boolean
        {
            return _isDependency;
        }

        /**
         * Clones the current event.
         * @return An exact duplicate of the current event.
         */
        override public function clone():Event
        {
            return (new LoaderEvent(type, _url, _isDependency, _message) as Event);

        }

    }

}
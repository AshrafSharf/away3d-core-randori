/**
package away.events
{
	public class Event {

        public static var COMPLETE:String = 'Event_Complete';
        public static var OPEN:String = 'Event_Open';

        public static var ENTER_FRAME:String = 'enterframe';
        public static var EXIT_FRAME:String = 'exitframe';


		public static var RESIZE:String = "resize";
		public static var CONTEXT3D_CREATE:String = "context3DCreate";
        public static var ERROR:String = "error";
        public static var CHANGE:String = "change";
		
        /**
        public var type:String = undefined;
		
        /**
        public var target:Object = undefined;
		
        public function Event(type:String):void
        {
            this.type = type;
        }

        /**
        public function clone():Event
        {
            return new Event( type );
        }

	}

}
///<reference path="../_definitions.ts"/>

package away.events
{
	//import flash.events.Event;

	public class ParserEvent extends Event
	{
		private var _message:String;
		
		/** 
		public static var PARSE_COMPLETE:String = 'parseComplete';
		
		/**
		public static var PARSE_ERROR:String = 'parseError';
		
		
		/**
		public static var READY_FOR_DEPENDENCIES:String = 'readyForDependencies';
		
		
		public function ParserEvent(type:String, message:String = ''):void
		{
			super(type);
			
			this._message = message;
		}
		
		
		/**
		public function get message():String
		{
			return _message;
		}
		
		
		override public function clone():Event
		{
			return new ParserEvent( type , message );
		}
	}
}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.events
{
	//import flash.events.Event;

	public class ParserEvent extends Event
	{
		private var _message:String = null;
		
		/** 
		public static var PARSE_COMPLETE:String = 'parseComplete';
		
		/**
		public static var PARSE_ERROR:String = 'parseError';
		
		
		/**
		public static var READY_FOR_DEPENDENCIES:String = 'readyForDependencies';
		
		
		public function ParserEvent(type:String, message:String = ''):void
		{
			message = message || '';

			super(type);
			
			this._message = message;
		}
		
		
		/**
		public function get message():String
		{
			return this._message;
		}
		
		
		override public function clone():Event
		{
			return new ParserEvent( this.type , this.message );
		}
	}
}
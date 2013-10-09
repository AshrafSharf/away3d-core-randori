/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.events
{
	import away.core.base.ISubGeometry;

	/**
	public class GeometryEvent extends Event
	{
		/**
		public static var SUB_GEOMETRY_ADDED:String = "SubGeometryAdded";
		
		/**
		public static var SUB_GEOMETRY_REMOVED:String = "SubGeometryRemoved";
		
		public static var BOUNDS_INVALID:String = "BoundsInvalid";
		
		private var _subGeometry:ISubGeometry;
		
		/**
		public function GeometryEvent(type:String, subGeometry:ISubGeometry = null):void
		{
			subGeometry = subGeometry || null;

			super( type ) //, false, false);
			this._subGeometry = subGeometry;
		}
		
		/**
		public function get subGeometry():ISubGeometry
		{
			return this._subGeometry;
		}
		
		/**
		override public function clone():Event
		{
			return new GeometryEvent( this.type , this._subGeometry );
		}
	}
}
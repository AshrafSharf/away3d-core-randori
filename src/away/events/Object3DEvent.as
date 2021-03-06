/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.events
{
	import away.core.base.Object3D;
	public class Object3DEvent extends Event
	{
		public static var VISIBLITY_UPDATED:String = "visiblityUpdated";
		public static var SCENETRANSFORM_CHANGED:String = "scenetransformChanged";
		public static var SCENE_CHANGED:String = "sceneChanged";
		public static var POSITION_CHANGED:String = "positionChanged";
		public static var ROTATION_CHANGED:String = "rotationChanged";
		public static var SCALE_CHANGED:String = "scaleChanged";
		
		public var object:Object3D;
		
		public function Object3DEvent(type:String, object:Object3D):void
		{
			super( type );
			this.object = object;
		}
	}
}
///<reference path="../_definitions.ts" />

package away.controllers
{
	import away.entities.Entity;
	import away.containers.ObjectContainer3D;

	/**
	public class FollowController extends HoverController
	{
		public function FollowController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, tiltAngle:Number = 45, distance:Number = 700):void
		{
			super(targetObject, lookAtObject, 0, tiltAngle, distance);
		}
		
		override public function update(interpolate:Boolean = true):void
		{
			interpolate = interpolate; // unused: prevents warning
			
			if (!lookAtObject)
				return;

            panAngle = _pLookAtObject.rotationY - 180;
			super.update();
		}
	}
}
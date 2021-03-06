/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.controllers
{
	import away.entities.Entity;
	import away.containers.ObjectContainer3D;

	/**	 * Controller used to follow behind an object on the XZ plane, with an optional	 * elevation (tiltAngle).	 *	 * @see    away3d.containers.View3D	 */
	public class FollowController extends HoverController
	{
		public function FollowController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, tiltAngle:Number = 45, distance:Number = 700):void
		{
			targetObject = targetObject || null;
			lookAtObject = lookAtObject || null;
			tiltAngle = tiltAngle || 45;
			distance = distance || 700;

			super(targetObject, lookAtObject, 0, tiltAngle, distance);
		}
		
		override public function update(interpolate:Boolean = true):void
		{
			interpolate = interpolate; // unused: prevents warning
			
			if (!this.lookAtObject)
				return;

            this.panAngle = this._pLookAtObject.rotationY - 180;
			super.update();
		}
	}
}

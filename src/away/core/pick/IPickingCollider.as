/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.pick
{
	import away.core.geom.Vector3D;
	import away.core.base.SubMesh;
	//import away3d.core.base.SubMesh;
	
	//import flash.geom.Vector3D;
	
	/**	 * Provides an interface for picking colliders that can be assigned to individual entities in a scene for specific picking behaviour.	 * Used with the <code>RaycastPicker</code> picking object.	 *	 * @see away3d.entities.Entity#pickingCollider	 * @see away3d.core.pick.RaycastPicker	 */
	public interface IPickingCollider
	{
		/**		 * Sets the position and direction of a picking ray in local coordinates to the entity.		 *		 * @param localDirection The position vector in local coordinates		 * @param localPosition The direction vector in local coordinates		 */
		function setLocalRay(localPosition:Vector3D, localDirection:Vector3D):void;
		
		/**		 * Tests a <code>SubMesh</code> object for a collision with the picking ray.		 *		 * @param subMesh The <code>SubMesh</code> instance to be tested.		 * @param pickingCollisionVO The collision object used to store the collision results		 * @param shortestCollisionDistance The current value of the shortest distance to a detected collision along the ray.		 */
        // TODO: SubMesh - Implement & Integrate
		function testSubMeshCollision(subMesh:SubMesh, pickingCollisionVO:PickingCollisionVO, shortestCollisionDistance:Number):Boolean;
	}
}

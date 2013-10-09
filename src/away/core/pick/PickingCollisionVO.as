/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.pick
{
	import away.entities.Entity;
	import away.core.geom.Vector3D;
	import away.core.geom.Point;
	import away.core.base.IRenderable;

	/**
	public class PickingCollisionVO
	{
		/**
		public var entity:Entity;
		
		/**
		public var localPosition:Vector3D;
		
		/**
		public var localNormal:Vector3D;
		
		/**
		public var uv:Point;
		
		/**
		public var index:Number = 0;
		
		/**
		public var subGeometryIndex:Number = 0;
		
		/**
		public var localRayPosition:Vector3D;
		
		/**
		public var localRayDirection:Vector3D;
		
		/**
		public var rayPosition:Vector3D;
		
		/**
		public var rayDirection:Vector3D;
		
		/**
		public var rayOriginIsInsideBounds:Boolean = false;
		
		/**
		public var rayEntryDistance:Number = 0;
		
		/**
		public var renderable:IRenderable;
		
		/**
		public function PickingCollisionVO(entity:Entity):void
		{
			this.entity = entity;
		}
	
	}
}
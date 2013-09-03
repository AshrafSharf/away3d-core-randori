///<reference path="../_definitions.ts" />

package away.controllers
{
	import away.geom.Vector3D;
	import away.entities.Entity;
	import away.containers.ObjectContainer3D;

	/**
	public class SpringController extends LookAtController
	{
		private var _velocity:Vector3D;
		private var _dv:Vector3D;
		private var _stretch:Vector3D;
		private var _force:Vector3D;
		private var _acceleration:Vector3D;
		private var _desiredPosition:Vector3D;
		
		/**
		public var stiffness:Number;
		
		/**
		public var damping:Number;
		
		/**
		public var mass:Number;
		
		/**
		public var positionOffset:Vector3D = new Vector3D(0, 500, -1000);
		
		public function SpringController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, stiffness:Number = 1, mass:Number = 40, damping:Number = 4):void
		{
			super(targetObject, lookAtObject);
			
			this.stiffness = stiffness;
			this.damping = damping;
			this.mass = mass;
			
			this._velocity = new Vector3D();
            this._dv = new Vector3D();
            this._stretch = new Vector3D();
            this._force = new Vector3D();
            this._acceleration = new Vector3D();
            this._desiredPosition = new Vector3D();
		
		}
		
		override public function update(interpolate:Boolean = true):void
		{
			interpolate = interpolate; // prevents unused warning
			
			var offs:Vector3D;
			
			if (!_pLookAtObject || !_pTargetObject)
				return;
			
			offs = _pLookAtObject.transform.deltaTransformVector(positionOffset);
            _desiredPosition.x = _pLookAtObject.x + offs.x;
            _desiredPosition.y = _pLookAtObject.y + offs.y;
            _desiredPosition.z = _pLookAtObject.z + offs.z;

            _stretch.x = _pTargetObject.x - _desiredPosition.x;
            _stretch.y = _pTargetObject.y - _desiredPosition.y;
            _stretch.z = _pTargetObject.z - _desiredPosition.z;
            _stretch.scaleBy(-stiffness);

            _dv.copyFrom(_velocity);
            _dv.scaleBy(damping);

            _force.x = _stretch.x - _dv.x;
            _force.y = _stretch.y - _dv.y;
            _force.z = _stretch.z - _dv.z;

            _acceleration.copyFrom(_force);
            _acceleration.scaleBy(1/mass);

            _velocity.x += _acceleration.x;
            _velocity.y += _acceleration.y;
            _velocity.z += _acceleration.z;

            _pTargetObject.x += _velocity.x;
            _pTargetObject.y += _velocity.y;
            _pTargetObject.z += _velocity.z;
			
			super.update();
		}
	}
}
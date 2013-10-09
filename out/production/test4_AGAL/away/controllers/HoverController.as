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
	import away.core.geom.Vector3D;
	import away.core.math.MathConsts;

	/**
	public class HoverController extends LookAtController
	{
        public var _iCurrentPanAngle:Number = 0;
		public var _iCurrentTiltAngle:Number = 90;
		
		private var _panAngle:Number = 0;
		private var _tiltAngle:Number = 90;
		private var _distance:Number = 1000;
		private var _minPanAngle:Number = -Infinity;
		private var _maxPanAngle:Number = Infinity;
		private var _minTiltAngle:Number = -90;
		private var _maxTiltAngle:Number = 90;
		private var _steps:Number = 8;
		private var _yFactor:Number = 2;
		private var _wrapPanAngle:Boolean = false;
		
		/**
		public function get steps():Number
		{
			return this._steps;
		}
		
		public function set steps(val:Number):void
		{
			val = (val < 1)? 1 : val;
			
			if (this._steps == val)
				return;

            this._steps = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function get panAngle():Number
		{
			return this._panAngle;
		}
		
		public function set panAngle(val:Number):void
		{
			val = Math.max(this._minPanAngle, Math.min(this._maxPanAngle, val));
			
			if (this._panAngle == val)
				return;

            this._panAngle = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function get tiltAngle():Number
		{
			return this._tiltAngle;
		}
		
		public function set tiltAngle(val:Number):void
		{
			val = Math.max(this._minTiltAngle, Math.min(this._maxTiltAngle, val));
			
			if (this._tiltAngle == val)
				return;

            this._tiltAngle = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function get distance():Number
		{
			return this._distance;
		}
		
		public function set distance(val:Number):void
		{
			if (this._distance == val)
				return;

            this._distance = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function get minPanAngle():Number
		{
			return this._minPanAngle;
		}
		
		public function set minPanAngle(val:Number):void
		{
			if (this._minPanAngle == val)
				return;

            this._minPanAngle = val;

            this.panAngle = Math.max(this._minPanAngle, Math.min(this._maxPanAngle, this._panAngle));
		}
		
		/**
		public function get maxPanAngle():Number
		{
			return this._maxPanAngle;
		}
		
		public function set maxPanAngle(val:Number):void
		{
			if (this._maxPanAngle == val)
				return;

            this._maxPanAngle = val;

            this.panAngle = Math.max(this._minPanAngle, Math.min(this._maxPanAngle, this._panAngle));
		}
		
		/**
		public function get minTiltAngle():Number
		{
			return this._minTiltAngle;
		}
		
		public function set minTiltAngle(val:Number):void
		{
			if (this._minTiltAngle == val)
				return;

            this._minTiltAngle = val;

            this.tiltAngle = Math.max(this._minTiltAngle, Math.min(this._maxTiltAngle, this._tiltAngle));
		}
		
		/**
		public function get maxTiltAngle():Number
		{
			return this._maxTiltAngle;
		}
		
		public function set maxTiltAngle(val:Number):void
		{
			if (this._maxTiltAngle == val)
				return;

            this._maxTiltAngle = val;

            this.tiltAngle = Math.max(this._minTiltAngle, Math.min(this._maxTiltAngle, this._tiltAngle));
		}
		
		/**
		public function get yFactor():Number
		{
			return this._yFactor;
		}
		
		public function set yFactor(val:Number):void
		{
			if (this._yFactor == val)
				return;

            this._yFactor = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function get wrapPanAngle():Boolean
		{
			return this._wrapPanAngle;
		}
		
		public function set wrapPanAngle(val:Boolean):void
		{
			if (this._wrapPanAngle == val)
				return;

            this._wrapPanAngle = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function HoverController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000, minTiltAngle:Number = -90, maxTiltAngle:Number = 90, minPanAngle:Number = null, maxPanAngle:Number = null, steps:Number = 8, yFactor:Number = 2, wrapPanAngle:Boolean = false):void
		{
			targetObject = targetObject || null;
			lookAtObject = lookAtObject || null;
			panAngle = panAngle || 0;
			tiltAngle = tiltAngle || 90;
			distance = distance || 1000;
			minTiltAngle = minTiltAngle || -90;
			maxTiltAngle = maxTiltAngle || 90;
			minPanAngle = minPanAngle || null;
			maxPanAngle = maxPanAngle || null;
			steps = steps || 8;
			yFactor = yFactor || 2;
			wrapPanAngle = wrapPanAngle || false;

			super(targetObject, lookAtObject);
			
			this.distance = distance;
			this.panAngle = panAngle;
			this.tiltAngle = tiltAngle;
			this.minPanAngle = ( minPanAngle != null ) ? minPanAngle : -Infinity;
			this.maxPanAngle = ( maxPanAngle  != null ) ? maxPanAngle : Infinity;
			this.minTiltAngle = minTiltAngle;
			this.maxTiltAngle = maxTiltAngle;
			this.steps = steps;
			this.yFactor = yFactor;
			this.wrapPanAngle = wrapPanAngle;
			
			//values passed in contrustor are applied immediately
			this._iCurrentPanAngle = this._panAngle;
            this._iCurrentTiltAngle = this._tiltAngle;
		}
		
		/**
		override public function update(interpolate:Boolean = true):void
		{
			interpolate = interpolate || true;

			if (this._tiltAngle != this._iCurrentTiltAngle || this._panAngle != this._iCurrentPanAngle)
            {

                this.pNotifyUpdate();
				
				if (this._wrapPanAngle)
                {
					if (this._panAngle < 0)
                    {
                        this._iCurrentPanAngle += this._panAngle%360 + 360 - this._panAngle;
                        this._panAngle = this._panAngle%360 + 360;
					} else {
                        this._iCurrentPanAngle += this._panAngle%360 - this._panAngle;
                        this._panAngle = this._panAngle%360;
					}
					
					while (this._panAngle - this._iCurrentPanAngle < -180)
                        this._iCurrentPanAngle -= 360;
					
					while (this._panAngle - this._iCurrentPanAngle > 180)
                        this._iCurrentPanAngle += 360;
				}
				
				if (interpolate) {
                    this._iCurrentTiltAngle += (this._tiltAngle - this._iCurrentTiltAngle)/(this.steps + 1);
                    this._iCurrentPanAngle += (this._panAngle - this._iCurrentPanAngle)/(this.steps + 1);
				} else {
                    this._iCurrentPanAngle = this._panAngle;
                    this._iCurrentTiltAngle = this._tiltAngle;
				}
				
				//snap coords if angle differences are close
				if ((Math.abs(this.tiltAngle - this._iCurrentTiltAngle) < 0.01) && (Math.abs(this._panAngle - this._iCurrentPanAngle) < 0.01))
                {
                    this._iCurrentTiltAngle = this._tiltAngle;
                    this._iCurrentPanAngle = this._panAngle;
				}
			}
			
			var pos:Vector3D = (this.lookAtObject)? this.lookAtObject.position : (this.lookAtPosition)? this.lookAtPosition : this._pOrigin;
			this.targetObject.x = pos.x + this.distance*Math.sin(this._iCurrentPanAngle*MathConsts.DEGREES_TO_RADIANS)*Math.cos(this._iCurrentTiltAngle*MathConsts.DEGREES_TO_RADIANS);
            this.targetObject.z = pos.z + this.distance*Math.cos(this._iCurrentPanAngle*MathConsts.DEGREES_TO_RADIANS)*Math.cos(this._iCurrentTiltAngle*MathConsts.DEGREES_TO_RADIANS);
            this.targetObject.y = pos.y + this.distance*Math.sin(this._iCurrentTiltAngle*MathConsts.DEGREES_TO_RADIANS)*this.yFactor;
			
			super.update();
		}
	}
}
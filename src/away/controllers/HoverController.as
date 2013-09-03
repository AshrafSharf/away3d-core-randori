///<reference path="../_definitions.ts" />

package away.controllers
{
	import away.entities.Entity;
	import away.containers.ObjectContainer3D;
	import away.geom.Vector3D;
	import away.math.MathConsts;

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
			return _steps;
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
			return _panAngle;
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
			return _tiltAngle;
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
			return _distance;
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
			return _minPanAngle;
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
			return _maxPanAngle;
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
			return _minTiltAngle;
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
			return _maxTiltAngle;
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
			return _yFactor;
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
			return _wrapPanAngle;
		}
		
		public function set wrapPanAngle(val:Boolean):void
		{
			if (this._wrapPanAngle == val)
				return;

            this._wrapPanAngle = val;

            this.pNotifyUpdate();
		}
		
		/**
		public function HoverController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000, minTiltAngle:Number = -90, maxTiltAngle:Number = 90, minPanAngle:Number = NaN, maxPanAngle:Number = NaN, steps:Number = 8, yFactor:Number = 2, wrapPanAngle:Boolean = false):void
		{
			super(targetObject, lookAtObject);
			
			this.distance = distance;
			this.panAngle = panAngle;
			this.tiltAngle = tiltAngle;
			this.minPanAngle = minPanAngle || -Infinity;
			this.maxPanAngle = maxPanAngle || Infinity;
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
			if (_tiltAngle != _iCurrentTiltAngle || _panAngle != _iCurrentPanAngle)
            {

                pNotifyUpdate();
				
				if (_wrapPanAngle)
                {
					if (_panAngle < 0)
                    {
                        _iCurrentPanAngle += _panAngle%360 + 360 - _panAngle;
                        _panAngle = _panAngle%360 + 360;
					} else {
                        _iCurrentPanAngle += _panAngle%360 - _panAngle;
                        _panAngle = _panAngle%360;
					}
					
					while (_panAngle - _iCurrentPanAngle < -180)
                        _iCurrentPanAngle -= 360;
					
					while (_panAngle - _iCurrentPanAngle > 180)
                        _iCurrentPanAngle += 360;
				}
				
				if (interpolate) {
                    _iCurrentTiltAngle += (_tiltAngle - _iCurrentTiltAngle)/(steps + 1);
                    _iCurrentPanAngle += (_panAngle - _iCurrentPanAngle)/(steps + 1);
				} else {
                    _iCurrentPanAngle = _panAngle;
                    _iCurrentTiltAngle = _tiltAngle;
				}
				
				//snap coords if angle differences are close
				if ((Math.abs(tiltAngle - _iCurrentTiltAngle) < 0.01) && (Math.abs(_panAngle - _iCurrentPanAngle) < 0.01))
                {
                    _iCurrentTiltAngle = _tiltAngle;
                    _iCurrentPanAngle = _panAngle;
				}
			}
			
			var pos:Vector3D = (lookAtObject)? lookAtObject.position : (lookAtPosition)? lookAtPosition : _pOrigin;
			targetObject.x = pos.x + distance*Math.sin(_iCurrentPanAngle*MathConsts.DEGREES_TO_RADIANS)*Math.cos(_iCurrentTiltAngle*MathConsts.DEGREES_TO_RADIANS);
            targetObject.z = pos.z + distance*Math.cos(_iCurrentPanAngle*MathConsts.DEGREES_TO_RADIANS)*Math.cos(_iCurrentTiltAngle*MathConsts.DEGREES_TO_RADIANS);
            targetObject.y = pos.y + distance*Math.sin(_iCurrentTiltAngle*MathConsts.DEGREES_TO_RADIANS)*yFactor;
			
			super.update();
		}
	}
}
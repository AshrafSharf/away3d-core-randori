///<reference path="../_definitions.ts" />

package away.controllers
{
	import away.entities.Entity;
	import away.math.MathConsts;

	/**
	public class FirstPersonController extends ControllerBase
	{
		public var _iCurrentPanAngle:Number = 0;
        public var _iCurrentTiltAngle:Number = 90;
		
		private var _panAngle:Number = 0;
		private var _tiltAngle:Number = 90;
		private var _minTiltAngle:Number = -90;
		private var _maxTiltAngle:Number = 90;
		private var _steps:Number = 8;
		private var _walkIncrement:Number = 0;
		private var _strafeIncrement:Number = 0;
		private var _wrapPanAngle:Boolean = false;
		
		public var fly:Boolean = false;
		
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
		public function FirstPersonController(targetObject:Entity = null, panAngle:Number = 0, tiltAngle:Number = 90, minTiltAngle:Number = -90, maxTiltAngle:Number = 90, steps:Number = 8, wrapPanAngle:Boolean = false):void
		{
			super(targetObject);
			
			this.panAngle = panAngle;
			this.tiltAngle = tiltAngle;
			this.minTiltAngle = minTiltAngle;
			this.maxTiltAngle = maxTiltAngle;
			this.steps = steps;
			this.wrapPanAngle = wrapPanAngle;
			
			//values passed in contrustor are applied immediately
            this._iCurrentPanAngle = this._panAngle;
            this._iCurrentTiltAngle = this._tiltAngle;
		}
		
		/**
		override public function update(interpolate:Boolean = true):void
		{
			if (_tiltAngle != _iCurrentTiltAngle || _panAngle != _iCurrentPanAngle) {
				
				pNotifyUpdate();
				
				if (_wrapPanAngle) {
					if (_panAngle < 0) {
                        _iCurrentPanAngle += _panAngle%360 + 360 - _panAngle;
                        _panAngle =this. _panAngle%360 + 360;
					} else {
                        _iCurrentPanAngle += _panAngle%360 - _panAngle;
                        _panAngle = _panAngle%360;
					}
					
					while (_panAngle - _iCurrentPanAngle < -180)
                        _iCurrentPanAngle -= 360;
					
					while (_panAngle - _iCurrentPanAngle > 180)
                        _iCurrentPanAngle += 360;
				}
				
				if (interpolate)
                {
                    _iCurrentTiltAngle += (_tiltAngle - _iCurrentTiltAngle)/(steps + 1);
                    _iCurrentPanAngle += (_panAngle - _iCurrentPanAngle)/(steps + 1);
				} else {
                    _iCurrentTiltAngle = _tiltAngle;
                    _iCurrentPanAngle = _panAngle;
				}
				
				//snap coords if angle differences are close
				if ((Math.abs(tiltAngle - _iCurrentTiltAngle) < 0.01) && (Math.abs(_panAngle - _iCurrentPanAngle) < 0.01)) {
                    _iCurrentTiltAngle = _tiltAngle;
                    _iCurrentPanAngle = _panAngle;
				}
			}

            targetObject.rotationX = _iCurrentTiltAngle;
            targetObject.rotationY = _iCurrentPanAngle;
			
			if (_walkIncrement)
            {
				if (fly)
                    targetObject.moveForward(_walkIncrement);
				else {
                    targetObject.x += _walkIncrement*Math.sin(_panAngle*MathConsts.DEGREES_TO_RADIANS);
                    targetObject.z += _walkIncrement*Math.cos(_panAngle*MathConsts.DEGREES_TO_RADIANS);
				}
				_walkIncrement = 0;
			}
			
			if (_strafeIncrement) {
                targetObject.moveRight(_strafeIncrement);
                _strafeIncrement = 0;
			}
		
		}
		
		public function incrementWalk(val:Number):void
		{
			if (val == 0)
				return;

            _walkIncrement += val;

            pNotifyUpdate();
		}
		
		public function incrementStrafe(val:Number):void
		{
			if (val == 0)
				return;

            _strafeIncrement += val;

            pNotifyUpdate();
		}
	
	}
}
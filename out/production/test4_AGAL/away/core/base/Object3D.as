/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.base
{
	import away.library.assets.NamedAssetBase;
	import away.controllers.ControllerBase;
	import away.events.Object3DEvent;
	import away.core.geom.Vector3D;
	import away.core.geom.Matrix3D;
	import away.core.math.MathConsts;
	import away.core.math.Matrix3DUtils;
	import away.utils.VectorInit;
	//import away3d.arcane;
	//import away3d.controllers.*;
	//import away3d.core.math.*;
	//import away3d.events.*;
	//import away3d.library.assets.*;
	
	//import flash.geom.Matrix3D;
	//import flash.geom.Vector3D;
	
	//use namespace arcane;
	
	/**
	//[Event(name="positionChanged", type="away3d.events.Object3DEvent")]
	
	/**
	//[Event(name="scaleChanged", type="away3d.events.Object3DEvent")]
	
	/**
	//[Event(name="rotationChanged", type="away3d.events.Object3DEvent")]

    /**
	public class Object3D extends NamedAssetBase
	{
		/** @private */
		public var _iController:ControllerBase;// Arcane
		
		private var _smallestNumber:Number = 0.0000000000000000000001;
		private var _transformDirty:Boolean = true;
		
		private var _positionDirty:Boolean = true;
		private var _rotationDirty:Boolean = true;
		private var _scaleDirty:Boolean = true;
		
		// TODO: not used
		// private var _positionValuesDirty:boolean;
		// private var _rotationValuesDirty:boolean;
		// private var _scaleValuesDirty:boolean;

		private var _positionChanged:Object3DEvent;
		private var _rotationChanged:Object3DEvent;
		private var _scaleChanged:Object3DEvent;

		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var _rotationZ:Number = 0;
		private var _eulers:Vector3D = new Vector3D();
		private var _flipY:Matrix3D = new Matrix3D();

		private var _listenToPositionChanged:Boolean = false;
		private var _listenToRotationChanged:Boolean = false;
		private var _listenToScaleChanged:Boolean = false;
		private var _zOffset:Number = 0;
		
		private function invalidatePivot():void
		{
			this._pivotZero = (this._pivotPoint.x == 0) && (this._pivotPoint.y == 0) && (this._pivotPoint.z == 0);
			this.iInvalidateTransform();

		}
		
		private function invalidatePosition():void
		{
			if (this._positionDirty)
				return;
			
			this._positionDirty = true;
			
			this.iInvalidateTransform();

			if (this._listenToPositionChanged)
				this.notifyPositionChanged();

		}

		private function notifyPositionChanged():void
		{
			if (!this._positionChanged)
            {


				this._positionChanged = new Object3DEvent(Object3DEvent.POSITION_CHANGED, this);

            }
			this.dispatchEvent( this._positionChanged );
		}


		override public function addEventListener(type:String, listener:Function, target:Object):void
		{
			super.addEventListener(type, listener, target ) ;//, priority, useWeakReference);

			switch (type) {
				case Object3DEvent.POSITION_CHANGED:
                    this._listenToPositionChanged = true;
					break;
				case Object3DEvent.ROTATION_CHANGED:
                    this._listenToRotationChanged = true;
					break;
				case Object3DEvent.SCALE_CHANGED:
					this._listenToScaleChanged = true;
					break;
			}
		}

		override public function removeEventListener(type:String, listener:Function, target:Object):void
		{
			super.removeEventListener(type, listener, target);
			
			if (this.hasEventListener(type , listener , target ))
				return;
			
			switch (type) {

				case Object3DEvent.POSITION_CHANGED:
					this._listenToPositionChanged = false;
					break;

				case Object3DEvent.ROTATION_CHANGED:
                    this._listenToRotationChanged = false;
					break;

				case Object3DEvent.SCALE_CHANGED:
                    this._listenToScaleChanged = false;
					break;
			}
		}

		private function invalidateRotation():void
		{
			if (this._rotationDirty)
            {

                return;

            }

			this._rotationDirty = true;
			
			this.iInvalidateTransform();


			if (this._listenToRotationChanged)
				this.notifyRotationChanged();


		}

		private function notifyRotationChanged():void
		{
			if (!this._rotationChanged)
				this._rotationChanged = new Object3DEvent(Object3DEvent.ROTATION_CHANGED, this);
			
			this.dispatchEvent(this._rotationChanged);
		}

		private function invalidateScale():void
		{
			if (this._scaleDirty)
            {

                return;

            }

			this._scaleDirty = true;
			
			this.iInvalidateTransform();

			if (this._listenToScaleChanged)
                this.notifyScaleChanged();

		}

		private function notifyScaleChanged():void
		{
			if (!this._scaleChanged)
				this._scaleChanged = new Object3DEvent(Object3DEvent.SCALE_CHANGED, this);
			
			this.dispatchEvent(this._scaleChanged);
		}

		public var _pTransform:Matrix3D = new Matrix3D();
        public var _pScaleX:Number = 1;
        public var _pScaleY:Number = 1;
        public var _pScaleZ:Number = 1;
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _z:Number = 0;
		private var _pivotPoint:Vector3D = new Vector3D();
		private var _pivotZero:Boolean = true;
		public var _pPos:Vector3D = new Vector3D();
		private var _rot:Vector3D = new Vector3D();
		private var _sca:Vector3D = new Vector3D();
        private var _transformComponents:Vector.<Vector3D>;
		
		/**
		public var extra:Object;
		
		/**
		public function get x():Number
		{
			return this._x;
		}
		
		public function set x(val:Number):void
		{
			if (this._x == val)
            {

                return;

            }


			this._x = val;
			this.invalidatePosition();

		}
		
		/**
		public function get y():Number
		{
			return this._y;
		}
		
		public function set y(val:Number):void
		{
			if (this._y == val)
            {

                return;

            }

			this._y = val;
			this.invalidatePosition();

		}
		
		/**
		public function get z():Number
		{
			return this._z;
		}
		
		public function set z(val:Number):void
		{
			if (this._z == val)
            {

                return;

            }

			this._z = val;
			this.invalidatePosition();

		}
		
		/**
		public function get rotationX():Number
		{
			return this._rotationX*MathConsts.RADIANS_TO_DEGREES;
		}
		
		public function set rotationX(val:Number):void
		{
			if (this.rotationX == val)
            {

                return;

            }

			
			this._rotationX = val*MathConsts.DEGREES_TO_RADIANS;
			this.invalidateRotation();
		}
		
		/**
		public function get rotationY():Number
		{
			return this._rotationY*MathConsts.RADIANS_TO_DEGREES;
		}
		
		public function set rotationY(val:Number):void
		{
			if (this.rotationY == val)
            {

                return;

            }

			this._rotationY = val*MathConsts.DEGREES_TO_RADIANS;
			
			this.invalidateRotation();
		}
		
		/**
		public function get rotationZ():Number
		{
			return this._rotationZ*MathConsts.RADIANS_TO_DEGREES;
		}
		
		public function set rotationZ(val:Number):void
		{
			if (this.rotationZ == val)
            {

                return;

            }

			
			this._rotationZ = val*MathConsts.DEGREES_TO_RADIANS;
			
			this.invalidateRotation();
		}
		
		/**
		public function get scaleX():Number
		{
			return this._pScaleX;
		}
		
		public function set scaleX(val:Number):void
		{
			if (this._pScaleX == val)
            {

                return;

            }

			this._pScaleX = val;
			
			this.invalidateScale();
		}
		
		/**
		public function get scaleY():Number
		{
			return this._pScaleY;
		}
		
		public function set scaleY(val:Number):void
		{
			if (this._pScaleY == val)
            {

                return;

            }

            this._pScaleY = val;

            this.invalidateScale();

		}
		
		/**
		public function get scaleZ():Number
		{
			return this._pScaleZ;
		}
		
		public function set scaleZ(val:Number):void
		{
			if (this._pScaleZ == val)
            {

                return;

            }

			this._pScaleZ = val;
			this.invalidateScale();

		}
		
		/**
		public function get eulers():Vector3D
		{
			this._eulers.x = this._rotationX*MathConsts.RADIANS_TO_DEGREES;
            this._eulers.y = this._rotationY*MathConsts.RADIANS_TO_DEGREES;
            this._eulers.z = this._rotationZ*MathConsts.RADIANS_TO_DEGREES;
			
			return this._eulers;
		}
		
		public function set eulers(value:Vector3D):void
		{
			this._rotationX = value.x*MathConsts.DEGREES_TO_RADIANS;
            this._rotationY = value.y*MathConsts.DEGREES_TO_RADIANS;
            this._rotationZ = value.z*MathConsts.DEGREES_TO_RADIANS;

            this.invalidateRotation();
		}
		
		/**

		public function get transform():Matrix3D
		{
			if (this._transformDirty)
            {

                this.pUpdateTransform()

            }

			
			return this._pTransform;
		}

		public function set transform(val:Matrix3D):void
		{

            // TODO: From AS3 - Do we still need this in JS ?
            //ridiculous matrix error
            //*
            if (!val.rawData[0])
            {

                var raw:Vector.<Number> = Matrix3DUtils.RAW_DATA_CONTAINER;
                val.copyRawDataTo( raw );
                raw[0] = this._smallestNumber;
                val.copyRawDataFrom(raw);
            }
            //*/
			var elements:Vector.<Vector3D>= val.decompose();
			var vec:Vector3D;
			
			vec = elements[0];
			
			if (this._x != vec.x || this._y != vec.y || this._z != vec.z)
            {
                this._x = vec.x;
                this._y = vec.y;
                this._z = vec.z;
				
				this.invalidatePosition();
			}
			
			vec = elements[1];
			
			if (this._rotationX != vec.x || this._rotationY != vec.y || this._rotationZ != vec.z)
            {
                this._rotationX = vec.x;
                this._rotationY = vec.y;
                this._rotationZ = vec.z;

                this.invalidateRotation();
			}
			
			vec = elements[2];
			
			if (this._pScaleX != vec.x || this._pScaleY != vec.y || this._pScaleZ != vec.z) {
                this._pScaleX = vec.x;
                this._pScaleY = vec.y;
                this._pScaleZ = vec.z;

                this.invalidateScale();
			}
		}


		/**

		public function get pivotPoint():Vector3D
		{
			return this._pivotPoint;
		}


		public function set pivotPoint(pivot:Vector3D):void
		{
			this._pivotPoint = pivot.clone();

            this.invalidatePivot();
		}

		/**
		public function get position():Vector3D
		{
			this._pTransform.copyColumnTo(3, this._pPos);
			
			return this._pPos.clone();
		}
		
		public function set position(value:Vector3D):void
		{
			this._x = value.x;
            this._y = value.y;
            this._z = value.z;

            this.invalidatePosition();
		}
		
		/**
		public function get forwardVector():Vector3D
		{
			return Matrix3DUtils.getForward( this.transform );
		}
		/**
		public function get rightVector():Vector3D
		{
			return Matrix3DUtils.getRight( this.transform );
		}
		/**
		public function get upVector():Vector3D
		{
			return Matrix3DUtils.getUp( this.transform );
		}
		/**
		public function get backVector():Vector3D
		{
			var director:Vector3D = Matrix3DUtils.getForward( this.transform);
			director.negate();
			
			return director;
		}
		/**
		public function get leftVector():Vector3D
		{
			var director:Vector3D = Matrix3DUtils.getRight( this.transform );
			director.negate();
			
			return director;
		}
		/**
		public function get downVector():Vector3D
		{
			var director:Vector3D = Matrix3DUtils.getUp( this.transform );
			director.negate();
			
			return director;
		}
		/**
		public function Object3D():void
		{

            super(null);

			// Cached vector of transformation components used when
			// recomposing the transform matrix in updateTransform()

            this._transformComponents = VectorInit.AnyClass(Vector3D, 3);//_transformComponents = new Vector.<Vector3D>(3, true);

			this._transformComponents[0] = this._pPos;
            this._transformComponents[1] = this._rot;
            this._transformComponents[2] = this._sca;
			
            this._pTransform.identity();
			
			this._flipY.appendScale( 1, -1, 1 );
		}
		
		/**
		public function scale(value:Number):void
		{
			this._pScaleX *= value;
            this._pScaleY *= value;
            this._pScaleZ *= value;

            this.invalidateScale();
		}
		/**
		public function moveForward(distance:Number):void
		{
			this.translateLocal(Vector3D.Z_AXIS, distance);
		}
		/**
		public function moveBackward(distance:Number):void
		{
			this.translateLocal(Vector3D.Z_AXIS, -distance);
		}
		/**

		public function moveLeft(distance:Number):void
		{
			this.translateLocal(Vector3D.X_AXIS, -distance);
		}

		/**
		public function moveRight(distance:Number):void
		{
			this.translateLocal(Vector3D.X_AXIS, distance);
		}
		/**
		public function moveUp(distance:Number):void
		{
			this.translateLocal(Vector3D.Y_AXIS, distance);
		}
		/**
		public function moveDown(distance:Number):void
		{
			this.translateLocal(Vector3D.Y_AXIS, -distance);
		}

		/**

		public function moveTo(dx:Number, dy:Number, dz:Number):void
		{
			if (this._x == dx && this._y == dy && this._z == dz)
            {

                return;

            }

            this._x = dx;
            this._y = dy;
            this._z = dz;

            this.invalidatePosition();
		}

		/**
		public function movePivot(dx:Number, dy:Number, dz:Number):void
		{

            if ( this._pivotPoint == null )
            {

                this._pivotPoint = new Vector3D();

            }

			this._pivotPoint.x += dx;
            this._pivotPoint.y += dy;
            this._pivotPoint.z += dz;

            this.invalidatePivot();
		}
		/**
		public function translate(axis:Vector3D, distance:Number):void
		{
			var x:Number = axis.x, y:Number = axis.y, z:Number = axis.z;
			var len:Number = distance/Math.sqrt(x*x + y*y + z*z);
			
			this._x += x*len;
            this._y += y*len;
            this._z += z*len;
			
			this.invalidatePosition();
		}
		/**
		public function translateLocal(axis:Vector3D, distance:Number):void
		{
			var x:Number = axis.x, y:Number = axis.y, z:Number = axis.z;
			var len:Number = distance/Math.sqrt(x*x + y*y + z*z);
			
			this.transform.prependTranslation(x*len, y*len, z*len);
			
			this._pTransform.copyColumnTo(3, this._pPos);
			
			this._x = this._pPos.x;
            this._y = this._pPos.y;
            this._z = this._pPos.z;

            this.invalidatePosition();
		}
		/**
		public function pitch(angle:Number):void
		{
            this.rotate(Vector3D.X_AXIS, angle);
		}
		/**
		public function yaw(angle:Number):void
		{
			this.rotate(Vector3D.Y_AXIS, angle);
		}
		/**
		public function roll(angle:Number):void
		{
			this.rotate(Vector3D.Z_AXIS, angle);
		}
		public function clone():Object3D
		{
			var clone:Object3D = new Object3D();
		    	clone.pivotPoint = this.pivotPoint;
			    clone.transform = this._pTransform;
			    clone.name = name;
			// todo: implement for all subtypes
			return clone;
		}
		/**
		public function rotateTo(ax:Number, ay:Number, az:Number):void
		{
			this._rotationX = ax*MathConsts.DEGREES_TO_RADIANS;
            this._rotationY = ay*MathConsts.DEGREES_TO_RADIANS;
            this._rotationZ = az*MathConsts.DEGREES_TO_RADIANS;
			
			this.invalidateRotation();
		}
		/**
		public function rotate(axis:Vector3D, angle:Number):void
		{
			this.transform.prependRotation(angle, axis);
			this.transform = this._pTransform;

		}
		/**
		public function lookAt(target:Vector3D, upAxis:Vector3D = null):void
		{
			upAxis = upAxis || null;


			var yAxis:Vector3D;
            var zAxis:Vector3D;
            var xAxis:Vector3D;
			var raw:Vector.<Number>;

            if ( upAxis == null)
            {
                upAxis = Vector3D.Y_AXIS;
            }

			zAxis = target.subtract(this.position);
			zAxis.normalize();
			
			xAxis = upAxis.crossProduct(zAxis);
			xAxis.normalize();
			
			if (xAxis.length < .05)
				xAxis = upAxis.crossProduct(Vector3D.Z_AXIS);
			
			yAxis = zAxis.crossProduct(xAxis);
			
			raw = Matrix3DUtils.RAW_DATA_CONTAINER;
			
			raw[0] = this._pScaleX*xAxis.x;
			raw[1] = this._pScaleX*xAxis.y;
			raw[2] = this._pScaleX*xAxis.z;
			raw[3] = 0;
			
			raw[4] = this._pScaleY*yAxis.x;
			raw[5] = this._pScaleY*yAxis.y;
			raw[6] = this._pScaleY*yAxis.z;
			raw[7] = 0;
			
			raw[8] = this._pScaleZ*zAxis.x;
			raw[9] = this._pScaleZ*zAxis.y;
			raw[10] = this._pScaleZ*zAxis.z;
			raw[11] = 0;
			
			raw[12] = this._x;
			raw[13] = this._y;
			raw[14] = this._z;
			raw[15] = 1;

            this._pTransform.copyRawDataFrom(raw);

            this.transform = this._pTransform;
			
			if (zAxis.z < 0)
            {
                this.rotationY = (180 - this.rotationY);
                this.rotationX -= 180;
                this.rotationZ -= 180;
			}

		}
		/**
		override public function dispose():void
		{
		}
		/**
		public function disposeAsset():void
		{
			this.dispose();
		}
		/**

		public function iInvalidateTransform():void
		{
			this._transformDirty = true;
		}


		public function pUpdateTransform():void
		{

			this._pPos.x = this._x;
            this._pPos.y = this._y;
            this._pPos.z = this._z;

            this._rot.x = this._rotationX;
            this._rot.y = this._rotationY;
            this._rot.z = this._rotationZ;

            this._sca.x = this._pScaleX;
            this._sca.y = this._pScaleY;
            this._sca.z = this._pScaleZ;

            this._pTransform.recompose(this._transformComponents);

			if (!this._pivotZero)
            {
                this._pTransform.prependTranslation(-this._pivotPoint.x, -this._pivotPoint.y, -this._pivotPoint.z);
                this._pTransform.appendTranslation(this._pivotPoint.x, this._pivotPoint.y, this._pivotPoint.z);
			}

            this._transformDirty = false;
            this._positionDirty = false;
            this._rotationDirty = false;
            this._scaleDirty = false;

		}

		public function get zOffset():Number
		{
			return this._zOffset;
		}
		
		public function set zOffset(value:Number):void
		{
			this._zOffset = value;
		}
	}

}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.math
{
	import away.core.geom.Vector3D;

	public class Plane3D
	{
		/**
		public var a:Number = 0;
		
		/**
		public var b:Number = 0;
		
		/**
		public var c:Number = 0;
		
		/**
		public var d:Number = 0;
		
		public var _iAlignment:Number = 0;
		
		// indicates the alignment of the plane
		public static var ALIGN_ANY:Number = 0;
		public static var ALIGN_XY_AXIS:Number = 1;
		public static var ALIGN_YZ_AXIS:Number = 2;
		public static var ALIGN_XZ_AXIS:Number = 3;
		
		/**
		public function Plane3D(a:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0):void
		{
			a = a || 0;
			b = b || 0;
			c = c || 0;
			d = d || 0;

			this.a = a;
			this.b = b;
			this.c = c;
			this.d = d;

			if (a == 0 && b == 0)
            {

                this._iAlignment = Plane3D.ALIGN_XY_AXIS;

            }
			else if (b == 0 && c == 0)
            {

                this._iAlignment = Plane3D.ALIGN_YZ_AXIS;

            }
			else if (a == 0 && c == 0)
            {

                this._iAlignment = Plane3D.ALIGN_XZ_AXIS;

            }
			else
            {

                this._iAlignment = Plane3D.ALIGN_ANY;

            }

		}
		
		/**
		public function fromPoints(p0:Vector3D, p1:Vector3D, p2:Vector3D):void
		{
			var d1x:Number = p1.x - p0.x;
			var d1y:Number = p1.y - p0.y;
			var d1z:Number = p1.z - p0.z;
			
			var d2x:Number = p2.x - p0.x;
			var d2y:Number = p2.y - p0.y;
			var d2z:Number = p2.z - p0.z;
			
			this.a = d1y*d2z - d1z*d2y;
            this.b = d1z*d2x - d1x*d2z;
            this.c = d1x*d2y - d1y*d2x;
            this.d = this.a*p0.x + this.b*p0.y + this.c*p0.z;
			
			// not using epsilon, since a plane is infinite and a small incorrection can grow very large
			if (this.a == 0 && this.b == 0)
            {

                this._iAlignment = Plane3D.ALIGN_XY_AXIS;

            }
			else if (this.b == 0 && this.c == 0)
            {

                this._iAlignment = Plane3D.ALIGN_YZ_AXIS;

            }
			else if (this.a == 0 && this.c == 0)
            {

                this._iAlignment = Plane3D.ALIGN_XZ_AXIS;

            }
			else
            {

                this._iAlignment = Plane3D.ALIGN_ANY;

            }

		}
		
		/**
		public function fromNormalAndPoint(normal:Vector3D, point:Vector3D):void
		{
			this.a = normal.x;
            this.b = normal.y;
            this.c = normal.z;
            this.d = this.a*point.x + this.b*point.y + this.c*point.z;
			if (this.a == 0 && this.b == 0)
            {

                this._iAlignment = Plane3D.ALIGN_XY_AXIS;

            }
			else if (this.b == 0 && this.c == 0)
            {

                this._iAlignment = Plane3D.ALIGN_YZ_AXIS;

            }
			else if (this.a == 0 && this.c == 0)
            {

                this._iAlignment = Plane3D.ALIGN_XZ_AXIS;

            }
			else
            {

                this._iAlignment = Plane3D.ALIGN_ANY;

            }

		}
		
		/**
		public function normalize():Plane3D
		{
			var len:Number = 1/Math.sqrt(this.a*this.a + this.b*this.b + this.c*this.c);
			this.a *= len;
            this.b *= len;
            this.c *= len;
            this.d *= len;
			return this;
		}
		
		/**
		public function distance(p:Vector3D):Number
		{

			if ( this._iAlignment == Plane3D.ALIGN_YZ_AXIS)
            {

                return this.a*p.x - this.d;

            }
			else if ( this._iAlignment == Plane3D.ALIGN_XZ_AXIS)
            {
                return this.b*p.y - this.d;
            }

			else if ( this._iAlignment == Plane3D.ALIGN_XY_AXIS)
            {

                return this.c*p.z - this.d;

            }
			else
            {

                return this.a*p.x + this.b*p.y + this.c*p.z - this.d;

            }

		}
		
		/**
		public function classifyPoint(p:Vector3D, epsilon:Number = 0.01):Number
		{
			epsilon = epsilon || 0.01;

			// check NaN
			if (this.d != this.d)
				return PlaneClassification.FRONT;
			
			var len:Number;
			if (this._iAlignment == Plane3D.ALIGN_YZ_AXIS)
				len = this.a*p.x - this.d;
			else if (this._iAlignment == Plane3D.ALIGN_XZ_AXIS)
				len = this.b*p.y - this.d;
			else if (this._iAlignment == Plane3D.ALIGN_XY_AXIS)
				len = this.c*p.z - this.d;
			else
				len = this.a*p.x + this.b*p.y + this.c*p.z - this.d;
			
			if (len < -epsilon)
				return PlaneClassification.BACK;
			else if (len > epsilon)
				return PlaneClassification.FRONT;
			else
				return PlaneClassification.INTERSECT;
		}
		
		public function toString():String
		{
			return "Plane3D [a:" + this.a + ", b:" + this.b + ", c:" + this.c + ", d:" + this.d + "]";
		}
	}
}
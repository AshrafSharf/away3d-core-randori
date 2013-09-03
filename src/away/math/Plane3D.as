
///<reference path="../_definitions.ts"/>

package away.math
{
	import away.geom.Vector3D;

	public class Plane3D
	{
		/**		 * The A coefficient of this plane. (Also the x dimension of the plane normal)		 */
		public var a:Number;
		
		/**		 * The B coefficient of this plane. (Also the y dimension of the plane normal)		 */
		public var b:Number;
		
		/**		 * The C coefficient of this plane. (Also the z dimension of the plane normal)		 */
		public var c:Number;
		
		/**		 * The D coefficient of this plane. (Also the inverse dot product between normal and point)		 */
		public var d:Number;
		
		public var _iAlignment:Number;
		
		// indicates the alignment of the plane
		public static var ALIGN_ANY:Number = 0;
		public static var ALIGN_XY_AXIS:Number = 1;
		public static var ALIGN_YZ_AXIS:Number = 2;
		public static var ALIGN_XZ_AXIS:Number = 3;
		
		/**		 * Create a Plane3D with ABCD coefficients		 */
		public function Plane3D(a:Number = 0, b:Number = 0, c:Number = 0, d:Number = 0):void
		{
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
		
		/**		 * Fills this Plane3D with the coefficients from 3 points in 3d space.		 * @param p0 Vector3D		 * @param p1 Vector3D		 * @param p2 Vector3D		 */
		public function fromPoints(p0:Vector3D, p1:Vector3D, p2:Vector3D):void
		{
			var d1x:Number = p1.x - p0.x;
			var d1y:Number = p1.y - p0.y;
			var d1z:Number = p1.z - p0.z;
			
			var d2x:Number = p2.x - p0.x;
			var d2y:Number = p2.y - p0.y;
			var d2z:Number = p2.z - p0.z;
			
			a = d1y*d2z - d1z*d2y;
            b = d1z*d2x - d1x*d2z;
            c = d1x*d2y - d1y*d2x;
            d = a*p0.x + b*p0.y + c*p0.z;
			
			// not using epsilon, since a plane is infinite and a small incorrection can grow very large
			if (a == 0 && b == 0)
            {

                _iAlignment = Plane3D.ALIGN_XY_AXIS;

            }
			else if (b == 0 && c == 0)
            {

                _iAlignment = Plane3D.ALIGN_YZ_AXIS;

            }
			else if (a == 0 && c == 0)
            {

                _iAlignment = Plane3D.ALIGN_XZ_AXIS;

            }
			else
            {

                _iAlignment = Plane3D.ALIGN_ANY;

            }

		}
		
		/**		 * Fills this Plane3D with the coefficients from the plane's normal and a point in 3d space.		 * @param normal Vector3D		 * @param point  Vector3D		 */
		public function fromNormalAndPoint(normal:Vector3D, point:Vector3D):void
		{
			a = normal.x;
            b = normal.y;
            c = normal.z;
            d = a*point.x + b*point.y + c*point.z;
			if (a == 0 && b == 0)
            {

                _iAlignment = Plane3D.ALIGN_XY_AXIS;

            }
			else if (b == 0 && c == 0)
            {

                _iAlignment = Plane3D.ALIGN_YZ_AXIS;

            }
			else if (a == 0 && c == 0)
            {

                _iAlignment = Plane3D.ALIGN_XZ_AXIS;

            }
			else
            {

                _iAlignment = Plane3D.ALIGN_ANY;

            }

		}
		
		/**		 * Normalize this Plane3D		 * @return Plane3D This Plane3D.		 */
		public function normalize():Plane3D
		{
			var len:Number = 1/Math.sqrt(a*a + b*b + c*c);
			a *= len;
            b *= len;
            c *= len;
            d *= len;
			return this;
		}
		
		/**		 * Returns the signed distance between this Plane3D and the point p.		 * @param p Vector3D		 * @returns Number		 */
		public function distance(p:Vector3D):Number
		{

			if ( _iAlignment == Plane3D.ALIGN_YZ_AXIS)
            {

                return a*p.x - d;

            }
			else if ( _iAlignment == Plane3D.ALIGN_XZ_AXIS)
            {
                return b*p.y - d;
            }

			else if ( _iAlignment == Plane3D.ALIGN_XY_AXIS)
            {

                return c*p.z - d;

            }
			else
            {

                return a*p.x + b*p.y + c*p.z - d;

            }

		}
		
		/**		 * Classify a point against this Plane3D. (in front, back or intersecting)		 * @param p Vector3D		 * @return int Plane3.FRONT or Plane3D.BACK or Plane3D.INTERSECT		 */
		public function classifyPoint(p:Vector3D, epsilon:Number = 0.01):Number
		{
			// check NaN
			if (d != d)
				return PlaneClassification.FRONT;
			
			var len:Number;
			if (_iAlignment == Plane3D.ALIGN_YZ_AXIS)
				len = a*p.x - d;
			else if (_iAlignment == Plane3D.ALIGN_XZ_AXIS)
				len = b*p.y - d;
			else if (_iAlignment == Plane3D.ALIGN_XY_AXIS)
				len = c*p.z - d;
			else
				len = a*p.x + b*p.y + c*p.z - d;
			
			if (len < -epsilon)
				return PlaneClassification.BACK;
			else if (len > epsilon)
				return PlaneClassification.FRONT;
			else
				return PlaneClassification.INTERSECT;
		}
		
		public function toString():String
		{
			return "Plane3D [a:" + a + ", b:" + b + ", c:" + c + ", d:" + d + "]";
		}
	}
}

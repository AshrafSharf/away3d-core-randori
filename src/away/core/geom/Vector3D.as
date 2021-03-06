/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.geom {

    public class Vector3D {

        public static var X_AXIS:Vector3D = new Vector3D( 1 , 0 , 0 );
        public static var Y_AXIS:Vector3D = new Vector3D( 0 , 1 , 0 );
        public static var Z_AXIS:Vector3D = new Vector3D( 0 , 0 , 1 );
        /**         * The first element of a Vector3D object, such as the x coordinate of a point in the three-dimensional space.         */
        public var x:Number = 0;

        /*         *The second element of a Vector3D object, such as the y coordinate of a point in the three-dimensional space.         */
        public var y:Number = 0;

        /**         * The third element of a Vector3D object, such as the y coordinate of a point in the three-dimensional space.         */
        public var z:Number = 0;

        /**         * The fourth element of a Vector3D object (in addition to the x, y, and z properties) can hold data such as         * the angle of rotation.         */
        public var w:Number = 0;

        /**         * Creates an instance of a Vector3D object.         */
        public function Vector3D(x:Number = 0, y:Number = 0, z:Number = 0, w:Number = 0):void {
        			x = x || 0;
			y = y || 0;
			z = z || 0;
			w = w || 0;

            this.x = x;
            this.y = y;
            this.z = z;
            this.w = w;
        }

        /**         * [read-only] The length, magnitude, of the current Vector3D object from the origin (0,0,0) to the object's         * x, y, and z coordinates.         * @returns The length of the Vector3D         */
        public function get length():Number {
                    return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
        }

        /**         * [read-only] The square of the length of the current Vector3D object, calculated using the x, y, and z         * properties.         * @returns The squared length of the vector         */
        public function get lengthSquared():Number {
                    return (this.x * this.x + this.y * this.y + this.z * this.z);
        }

        /**         * Adds the value of the x, y, and z elements of the current Vector3D object to the values of the x, y, and z         * elements of another Vector3D object.         */
        public function add(a:Vector3D):Vector3D {
                    return new Vector3D(this.x + a.x, this.y + a.y, this.z + a.z, this.w + a.w)
        }

        /**         * [static] Returns the angle in radians between two vectors.         */
        public static function angleBetween(a:Vector3D, b:Vector3D):Number {
                    return Math.acos(a.dotProduct(b) / (a.length * b.length));
        }

        /**         * Returns a new Vector3D object that is an exact copy of the current Vector3D object.         */
        public function clone():Vector3D {
                    return new Vector3D(this.x, this.y, this.z, this.w);
        }

        /**         * Copies all of vector data from the source Vector3D object into the calling Vector3D object.         */
        public function copyFrom(src:Vector3D):void{
        
            this.x = src.x;
            this.y = src.y;
            this.z = src.z;
            this.w = src.w;

            //return new Vector3D(src.x, src.y, src.z, src.w);
        }

        /**         * Returns a new Vector3D object that is perpendicular (at a right angle) to the current Vector3D and another         * Vector3D object.         */
        public function crossProduct(a:Vector3D):Vector3D {
                    return new Vector3D(
                this.y * a.z - this.z * a.y,
                this.z * a.x - this.x * a.z,
                this.x * a.y - this.y * a.x,
                1
            );
        }

        /**         * Decrements the value of the x, y, and z elements of the current Vector3D object by the values of the x, y,         * and z elements of specified Vector3D object.         */
        public function decrementBy(a:Vector3D):void {
                    this.x -= a.x;
            this.y -= a.y;
            this.z -= a.z;
        }

        /**         * [static] Returns the distance between two Vector3D objects.         */
        public static function distance(pt1:Vector3D, pt2:Vector3D):Number {
                    var x: Number = (pt1.x - pt2.x);
            var y: Number = (pt1.y - pt2.y);
            var z: Number = (pt1.z - pt2.z);
            return Math.sqrt(x*x + y*y + z*z);
        }

        /**         * If the current Vector3D object and the one specified as the parameter are unit vertices, this method returns         * the cosine of the angle between the two vertices.         */
        public function dotProduct(a:Vector3D):Number {
                    return this.x * a.x + this.y * a.y + this.z * a.z;
        }

        /**         * Determines whether two Vector3D objects are equal by comparing the x, y, and z elements of the current         * Vector3D object with a specified Vector3D object.         */
        public function equals(cmp:Vector3D, allFour:Boolean = false):Boolean {
                    return (this.x == cmp.x && this.y == cmp.y && this.z == cmp.z && (!allFour || this.w == cmp.w ));
        }

        /**         * Increments the value of the x, y, and z elements of the current Vector3D object by the values of the x, y,         * and z elements of a specified Vector3D object.         */
        public function incrementBy(a:Vector3D):void {
                    this.x += a.x;
            this.y += a.y;
            this.z += a.z;
        }

        /**         * Compares the elements of the current Vector3D object with the elements of a specified Vector3D object to         * determine whether they are nearly equal.         */
        public function nearEquals(cmp:Vector3D, epsilon:Number, allFour:Boolean = true):Boolean {
                    return ((Math.abs(this.x - cmp.x) < epsilon)
                 && (Math.abs(this.y - cmp.y) < epsilon)
                 && (Math.abs(this.z - cmp.z) < epsilon)
                 && (!allFour || Math.abs(this.w - cmp.w) < epsilon));
        }

        /**         * Sets the current Vector3D object to its inverse.         */
        public function negate():void {
                    this.x = -this.x;
            this.y = -this.y;
            this.z = -this.z;
        }

        /**         * Converts a Vector3D object to a unit vector by dividing the first three elements (x, y, z) by the length of         * the vector.         */
        public function normalize():void {
                    var invLength = 1 / this.length;
            if (invLength != 0)
            {
                this.x *= invLength;
                this.y *= invLength;
                this.z *= invLength;
                return;
            }
            throw "Cannot divide by zero.";
        }

        /**         * Divides the value of the x, y, and z properties of the current Vector3D object by the value of its w         * property.         */
        public function project():void {
                    this.x /= this.w;
            this.y /= this.w;
            this.z /= this.w;
        }

        /**         * Scales the current Vector3D object by a scalar, a magnitude.         */
        public function scaleBy(s:Number):void {
                    this.x *= s;
            this.y *= s;
            this.z *= s;
        }

        /**         * Sets the members of Vector3D to the specified values         */
        public function setTo(xa:Number, ya:Number, za:Number):void {
                    this.x = xa;
            this.y = ya;
            this.z = za;
        }

        /**         * Subtracts the value of the x, y, and z elements of the current Vector3D object from the values of the x, y,         * and z elements of another Vector3D object.         */
        public function subtract(a:Vector3D):Vector3D {
                    return new Vector3D(this.x - a.x, this.y - a.y, this.z - a.z);
        }

        /**         * Returns a string representation of the current Vector3D object.         */
        public function toString():String {
                    return "[Vector3D] (x:" + this.x + " ,y:" + this.y + ", z" + this.z + ", w:" + this.w + ")";
        }

    }
}
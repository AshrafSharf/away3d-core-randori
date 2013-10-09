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
        /**
        public var x:Number = 0;

        /*
        public var y:Number = 0;

        /**
        public var z:Number = 0;

        /**
        public var w:Number = 0;

        /**
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

        /**
        public function get length():Number {
                    return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
        }

        /**
        public function get lengthSquared():Number {
                    return (this.x * this.x + this.y * this.y + this.z * this.z);
        }

        /**
        public function add(a:Vector3D):Vector3D {
                    return new Vector3D(this.x + a.x, this.y + a.y, this.z + a.z, this.w + a.w)
        }

        /**
        public static function angleBetween(a:Vector3D, b:Vector3D):Number {
                    return Math.acos(a.dotProduct(b) / (a.length * b.length));
        }

        /**
        public function clone():Vector3D {
                    return new Vector3D(this.x, this.y, this.z, this.w);
        }

        /**
        public function copyFrom(src:Vector3D):void{
        
            this.x = src.x;
            this.y = src.y;
            this.z = src.z;
            this.w = src.w;

            //return new Vector3D(src.x, src.y, src.z, src.w);
        }

        /**
        public function crossProduct(a:Vector3D):Vector3D {
                    return new Vector3D(
                this.y * a.z - this.z * a.y,
                this.z * a.x - this.x * a.z,
                this.x * a.y - this.y * a.x,
                1
            );
        }

        /**
        public function decrementBy(a:Vector3D):void {
                    this.x -= a.x;
            this.y -= a.y;
            this.z -= a.z;
        }

        /**
        public static function distance(pt1:Vector3D, pt2:Vector3D):Number {
                    var x: Number = (pt1.x - pt2.x);
            var y: Number = (pt1.y - pt2.y);
            var z: Number = (pt1.z - pt2.z);
            return Math.sqrt(x*x + y*y + z*z);
        }

        /**
        public function dotProduct(a:Vector3D):Number {
                    return this.x * a.x + this.y * a.y + this.z * a.z;
        }

        /**
        public function equals(cmp:Vector3D, allFour:Boolean = false):Boolean {
        			allFour = allFour || false;

            return (this.x == cmp.x && this.y == cmp.y && this.z == cmp.z && (!allFour || this.w == cmp.w ));
        }

        /**
        public function incrementBy(a:Vector3D):void {
                    this.x += a.x;
            this.y += a.y;
            this.z += a.z;
        }

        /**
        public function nearEquals(cmp:Vector3D, epsilon:Number, allFour:Boolean = true):Boolean {
        			allFour = allFour || true;

            return ((Math.abs(this.x - cmp.x) < epsilon)
                 && (Math.abs(this.y - cmp.y) < epsilon)
                 && (Math.abs(this.z - cmp.z) < epsilon)
                 && (!allFour || Math.abs(this.w - cmp.w) < epsilon));
        }

        /**
        public function negate():void {
                    this.x = -this.x;
            this.y = -this.y;
            this.z = -this.z;
        }

        /**
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

        /**
        public function project():void {
                    this.x /= this.w;
            this.y /= this.w;
            this.z /= this.w;
        }

        /**
        public function scaleBy(s:Number):void {
                    this.x *= s;
            this.y *= s;
            this.z *= s;
        }

        /**
        public function setTo(xa:Number, ya:Number, za:Number):void {
                    this.x = xa;
            this.y = ya;
            this.z = za;
        }

        /**
        public function subtract(a:Vector3D):Vector3D {
                    return new Vector3D(this.x - a.x, this.y - a.y, this.z - a.z);
        }

        /**
        public function toString():String {
                    return "[Vector3D] (x:" + this.x + " ,y:" + this.y + ", z" + this.z + ", w:" + this.w + ")";
        }

    }
}
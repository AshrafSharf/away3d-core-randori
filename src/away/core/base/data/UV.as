/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.base.data
{

    /**
    public class UV
    {
        private var _u:Number = 0;
        private var _v:Number = 0;

        /**
        public function UV(u:Number = 0, v:Number = 0):void
        {
			u = u || 0;
			v = v || 0;

            this._u = u;
            this._v = v;
        }

        /**
        public function get v():Number
        {
            return this._v;
        }

        public function set v(value:Number):void
        {
            this._v = value;
        }

        /**
        public function get u():Number
        {
            return this._u;
        }

        public function set u(value:Number):void
        {
            this._u = value;
        }

        /**
        public function clone():UV
        {
            return new UV(this._u, this._v);
        }

        /**
        public function toString():String
        {
            return this._u + "," + this._v;
        }

    }

}
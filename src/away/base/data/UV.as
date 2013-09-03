
///<reference path="../../_definitions.ts"/>

package away.base.data
{

    /**
    public class UV
    {
        private var _u:Number;
        private var _v:Number;

        /**
        public function UV(u:Number = 0, v:Number = 0):void
        {
            this._u = u;
            this._v = v;
        }

        /**
        public function get v():Number
        {
            return _v;
        }

        public function set v(value:Number):void
        {
            this._v = value;
        }

        /**
        public function get u():Number
        {
            return _u;
        }

        public function set u(value:Number):void
        {
            this._u = value;
        }

        /**
        public function clone():UV
        {
            return new UV(_u, _v);
        }

        /**
        public function toString():String
        {
            return _u + "," + _v;
        }

    }

}

package away.errors
{

    public class Error
    {

        private var _errorID:Number = 0;   //Contains the reference number associated with the specific error message.
        public function Error(message:String = '', id:Number = 0, _name:String = ''):void
        {

            this._messsage  = message;
            this._name      = name;
            this._errorID   = id;

        }

        /**
        public function get message():String
        {

            return _messsage;

        }

        /**
        public function set message(value:String):void
        {

            this._messsage = value;

        }

        /**
        public function get name():String
        {

            return _name;

        }

        /**
        public function set name(value:String):void
        {

            this._name = value;

        }

        /**
        public function get errorID():Number
        {

            return _errorID;

        }

    }

}
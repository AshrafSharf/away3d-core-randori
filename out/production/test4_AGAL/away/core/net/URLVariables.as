/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.net {
	import randori.webkit.html.FormData;


    public class URLVariables
    {

        private var _variables:Object = new Object();

        /**
        public function URLVariables(source:String = null):void
        {
			source = source || null;


            if ( source !== null )
            {

                this.decode( source );

            }


        }
        /**
        public function decode(source:String):void
        {

            source = source.split("+").join(" ");

            var tokens, re = /[?&]?([^=]+)=([^&]*)/g;

            while (tokens = re.exec(source)) {

                this._variables[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);

            }

        }
        /**
        public function toString():String
        {

            return '';
        }
        /**
        public function get variables():Object
        {

            return this._variables;

        }
        /**
        public function get formData():FormData
        {

            var fd : FormData = new FormData();

            for ( var s in this._variables )
            {

                fd.append( s , this._variables[s] );

            }

            return fd;


        }
        /**
        public function set variables(obj:Object):void
        {

            this._variables = obj;

        }


    }


}
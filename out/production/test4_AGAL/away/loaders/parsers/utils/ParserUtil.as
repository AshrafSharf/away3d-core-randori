/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.parsers.utils
{
	import away.utils.ByteArray;
	import randori.webkit.html.HTMLImageElement;
	import wrappers.Uint8Array;

	public class ParserUtil
	{

        /**
        public static function byteArrayToImage(data:ByteArray):HTMLImageElement
        {

            var byteStr : String    = '';
            var bytes   : Uint8Array  = new Uint8Array( data.arraybytes );
            var len     : Number      = bytes.byteLength;

            for (var i = 0; i < len; i++)
            {
                byteStr += String.fromCharCode( bytes[ i ] )
            }

            var base64Image     : String            = window.btoa ( byteStr );
            var str             : String            = 'data:image/png;base64,'+base64Image;
            var img             : HTMLImageElement  = (new HTMLImageElement( ) as HTMLImageElement);
                img.src                             = str;

            return img;

        }
        /**
		public static function toByteArray(data:*):ByteArray
		{
            var b : ByteArray = new ByteArray();
                b.setArrayBuffer( data );
            return b;
		}
		/**
		public static function toString(data:*, length:Number = 0):String
		{
			length = length || 0;


            if ( typeof data === 'string' );
            {

                var s : String = (data as String);

                if (s['substr'] != null )
                {
                    return s.substr(0 , s.length );
                }

            }

            if ( data instanceof ByteArray )
            {

                var ba : ByteArray = (data as ByteArray);
                    ba.position = 0;
                return ba.readUTFBytes( Math.min(ba.getBytesAvailable() , length));

            }

            return null;

            /*

		}
	}
}
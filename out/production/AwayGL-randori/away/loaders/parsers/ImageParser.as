/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.parsers
{
	import away.utils.ByteArray;
	import away.textures.Texture2DBase;
	import away.utils.TextureUtils;
	import away.textures.HTMLImageElementTexture;
	import away.library.assets.IAsset;
	import away.loaders.parsers.utils.ParserUtil;
	import away.textures.BitmapTexture;
	import away.materials.utils.DefaultMaterialManager;
	import away.events.AssetEvent;
	import randori.webkit.html.HTMLImageElement;

	/**
	public class ImageParser extends ParserBase
	{
		//private var _byteData         : ByteArray;
		private var _startedParsing:Boolean = false;
		private var _doneParsing:Boolean = false;
		//private var _loader           : Loader;

		/**
		public function ImageParser():void
		{

			super( ParserDataFormat.IMAGE , ParserLoaderType.IMG_LOADER );

		}

		/**

		public static function supportsType(extension:String):Boolean
		{

			extension = extension.toLowerCase();
			return extension == "jpg" || extension == "jpeg" || extension == "png" || extension == "gif" ;//|| extension == "bmp";//|| extension == "atf";

		}

		/**
		public static function supportsData(data:*):Boolean
		{

            if ( data  instanceof HTMLImageElement )
                return true;

            if (!(data instanceof ByteArray))
                return false;

            var ba:ByteArray = (data as ByteArray);
            ba.position = 0;

            if (ba.readUnsignedShort() == 0xffd8)
                return true; // JPEG, maybe check for "JFIF" as well?

            ba.position = 0;
            if (ba.readShort() == 0x424D)
                return true; // BMP

            ba.position = 1;
            if (ba.readUTFBytes(3) == 'PNG')
                return true;

            ba.position = 0;
            if (ba.readUTFBytes(3) == 'GIF' && ba.readShort() == 0x3839 && ba.readByte() == 0x61)
                return true;

            ba.position = 0;
            if (ba.readUTFBytes(3) == 'ATF')
                return true;

            return false;

		}

		/**
		override public function _pProceedParsing():Boolean
		{

            var asset       : Texture2DBase;
            var sizeError   : Boolean = false;

            if ( this.data instanceof HTMLImageElement )// Parse HTMLImageElement
            {

                if ( TextureUtils.isHTMLImageElementValid( HTMLImageElement(this.data) ) )
                {
                    asset = (new HTMLImageElementTexture( HTMLImageElement(this.data )  , false  ) as Texture2DBase);
                    this._pFinalizeAsset( (asset as IAsset) , this._iFileName  );
                }
                else
                {
                    sizeError = true;
                }

            }
            else if ( this.data instanceof ByteArray ) // Parse a ByteArray
            {

                var ba : ByteArray = this.data
                    ba.position = 0;
                var htmlImageElement : HTMLImageElement = ParserUtil.byteArrayToImage( this.data );

                if ( TextureUtils.isHTMLImageElementValid( htmlImageElement ) )
                {
                    asset = (new HTMLImageElementTexture( htmlImageElement  , false  ) as Texture2DBase);
                    this._pFinalizeAsset( (asset as IAsset) , this._iFileName  );
                }
                else
                {
                    sizeError = true;
                }

            }

            if ( sizeError == true ) // Generate new Checkerboard texture material
            {
                asset = (new BitmapTexture( DefaultMaterialManager.createCheckeredBitmapData( )  , false  ) as Texture2DBase);
                this._pFinalizeAsset( (asset as IAsset) , this._iFileName  );
                this.dispatchEvent( new AssetEvent( AssetEvent.TEXTURE_SIZE_ERROR , (asset as IAsset) )  );
            }

            return ParserBase.PARSING_DONE;

		}

	}
}
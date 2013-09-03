

///<reference path="../../_definitions.ts"/>

package away.loaders.parsers
{
	import away.textures.Texture2DBase;
	import away.textures.HTMLImageElementTexture;
	import away.utils.TextureUtils;
	import away.library.assets.IAsset;
	import away.events.AssetEvent;
	import randori.webkit.html.HTMLImageElement;

	/**
	public class ImageParser extends ParserBase
	{
		//private var _byteData         : ByteArray;
		private var _startedParsing:Boolean;
		private var _doneParsing:Boolean;
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
            {

                return true;
            }

            return false;

		}

		/**
		override public function _pProceedParsing():Boolean
		{

            var asset : Texture2DBase;

            if ( data  instanceof HTMLImageElement )
            {

                asset = Texture2DBase(new HTMLImageElementTexture( HTMLImageElement(data) , false ));

                if ( TextureUtils.isHTMLImageElementValid( HTMLImageElement(data) ) )
                {

                    _pFinalizeAsset( IAsset(asset), _iFileName );


                }
                else
                {

                    dispatchEvent( new AssetEvent( AssetEvent.TEXTURE_SIZE_ERROR , IAsset(asset)) );

                }

                return ParserBase.PARSING_DONE;

            }

            return ParserBase.PARSING_DONE;

		}

	}
}
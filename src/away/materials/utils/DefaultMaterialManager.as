///<reference path="../../_definitions.ts"/>

package away.materials.utils
{
	import away.display.BitmapData;
	import away.materials.TextureMaterial;
	import away.textures.BitmapTexture;
	import away.base.IMaterialOwner;

	public class DefaultMaterialManager
	{
		private static var _defaultTextureBitmapData:BitmapData;
		private static var _defaultMaterial:TextureMaterial;
		private static var _defaultTexture:BitmapTexture;

		public static function getDefaultMaterial(renderable:IMaterialOwner = null):TextureMaterial
		{
			if (!DefaultMaterialManager._defaultTexture)
            {
                DefaultMaterialManager.createDefaultTexture();
            }

			
			if (!DefaultMaterialManager._defaultMaterial)
            {
                DefaultMaterialManager.createDefaultMaterial();
            }

			return DefaultMaterialManager._defaultMaterial;

		}
		
		public static function getDefaultTexture(renderable:IMaterialOwner = null):BitmapTexture
		{
			if (!DefaultMaterialManager._defaultTexture)
            {
                DefaultMaterialManager.createDefaultTexture();

            }

			return DefaultMaterialManager._defaultTexture;

		}
		
		private static function createDefaultTexture():void
		{
            DefaultMaterialManager._defaultTextureBitmapData = new BitmapData(8, 8, false, 0x000000);
			
			//create chekerboard
			var i:Number, j:Number;
			for (i = 0; i < 8; i++)
            {
				for (j = 0; j < 8; j++)
                {
					if ((j & 1) ^ (i & 1))
                    {
                        DefaultMaterialManager._defaultTextureBitmapData.setPixel(i, j, 0XFFFFFF);
                    }
				}
			}

            DefaultMaterialManager._defaultTexture = new BitmapTexture( DefaultMaterialManager._defaultTextureBitmapData , false );
            DefaultMaterialManager._defaultTexture.name = "defaultTexture";
		}
		
		private static function createDefaultMaterial():void
		{
            DefaultMaterialManager._defaultMaterial         = new TextureMaterial( DefaultMaterialManager._defaultTexture );
            DefaultMaterialManager._defaultMaterial.mipmap  = false;
            DefaultMaterialManager._defaultMaterial.smooth  = false;
            DefaultMaterialManager._defaultMaterial.name    = "defaultMaterial";

		}
	}
}
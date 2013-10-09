/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials
{
	import away.textures.CubeTextureBase;
	import away.materials.passes.SkyBoxPass;

	/**
	public class SkyBoxMaterial extends MaterialBase
	{
		private var _cubeMap:CubeTextureBase;
		private var _skyboxPass:SkyBoxPass;
		
		/**
		public function SkyBoxMaterial(cubeMap:CubeTextureBase):void
		{

            super();

			this._cubeMap = cubeMap;
			this.pAddPass(this._skyboxPass = new SkyBoxPass());
			this._skyboxPass.cubeTexture = this._cubeMap;
		}
		
		/**
		public function get cubeMap():CubeTextureBase
		{
			return this._cubeMap;
		}
		
		public function set cubeMap(value:CubeTextureBase):void
		{
			if (value && this._cubeMap && (value.hasMipMaps != this._cubeMap.hasMipMaps || value.format != this._cubeMap.format))
				this.iInvalidatePasses(null);
			
			this._cubeMap = value;
			this._skyboxPass.cubeTexture = this._cubeMap;

		}
	}
}
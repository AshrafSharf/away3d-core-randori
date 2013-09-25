/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.parsers
{
	import away.entities.Mesh;
	import away.base.data.Vertex;
	import away.base.data.UV;
	import away.loaders.parsers.utils.ParserUtil;
	import away.loaders.misc.ResourceDependency;
	import away.library.assets.IAsset;
	import away.library.assets.AssetType;
	import away.textures.Texture2DBase;
	import away.utils.VectorInit;
	import away.base.Geometry;
	import away.materials.MaterialBase;
	import away.materials.TextureMaterial;
	import away.materials.utils.DefaultMaterialManager;
	import away.materials.TextureMultiPassMaterial;
	import away.base.ISubGeometry;
	import away.utils.GeometryUtils;
	import away.materials.methods.BasicSpecularMethod;
	import away.net.URLRequest;
	import away.materials.ColorMaterial;
	import away.materials.ColorMultiPassMaterial;
	import randori.webkit.page.Window;

	/**
	public class Group
	{
		public var name:String = null;
		public var materialID:String = null;
		public var materialGroups:Vector.<MaterialGroup> = new Vector.<MaterialGroup>();
	
	    public function Group():void
		{
		}
	}
	
}




/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.partition
{
	import away.entities.Mesh;
	import away.core.traverse.PartitionTraverser;
	import away.core.base.SubMesh;
	//import away3d.core.base.SubMesh;
	//import away3d.core.traverse.PartitionTraverser;
	//import away3d.entities.Mesh;
	
	/**
	public class MeshNode extends EntityNode
	{
		private var _mesh:Mesh;
		
		/**
		public function MeshNode(mesh:Mesh):void
		{
			super(mesh);
			this._mesh = mesh; // also keep a stronger typed reference
		}
		
		/**
		public function get mesh():Mesh
		{
			return this._mesh;
		}
		
		/**
		override public function acceptTraverser(traverser:PartitionTraverser):void
		{

			if ( traverser.enterNode(this) )
            {

				super.acceptTraverser(traverser);

				var subs:Vector.<SubMesh> = this._mesh.subMeshes;
				var i:Number = 0;
				var len:Number = subs.length;
				while (i < len)
                {

                    traverser.applyRenderable(subs[i++]);

                }

			}

		}
	
	}
}
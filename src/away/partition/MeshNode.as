///<reference path="../_definitions.ts"/>
package away.partition
{
	import away.entities.Mesh;
	import away.traverse.PartitionTraverser;
	import away.base.SubMesh;
	//import away3d.core.base.SubMesh;
	//import away3d.core.traverse.PartitionTraverser;
	//import away3d.entities.Mesh;
	
	/**	 * MeshNode is a space partitioning leaf node that contains a Mesh object.	 */
	public class MeshNode extends EntityNode
	{
		private var _mesh:Mesh;
		
		/**		 * Creates a new MeshNode object.		 * @param mesh The mesh to be contained in the node.		 */
		public function MeshNode(mesh:Mesh):void
		{
			super(mesh);
			_mesh = mesh; // also keep a stronger typed reference
		}
		
		/**		 * The mesh object contained in the partition node.		 */
		public function get mesh():Mesh
		{
			return _mesh;
		}
		
		/**		 * @inheritDoc		 */
		override public function acceptTraverser(traverser:PartitionTraverser):void
		{

			if ( traverser.enterNode(this) )
            {

				super.acceptTraverser(traverser);

				var subs:Vector.<SubMesh> = _mesh.subMeshes;
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

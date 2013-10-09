/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.partition
{
	import away.core.base.IRenderable;
	import away.entities.Entity;
	import away.core.traverse.PartitionTraverser;

	/**
	public class RenderableNode extends EntityNode
	{
		private var _renderable:IRenderable;
		
		/**
		public function RenderableNode(renderable:IRenderable):void
		{

            var e : * = renderable;

			super( (e as Entity) );

			this._renderable = renderable; // also keep a stronger typed reference
		}
		
		/**
		override public function acceptTraverser(traverser:PartitionTraverser):void
		{
			if (traverser.enterNode(this))
            {

				super.acceptTraverser(traverser);

				traverser.applyRenderable(this._renderable);

			}
		}
	
	}
}
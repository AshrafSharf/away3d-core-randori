///<reference path="../_definitions.ts"/>

package away.partition
{
	import away.entities.SkyBox;
	import away.traverse.PartitionTraverser;
	import away.math.Plane3D;

	/**
	public class SkyBoxNode extends EntityNode
	{
		private var _skyBox:SkyBox;
		
		/**
		public function SkyBoxNode(skyBox:SkyBox):void
		{
			super(skyBox);
			this._skyBox = skyBox;
		}
		
		/**
		override public function acceptTraverser(traverser:PartitionTraverser):void
		{


			if (traverser.enterNode(this)) {
				super.acceptTraverser(traverser);
				traverser.applySkyBox(_skyBox);
			}
		}
		
		override public function isInFrustum(planes:Vector.<Plane3D>, numPlanes:Number):Boolean
		{

			planes = planes;
			numPlanes = numPlanes;

			return true;
		}
	}
}
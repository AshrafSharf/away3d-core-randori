///<reference path="../_definitions.ts"/>

package away.traverse
{
	import away.geom.Vector3D;
	import away.partition.NodeBase;
	import away.base.IRenderable;
	import away.lights.LightBase;

	/**
	public class RaycastCollector extends EntityCollector
	{
		private var _rayPosition:Vector3D = new Vector3D();
		private var _rayDirection:Vector3D = new Vector3D();
		
		/**
		public function RaycastCollector():void
		{

            super();

		}
		
		/**
		public function get rayPosition():Vector3D
		{
			return _rayPosition;
		}
		
		public function set rayPosition(value:Vector3D):void
		{
            this._rayPosition = value;
		}
		
		/**
		public function get rayDirection():Vector3D
		{
			return _rayDirection;
		}
		
		public function set rayDirection(value:Vector3D):void
		{
            this._rayDirection = value;
		}
		
		/**
		override public function enterNode(node:NodeBase):Boolean
		{
			return node.isIntersectingRay(_rayPosition, _rayDirection);
		}
		
		/**
		override public function applySkyBox(renderable:IRenderable):void
		{
		}
		
		/**
		override public function applyRenderable(renderable:IRenderable):void
		{
		}
		
		/**
		override public function applyUnknownLight(light:LightBase):void
		{
		}
	}
}
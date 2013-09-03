///<reference path="../../_definitions.ts"/>
package away.animators.states
{
	import away.animators.nodes.AnimationNodeBase;
	import away.geom.Vector3D;
	import away.animators.IAnimator;

	/**
	public class AnimationStateBase 
	{
		private var _animationNode:AnimationNodeBase;
		private var _rootDelta:Vector3D = new Vector3D();
		private var _positionDeltaDirty:Boolean = true;
		
		private var _time:Number;
		private var _startTime:Number;
		private var _animator:IAnimator;
		
		/**
		public function get positionDelta():Vector3D
		{
			if (_positionDeltaDirty)
            {

                pUpdatePositionDelta();
            }

			return _rootDelta;

		}
		
		public function AnimationStateBase(animator:IAnimator, animationNode:AnimationNodeBase):void
		{
			this._animator = animator;
            this._animationNode = animationNode;
		}
		
		/**
		public function offset(startTime:Number):void
		{
            _startTime = startTime;

            _positionDeltaDirty = true;
		}
		
		/**
		public function update(time:Number):void
		{
			if (_time == time - _startTime)
            {

                return;

            }

            pUpdateTime(time);

		}
		
		/**
		public function phase(value:Number):void
		{

		}
		
		/**
		public function pUpdateTime(time:Number):void
		{
			_time = time - _startTime;
			
			_positionDeltaDirty = true;
		}
		
		/**
		public function pUpdatePositionDelta():void
		{
		}
	}
}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.animators.states
{
	import away.animators.nodes.AnimationNodeBase;
	import away.core.geom.Vector3D;
	import away.animators.IAnimator;

	/**
	public class AnimationStateBase 
	{
		private var _animationNode:AnimationNodeBase;
		private var _rootDelta:Vector3D = new Vector3D();
		private var _positionDeltaDirty:Boolean = true;
		
		private var _time:Number = 0;
		private var _startTime:Number = 0;
		private var _animator:IAnimator;
		
		/**
		public function get positionDelta():Vector3D
		{
			if (this._positionDeltaDirty)
            {

                this.pUpdatePositionDelta();
            }

			return this._rootDelta;

		}
		
		public function AnimationStateBase(animator:IAnimator, animationNode:AnimationNodeBase):void
		{
			this._animator = animator;
            this._animationNode = animationNode;
		}
		
		/**
		public function offset(startTime:Number):void
		{
            this._startTime = startTime;

            this._positionDeltaDirty = true;
		}
		
		/**
		public function update(time:Number):void
		{
			if (this._time == time - this._startTime)
            {

                return;

            }

            this.pUpdateTime(time);

		}
		
		/**
		public function phase(value:Number):void
		{

		}
		
		/**
		public function pUpdateTime(time:Number):void
		{
			this._time = time - this._startTime;
			
			this._positionDeltaDirty = true;
		}
		
		/**
		public function pUpdatePositionDelta():void
		{
		}
	}
}
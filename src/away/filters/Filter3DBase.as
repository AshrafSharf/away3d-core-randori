///<reference path="../_definitions.ts"/>

package away.filters
{
	import away.filters.tasks.Filter3DTaskBase;
	import away.managers.Stage3DProxy;
	import away.display3D.Texture;
	import away.cameras.Camera3D;

	public class Filter3DBase
	{
		private var _tasks:Vector.<Filter3DTaskBase>;//Vector.<Filter3DTaskBase>;		private var _requireDepthRender:Boolean;
		private var _textureWidth:Number;
		private var _textureHeight:Number;
		
		public function Filter3DBase():void
		{
			_tasks = new Vector.<Filter3DTaskBase>();
		}
		
		public function get requireDepthRender():Boolean
		{
			return _requireDepthRender;
		}
		
		public function pAddTask(filter:Filter3DTaskBase):void
		{
            _tasks.push(filter);

            if ( _requireDepthRender == null )
            {

                _requireDepthRender = filter.requireDepthRender;

            }

		}
		
		public function get tasks():Vector.<Filter3DTaskBase>
		{

			return _tasks;

		}
		
		public function getMainInputTexture(stage3DProxy:Stage3DProxy):Texture
		{

			return _tasks[0].getMainInputTexture(stage3DProxy);

		}
		
		public function get textureWidth():Number
		{
			return _textureWidth;
		}
		
		public function set textureWidth(value:Number):void
		{
            _textureWidth = value;
			
			for (var i:Number = 0; i < _tasks.length; ++i)
            {

                _tasks[i].textureWidth = value;

            }

		}
		
		public function get textureHeight():Number
		{

			return _textureHeight;

		}
		
		public function set textureHeight(value:Number):void
		{
			_textureHeight = value;

			for (var i:Number = 0; i < _tasks.length; ++i)
            {

                _tasks[i].textureHeight = value;

            }

		}
		
		// link up the filters correctly with the next filter
		public function setRenderTargets(mainTarget:Texture, stage3DProxy:Stage3DProxy):void
		{

			_tasks[_tasks.length - 1].target = mainTarget;

		}
		
		public function dispose():void
		{

			for (var i:Number = 0; i < _tasks.length; ++i)
            {

                _tasks[i].dispose();

            }

		}
		
		public function update(stage:Stage3DProxy, camera:Camera3D):void
		{
		
		}
	}
}

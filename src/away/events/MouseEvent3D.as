///<reference path="../_definitions.ts"/>
package away.events
{
	import away.containers.View3D;
	import away.containers.ObjectContainer3D;
	import away.base.IRenderable;
	import away.materials.MaterialBase;
	import away.geom.Point;
	import away.geom.Vector3D;
	//import away3d.arcane;
	//import away3d.containers.ObjectContainer3D;
	//import away3d.containers.View3D;
	//import away3d.core.base.IRenderable;
	//import away3d.materials.MaterialBase;
	
	//import flash.events.Event;
	//import flash.geom.Point;
	//import flash.geom.Vector3D;
	
	//use namespace arcane;
	
	/**
	public class MouseEvent3D extends Event
	{
		// Private.
		public var _iAllowedToPropagate:Boolean = true;
		public var _iParentEvent:MouseEvent3D;
		
		/**
		public static var MOUSE_OVER:String = "mouseOver3d";
		
		/**
		public static var MOUSE_OUT:String = "mouseOut3d";
		
		/**
		public static var MOUSE_UP:String = "mouseUp3d";
		
		/**
		public static var MOUSE_DOWN:String = "mouseDown3d";
		
		/**
		public static var MOUSE_MOVE:String = "mouseMove3d";
		
		/**
		//		public static ROLL_OVER : string = "rollOver3d";
		
		/**
		//		public static ROLL_OUT : string = "rollOut3d";
		
		/**
		public static var CLICK:String = "click3d";
		
		/**
		public static var DOUBLE_CLICK:String = "doubleClick3d";
		
		/**
		public static var MOUSE_WHEEL:String = "mouseWheel3d";
		
		/**
		public var screenX:Number;
		
		/**
		public var screenY:Number;
		
		/**
		public var view:View3D;
		
		/**
		public var object:ObjectContainer3D;
		
		/**
		public var renderable:IRenderable;
		
		/**
		public var material:MaterialBase;
		
		/**
		public var uv:Point;
		
		/**
		public var index:Number;
		
		/**
		public var subGeometryIndex:Number;
		
		/**
		public var localPosition:Vector3D;
		
		/**
		public var localNormal:Vector3D;
		
		/**
		public var ctrlKey:Boolean;
		
		/**
		public var altKey:Boolean;
		
		/**
		public var shiftKey:Boolean;
		
		/**
		public var delta:Number;
		
		/**
		public function MouseEvent3D(type:String):void
		{
			super(type );//, true, true);
		}
		
		/**
		public function get bubbles():Boolean
		{
			var doesBubble:Boolean = _iAllowedToPropagate ;
            _iAllowedToPropagate = true;
			// Don't bubble if propagation has been stopped.
			return doesBubble;
		}
		
		/**
		public function stopPropagation():void
		{
            _iAllowedToPropagate = false;

			if (_iParentEvent){

                _iParentEvent.stopPropagation();

            }

		}
		
		/**
		public function stopImmediatePropagation():void
		{
			_iAllowedToPropagate = false;

			if ( _iParentEvent )
            {

                _iParentEvent.stopImmediatePropagation();

            }

		}
		
		/**
		override public function clone():Event
		{
			var result:MouseEvent3D = new MouseEvent3D( type );

            /* TODO: Debug / test - look into isDefaultPrevented

			result.screenX = screenX;
			result.screenY = screenY;
			
			result.view = view;
			result.object = object;
			result.renderable = renderable;
			result.material = material;
			result.uv = uv;
			result.localPosition = localPosition;
			result.localNormal = localNormal;
			result.index = index;
			result.subGeometryIndex = subGeometryIndex;
			result.delta = delta;
			
			result.ctrlKey = ctrlKey;
			result.shiftKey = shiftKey;
			
			result._iParentEvent = this;
			result._iAllowedToPropagate = _iAllowedToPropagate;
			
			return result;
		}
		
		/**
		public function get scenePosition():Vector3D
		{
            if ( object instanceof ObjectContainer3D ) //if (this.object is ObjectContainer3D)
            {

                var objContainer : ObjectContainer3D = ObjectContainer3D(object);
                return objContainer.sceneTransform.transformVector( localPosition );

            }
			else
            {

                return localPosition;

            }

		}
		
		/**
		public function get sceneNormal():Vector3D
		{

            if ( object instanceof ObjectContainer3D ) //if (this.object is ObjectContainer3D)
            {
                var objContainer : ObjectContainer3D = ObjectContainer3D(object);
                var sceneNormal  : Vector3D = objContainer.sceneTransform.deltaTransformVector( localNormal );

                    sceneNormal.normalize();

                return sceneNormal;

            }
            else
            {

                return localNormal;
            }

            /*

		}
	}
}
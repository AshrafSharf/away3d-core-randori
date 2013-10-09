/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.events
{
	import away.containers.View3D;
	import away.containers.ObjectContainer3D;
	import away.core.base.IRenderable;
	import away.materials.MaterialBase;
	import away.core.geom.Point;
	import away.core.geom.Vector3D;
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
		public var screenX:Number = 0;
		
		/**
		public var screenY:Number = 0;
		
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
		public var index:Number = 0;
		
		/**
		public var subGeometryIndex:Number = 0;
		
		/**
		public var localPosition:Vector3D;
		
		/**
		public var localNormal:Vector3D;
		
		/**
		public var ctrlKey:Boolean = false;
		
		/**
		public var altKey:Boolean = false;
		
		/**
		public var shiftKey:Boolean = false;
		
		/**
		public var delta:Number = 0;
		
		/**
		public function MouseEvent3D(type:String):void
		{
			super(type );//, true, true);
		}
		
		/**
		public function get bubbles():Boolean
		{
			var doesBubble:Boolean = this._iAllowedToPropagate ;
            this._iAllowedToPropagate = true;
			// Don't bubble if propagation has been stopped.
			return doesBubble;
		}
		
		/**
		public function stopPropagation():void
		{
            this._iAllowedToPropagate = false;

			if (this._iParentEvent){

                this._iParentEvent.stopPropagation();

            }

		}
		
		/**
		public function stopImmediatePropagation():void
		{
			this._iAllowedToPropagate = false;

			if ( this._iParentEvent )
            {

                this._iParentEvent.stopImmediatePropagation();

            }

		}
		
		/**
		override public function clone():Event
		{
			var result:MouseEvent3D = new MouseEvent3D( this.type );

            /* TODO: Debug / test - look into isDefaultPrevented

			result.screenX = this.screenX;
			result.screenY = this.screenY;
			
			result.view = this.view;
			result.object = this.object;
			result.renderable = this.renderable;
			result.material = this.material;
			result.uv = this.uv;
			result.localPosition = this.localPosition;
			result.localNormal = this.localNormal;
			result.index = this.index;
			result.subGeometryIndex = this.subGeometryIndex;
			result.delta = this.delta;
			
			result.ctrlKey = this.ctrlKey;
			result.shiftKey = this.shiftKey;
			
			result._iParentEvent = this;
			result._iAllowedToPropagate = this._iAllowedToPropagate;
			
			return result;
		}
		
		/**
		public function get scenePosition():Vector3D
		{
            if ( this.object instanceof ObjectContainer3D ) //if (this.object is ObjectContainer3D)
            {

                var objContainer : ObjectContainer3D = (this.object as ObjectContainer3D);
                return objContainer.sceneTransform.transformVector( this.localPosition );

            }
			else
            {

                return this.localPosition;

            }

		}
		
		/**
		public function get sceneNormal():Vector3D
		{

            if ( this.object instanceof ObjectContainer3D ) //if (this.object is ObjectContainer3D)
            {
                var objContainer : ObjectContainer3D = (this.object as ObjectContainer3D);
                var sceneNormal  : Vector3D = objContainer.sceneTransform.deltaTransformVector( this.localNormal );

                    sceneNormal.normalize();

                return sceneNormal;

            }
            else
            {

                return this.localNormal;
            }

            /*

		}
	}
}
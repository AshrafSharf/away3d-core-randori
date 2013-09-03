
///<reference path="../_definitions.ts"/>

package away.managers
{
	import away.events.EventDispatcher;
	import away.display3D.Context3D;
	import away.display.Stage3D;
	import away.display3D.Program3D;
	import away.display3D.TextureBase;
	import away.geom.Rectangle;
	import away.events.Event;
	import away.events.Stage3DEvent;
	import away.utils.Debug;
	import away.display3D.Context3DClearMask;
	import randori.webkit.html.HTMLCanvasElement;
	//import away3d.arcane;
	//import away3d.debug.Debug;
	//import away3d.events.Stage3DEvent;
	
	//import flash.display.Shape;
	//import flash.display.Stage3D;
	//import flash.display3D.Context3D;
	//import flash.display3D.Context3DClearMask;
	//import flash.display3D.Context3DRenderMode;
	//import flash.display3D.Program3D;
	//import flash.display3D.textures.TextureBase;
	//import flash.events.Event;
	//import flash.events.EventDispatcher;
	//import flash.geom.Rectangle;
	
	//use namespace arcane;
	
	//[Event(name="enterFrame", type="flash.events.Event")]
	//[Event(name="exitFrame", type="flash.events.Event")]
	
	/**
	public class Stage3DProxy extends EventDispatcher
	{
		//private static _frameEventDriver:Shape = new Shape(); // TODO: add frame driver / request animation frame
		
		public var _iContext3D:Context3D;
		public var _iStage3DIndex:Number = -1;
		
		private var _usesSoftwareRendering:Boolean;
		private var _profile:String;
		private var _stage3D:Stage3D;
		private var _activeProgram3D:Program3D;
		private var _stage3DManager:Stage3DManager;
		private var _backBufferWidth:Number;
		private var _backBufferHeight:Number;
		private var _antiAlias:Number = 0;
		private var _enableDepthAndStencil:Boolean;
		private var _contextRequested:Boolean;
		//private var _activeVertexBuffers : Vector.<VertexBuffer3D> = new Vector.<VertexBuffer3D>(8, true);
		//private var _activeTextures : Vector.<TextureBase> = new Vector.<TextureBase>(8, true);
		private var _renderTarget:TextureBase = null;
		private var _renderSurfaceSelector:Number = 0;
        private var _scissorRect:Rectangle;
		private var _color:Number;
		private var _backBufferDirty:Boolean;
		private var _viewPort:Rectangle;
		private var _enterFrame:Event;
		private var _exitFrame:Event;
		private var _viewportUpdated:Stage3DEvent;
		private var _viewportDirty:Boolean;
		private var _bufferClear:Boolean;
		private var _mouse3DManager:Mouse3DManager;
		//private _touch3DManager:Touch3DManager; //TODO: imeplement dependency Touch3DManager
		
		private function notifyViewportUpdated():void
		{
			if (_viewportDirty)
            {

                return;

            }

			_viewportDirty = true;

			//if (!this.hasEventListener(away.events.Stage3DEvent.VIEWPORT_UPDATED))
				//return;
			
			//if (!_viewportUpdated)
			_viewportUpdated = new Stage3DEvent(Stage3DEvent.VIEWPORT_UPDATED);
			dispatchEvent(_viewportUpdated);
		}
		
		private function notifyEnterFrame():void
		{
			//if (!hasEventListener(Event.ENTER_FRAME))
				//return;
			
			if (!_enterFrame)
            {

                _enterFrame = new Event(Event.ENTER_FRAME);

            }

			
			dispatchEvent(_enterFrame);

		}
		
		private function notifyExitFrame():void
		{
			//if (!hasEventListener(Event.EXIT_FRAME))
				//return;
			
			if (!_exitFrame)
				_exitFrame = new Event(Event.EXIT_FRAME);
			
			dispatchEvent(_exitFrame);
		}
		
		/**
		public function Stage3DProxy(stage3DIndex:Number, stage3D:Stage3D, stage3DManager:Stage3DManager, forceSoftware:Boolean = false, profile:String = "baseline"):void
		{

            super();

			this._iStage3DIndex = stage3DIndex;
            this._stage3D = stage3D;

            this._stage3D.x = 0;
            this._stage3D.y = 0;
            this._stage3D.visible = true;
            this._stage3DManager = stage3DManager;
            this._viewPort = new Rectangle();
            this._enableDepthAndStencil = true;
			
			// whatever happens, be sure this has highest priority
			this._stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContext3DUpdate, this ) ;//, false, 1000, false);
			this.requestContext( forceSoftware , this.profile);


		}
		
		public function get profile():String
		{
			return _profile;
		}
		
		/**
		public function dispose():void
		{
			_stage3DManager.iRemoveStage3DProxy(this);
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContext3DUpdate , this );
			freeContext3D();
            _stage3D = null;
            _stage3DManager = null;
            _iStage3DIndex = -1;
		}
		
		/**
		public function configureBackBuffer(backBufferWidth:Number, backBufferHeight:Number, antiAlias:Number, enableDepthAndStencil:Boolean):void
		{
			var oldWidth:Number = _backBufferWidth;
			var oldHeight:Number = _backBufferHeight;

            _backBufferWidth = _viewPort.width = backBufferWidth;
            _backBufferHeight = _viewPort.height = backBufferHeight;
			
			if (oldWidth != _backBufferWidth || oldHeight != _backBufferHeight)
                notifyViewportUpdated();

            _antiAlias = antiAlias;
            _enableDepthAndStencil = enableDepthAndStencil;
			
			if (_iContext3D)
                _iContext3D.configureBackBuffer(backBufferWidth, backBufferHeight, antiAlias, enableDepthAndStencil);

            _stage3D.width = backBufferWidth;
            _stage3D.height = backBufferHeight;

		}
		
		/*
		public function get enableDepthAndStencil():Boolean
		{
			return _enableDepthAndStencil;
		}
		
		public function set enableDepthAndStencil(enableDepthAndStencil:Boolean):void
		{
            this._enableDepthAndStencil = enableDepthAndStencil;
            this._backBufferDirty = true;
		}
		
		public function get renderTarget():TextureBase
		{
			return _renderTarget;
		}
		
		public function get renderSurfaceSelector():Number
		{
			return _renderSurfaceSelector;
		}
		
		public function setRenderTarget(target:TextureBase, enableDepthAndStencil:Boolean = false, surfaceSelector:Number = 0):void
		{
			if (_renderTarget === target && surfaceSelector == _renderSurfaceSelector && _enableDepthAndStencil == enableDepthAndStencil)
            {
                return;
            }

			_renderTarget = target;
            _renderSurfaceSelector = surfaceSelector;
            _enableDepthAndStencil = enableDepthAndStencil;

            Debug.throwPIR( 'Stage3DProxy' , 'setRenderTarget' , 'away.display3D.Context3D: setRenderToTexture , setRenderToBackBuffer');

            // todo : implement

            /*
		}
		
		/*
		public function clear():void
		{
			if (!_iContext3D)
				return;
			
			if (_backBufferDirty) {
				configureBackBuffer(_backBufferWidth, _backBufferHeight, _antiAlias, _enableDepthAndStencil);
                _backBufferDirty = false;
			}

            _iContext3D.clear( ( _color & 0xff000000 ) >>> 24 , // <--------- Zero-fill right shift
                                    ( _color & 0xff0000 ) >>> 16, // <-------------|
                                    ( _color & 0xff00 ) >>> 8, // <----------------|
                                      _color & 0xff ) ;

			_bufferClear = true;
		}
		
		/*
		public function present():void
		{
			if (!_iContext3D)
				return;
			
			_iContext3D.present();
			
			_activeProgram3D = null;
			
			if (_mouse3DManager)
                _mouse3DManager.fireMouseEvents();
		}
		
		/**
		//public override function addEventListener(type:string, listener, useCapture:boolean = false, priority:number = 0, useWeakReference:boolean = false)
        override public function addEventListener(type:String, listener:Function, target:Object):void
		{
			super.addEventListener(type, listener, target ) ;//useCapture, priority, useWeakReference);

            //away.Debug.throwPIR( 'Stage3DProxy' , 'addEventListener' ,  'EnterFrame, ExitFrame');

            //if ((type == away.events.Event.ENTER_FRAME || type == away.events.Event.EXIT_FRAME) ){//&& ! this._frameEventDriver.hasEventListener(Event.ENTER_FRAME)){

                //_frameEventDriver.addEventListener(Event.ENTER_FRAME, onEnterFrame, useCapture, priority, useWeakReference);

            //}

            /* Original code
		}
		
		/**
        override public function removeEventListener(type:String, listener:Function, target:Object):void
//public override function removeEventListener(type:string, listener, useCapture:boolean = false)
			super.removeEventListener(type, listener, target);

            //away.Debug.throwPIR( 'Stage3DProxy' , 'removeEventListener' ,  'EnterFrame, ExitFrame');

            /*
		}
		
		public function get scissorRect():Rectangle
		{
			return _scissorRect;
		}
		public function set scissorRect(value:Rectangle):void
		{
			this._scissorRect = value;
			this._iContext3D.setScissorRectangle(this._scissorRect);
		}
		
		/**
		public function get stage3DIndex():Number
		{
			return _iStage3DIndex;
		}
		
		/**
		public function get stage3D():Stage3D
		{
			return _stage3D;
		}
		
		/**
		public function get context3D():Context3D
		{
			return _iContext3D;
		}
		
		/**
		public function get usesSoftwareRendering():Boolean
		{
			return _usesSoftwareRendering;
		}
		
		/**
		public function get x():Number
		{
			return _stage3D.x;
		}
		public function set x(value:Number):void
		{
			if (this._viewPort.x == value)
				return;
			
			this._stage3D.x = this._viewPort.x = value;
			
			this.notifyViewportUpdated();
		}
		
		/**
		public function get y():Number
		{
			return _stage3D.y;
		}
		public function set y(value:Number):void
		{
			if (this._viewPort.y == value)
				return;
			
			this._stage3D.y = this._viewPort.y = value;

            this.notifyViewportUpdated();
		}

        /**
        public function get canvas():HTMLCanvasElement
        {
            return _stage3D.canvas;
        }
		
		/**
		public function get width():Number
		{
			return _backBufferWidth;
		}
		public function set width(width:Number):void
		{
			if (this._viewPort.width == width)
				return;

            this._stage3D.width = this._backBufferWidth = this._viewPort.width = width;
			this._backBufferDirty = true;
			
			this.notifyViewportUpdated();
		}
		
		/**
		public function get height():Number
		{
			return _backBufferHeight;
		}
		public function set height(height:Number):void
		{
			if (this._viewPort.height == height)
				return;

            this._stage3D.height = this._backBufferHeight = this._viewPort.height = height;
			this._backBufferDirty = true;
			
			this.notifyViewportUpdated();
		}
		
		/**
		public function get antiAlias():Number
		{
			return _antiAlias;
		}
		public function set antiAlias(antiAlias:Number):void
		{
			this._antiAlias = antiAlias;
			this._backBufferDirty = true;
		}
		
		/**
		public function get viewPort():Rectangle
		{
			_viewportDirty = false;
			
			return _viewPort;
		}
		
		/**
		public function get color():Number
		{
			return _color;
		}
		
		public function set color(color:Number):void
		{
			this._color = color;
		}
		
		/**
		public function get visible():Boolean
		{
            return _stage3D.visible;
		}
		public function set visible(value:Boolean):void
		{
			this._stage3D.visible = value;
		}
		
		/**
		public function get bufferClear():Boolean
		{
			return _bufferClear;
		}
		public function set bufferClear(newBufferClear:Boolean):void
		{
			this._bufferClear = newBufferClear;
		}
		
		/*
		public function get mouse3DManager():Mouse3DManager
		{
			return _mouse3DManager;
		}
		
		public function set mouse3DManager(value:Mouse3DManager):void
		{
			this._mouse3DManager = value;
		}

        /* TODO: implement dependency Touch3DManager

		/**
		private function freeContext3D():void
		{
			if (_iContext3D) {

				_iContext3D.dispose();
				dispatchEvent(new Stage3DEvent(Stage3DEvent.CONTEXT3D_DISPOSED));
			}

            _iContext3D = null;
		}
		
		/*
		private function onContext3DUpdate(event:Event):void
		{
			if (_stage3D.context3D)
            {

				var hadContext:Boolean = (_iContext3D != null);
				_iContext3D = _stage3D.context3D;

				// Only configure back buffer if width and height have been set,
				// which they may not have been if View3D.render() has yet to be
				// invoked for the first time.
				if (_backBufferWidth && _backBufferHeight)
                {
                    _iContext3D.configureBackBuffer(_backBufferWidth, _backBufferHeight, _antiAlias, _enableDepthAndStencil);
                }

				// Dispatch the appropriate event depending on whether context was
				// created for the first time or recreated after a device loss.
				dispatchEvent(new Stage3DEvent( hadContext ? Stage3DEvent.CONTEXT3D_RECREATED : Stage3DEvent.CONTEXT3D_CREATED));
				
			}
            else
            {
                throw new Error("Rendering context lost!");
            }

		}
		
		/**
		private function requestContext(forceSoftware:Boolean = false, profile:String = "baseline"):void
		{
			// If forcing software, we can be certain that the
			// returned Context3D will be running software mode.
			// If not, we can't be sure and should stick to the
			// old value (will likely be same if re-requesting.)

            if ( _usesSoftwareRendering != null )
            {

                _usesSoftwareRendering = forceSoftware;

            }

			_profile = profile;

            // Updated to work with current JS <> AS3 Display3D System
            _stage3D.requestContext( true );

		}
		
		/**
		private function onEnterFrame(event:Event):void
		{
			if (!_iContext3D )
            {
                return;
            }

			// Clear the stage3D instance
			clear();
			//notify the enterframe listeners
			notifyEnterFrame();
			// Call the present() to render the frame
            present();
			//notify the exitframe listeners
            notifyExitFrame();
		}
		
		public function recoverFromDisposal():Boolean
		{
			if (!_iContext3D)
            {

                return false;

            }

            //away.Debug.throwPIR( 'Stage3DProxy' , 'recoverFromDisposal' , '' );

            /*
			return true;

		}
		
		public function clearDepthBuffer():void
		{
			if ( ! _iContext3D )
            {

                return;

            }

            _iContext3D.clear(0, 0, 0, 1, 1, 0, Context3DClearMask.DEPTH);

		}
	}
}
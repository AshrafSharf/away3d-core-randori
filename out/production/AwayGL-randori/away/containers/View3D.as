/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.containers
{
	import away.core.display.Stage;
	import away.cameras.Camera3D;
	import away.core.traverse.EntityCollector;
	import away.core.render.Filter3DRenderer;
	import away.core.display3D.Texture;
	import away.managers.Stage3DProxy;
	import away.managers.RTTBufferManager;
	import away.core.geom.Rectangle;
	import away.core.render.RendererBase;
	import away.core.geom.Point;
	import away.core.render.DepthRenderer;
	import away.events.Scene3DEvent;
	import away.core.render.DefaultRenderer;
	import away.events.CameraEvent;
	import away.events.Stage3DEvent;
	import away.filters.Filter3DBase;
	import away.core.display3D.Context3D;
	import away.core.display3D.Context3DTextureFormat;
	import away.managers.Stage3DManager;
	import away.core.geom.Vector3D;
	import randori.webkit.html.HTMLCanvasElement;
	public class View3D
	{

        /*

        // Static
        private static var sStage:Stage;// View3D's share the same stage

        // Public
        public var stage:Stage;

        // Protected
		public var _pScene:Scene3D;
		public var _pCamera:Camera3D;
		public var _pEntityCollector:EntityCollector;
        public var _pFilter3DRenderer:Filter3DRenderer;
        public var _pRequireDepthRender:Boolean = false;
        public var _pDepthRender:Texture;
        public var _pStage3DProxy:Stage3DProxy;
        public var _pBackBufferInvalid:Boolean = true;
        public var _pRttBufferManager:RTTBufferManager;

        public var _pShareContext:Boolean = false;
        public var _pScissorRect:Rectangle;
        public var _pRenderer:RendererBase;

        // Private
        private var _aspectRatio:Number = 0;
        private var _width:Number = 0;
        private var _height:Number = 0;

        private var _localPos:Point = new Point();
        private var _globalPos:Point = new Point();
        private var _globalPosDirty:Boolean = false;
		private var _time:Number = 0;
		private var _deltaTime:Number = 0;
		private var _backgroundColor:Number = 0x000000;
		private var _backgroundAlpha:Number = 1;
        private var _depthRenderer:DepthRenderer;
        private var _addedToStage:Boolean = false;
        private var _forceSoftware:Boolean = false;
        private var _depthTextureInvalid:Boolean = true;

        private var _antiAlias:Number = 0;
        private var _scissorRectDirty:Boolean = true;
        private var _viewportDirty:Boolean = true;
        private var _depthPrepass:Boolean = false;
        private var _profile:String = null;
        private var _layeredView:Boolean = false;

        /*
		public function View3D(scene:Scene3D = null, camera:Camera3D = null, renderer:RendererBase = null, forceSoftware:Boolean = false, profile:String = "baseline"):void
		{
			scene = scene || null;
			camera = camera || null;
			renderer = renderer || null;
			profile = profile || "baseline";



            if ( View3D.sStage == null )
            {
                View3D.sStage = new Stage();
            }

			this._profile = profile;
			this._pScene = scene || new Scene3D();
			this._pScene.addEventListener( Scene3DEvent.PARTITION_CHANGED, onScenePartitionChanged, this );
			this._pCamera = camera || new Camera3D();
			this._pRenderer = renderer || new DefaultRenderer();
			this._depthRenderer = new DepthRenderer();
			this._forceSoftware = forceSoftware;
			this._pEntityCollector = this._pRenderer.iCreateEntityCollector();
			this._pEntityCollector.camera = this._pCamera;
			this._pScissorRect = new Rectangle();
			this._pCamera.addEventListener( CameraEvent.LENS_CHANGED, onLensChanged, this );
			this._pCamera.partition = this._pScene.partition;
            this.stage = View3D.sStage;

            this.onAddedToStage();

		}

        /**
		private function onScenePartitionChanged(e:Scene3DEvent):void
		{
			if( this._pCamera )
			{
				this._pCamera.partition = this.scene.partition;
			}
		}
        /**
		public function get stage3DProxy():Stage3DProxy
		{
			return this._pStage3DProxy;
		}
        /**
		public function set stage3DProxy(stage3DProxy:Stage3DProxy):void
		{

			if (this._pStage3DProxy)
			{
				this._pStage3DProxy.removeEventListener(Stage3DEvent.VIEWPORT_UPDATED, onViewportUpdated, this );
			}
			
			this._pStage3DProxy = stage3DProxy;
			this._pStage3DProxy.addEventListener( Stage3DEvent.VIEWPORT_UPDATED, onViewportUpdated, this );
			this._depthRenderer.iStage3DProxy =  this._pStage3DProxy;
			this._pRenderer.iStage3DProxy = this._depthRenderer.iStage3DProxy
			this._globalPosDirty = true;
			this._pBackBufferInvalid = true;

		}
        /**
		public function get layeredView():Boolean
		{
			return this._layeredView;
		}
        /**
		public function set layeredView(value:Boolean):void
		{
			this._layeredView = value;
		}
        /**
		public function get filters3d():Vector.<Filter3DBase>
		{
			return this._pFilter3DRenderer ? this._pFilter3DRenderer.filters : null;
		}
        /**
        public function set filters3d(value:Vector.<Filter3DBase>):void
        {
            if (value && value.length == 0)
                value = null;

            if (this._pFilter3DRenderer && !value)
            {
                this._pFilter3DRenderer.dispose();
                this._pFilter3DRenderer = null;
            }
            else if (!this._pFilter3DRenderer && value)
            {
                this._pFilter3DRenderer = new Filter3DRenderer( this._pStage3DProxy );
                this._pFilter3DRenderer.filters = value;
            }

            if (this._pFilter3DRenderer)
            {
                this._pFilter3DRenderer.filters = value;
                this._pRequireDepthRender = this._pFilter3DRenderer.requireDepthRender;
            }
            else
            {
                this._pRequireDepthRender = false;

                if (this._pDepthRender)
                {
                    this._pDepthRender.dispose();
                    this._pDepthRender = null;
                }
            }
        }
        /**
		public function get renderer():RendererBase
		{
			return this._pRenderer;
		}
        /**
        public function set renderer(value:RendererBase):void
        {
            this._pRenderer.iDispose();
            this._pRenderer = value;

            this._pEntityCollector = this._pRenderer.iCreateEntityCollector();
            this._pEntityCollector.camera = this._pCamera;
            this._pRenderer.iStage3DProxy = this._pStage3DProxy;
            this._pRenderer.antiAlias = this._antiAlias;
            this._pRenderer.iBackgroundR = ((this._backgroundColor >> 16) & 0xff)/0xff;
            this._pRenderer.iBackgroundG = ((this._backgroundColor >> 8) & 0xff)/0xff;
            this._pRenderer.iBackgroundB = (this._backgroundColor & 0xff)/0xff;
            this._pRenderer.iBackgroundAlpha = this._backgroundAlpha;
            this._pRenderer.iViewWidth = this._width;
            this._pRenderer.iViewHeight = this._height;

            this._pBackBufferInvalid = true;

        }
        /**
		public function get backgroundColor():Number
		{
			return this._backgroundColor;
		}
        /**
        public function set backgroundColor(value:Number):void
        {
            this._backgroundColor      = value;
            this._pRenderer.iBackgroundR = ((value >> 16) & 0xff)/0xff;
            this._pRenderer.iBackgroundG = ((value >> 8) & 0xff)/0xff;
            this._pRenderer.iBackgroundB = (value & 0xff)/0xff;
        }
        /**
		public function get backgroundAlpha():Number
		{
			return this._backgroundAlpha;
		}
        /**
		public function set backgroundAlpha(value:Number):void
		{
			if (value > 1)
			{
				value = 1;
			}
			else if (value < 0)
			{
				value = 0;
			}
			
			this._pRenderer.iBackgroundAlpha = value;
			this._backgroundAlpha = value;
		}
        /**
		public function get camera():Camera3D
		{
			return this._pCamera;
		}
        /**
        public function set camera(camera:Camera3D):void
        {
            this._pCamera.removeEventListener(CameraEvent.LENS_CHANGED, onLensChanged , this );
            this._pCamera = camera;

            this._pEntityCollector.camera = this._pCamera;

            if (this._pScene)
            {
                this._pCamera.partition = this._pScene.partition;
            }

            this._pCamera.addEventListener(CameraEvent.LENS_CHANGED, onLensChanged , this);
            this._scissorRectDirty = true;
            this._viewportDirty = true;

        }
        /**
		public function get scene():Scene3D
		{
			return this._pScene;
		}
        /**
        public function set scene(scene:Scene3D):void
        {
            this._pScene.removeEventListener(Scene3DEvent.PARTITION_CHANGED, onScenePartitionChanged , this );
            this._pScene = scene;
            this._pScene.addEventListener(Scene3DEvent.PARTITION_CHANGED, onScenePartitionChanged , this );

            if (this._pCamera)
            {
                this._pCamera.partition = this._pScene.partition;
            }

        }
        /**
		public function get deltaTime():Number
		{
			return this._deltaTime;
		}
        /**
		public function get width():Number
		{
			return this._width;
		}
        /**
        public function set width(value:Number):void
        {

            if (this._width == value)
            {
                return;
            }

            if (this._pRttBufferManager)
            {
                this._pRttBufferManager.viewWidth = value;
            }

            this._width = value;
            this._aspectRatio = this._width/this._height;
            this._pCamera.lens.iAspectRatio= this._aspectRatio;
            this._depthTextureInvalid = true;
            this._pRenderer.iViewWidth= value;
            this._pScissorRect.width = value;
            this._pBackBufferInvalid = true;
            this._scissorRectDirty = true;
        }
        /**
		public function get height():Number
		{
			return this._height;
		}
        /**
        public function set height(value:Number):void
        {

            if (this._height == value)
            {
                return;
            }

            if (this._pRttBufferManager)
            {
                this._pRttBufferManager.viewHeight = value;
            }

            this._height = value;
            this._aspectRatio = this._width/this._height;
            this._pCamera.lens.iAspectRatio = this._aspectRatio;
            this._depthTextureInvalid = true;
            this._pRenderer.iViewHeight = value;
            this._pScissorRect.height = value;
            this._pBackBufferInvalid = true;
            this._scissorRectDirty = true;

        }
        /**
        public function set x(value:Number):void
        {
            if (this.x == value)
                return;

            this._localPos.x =  value;
            this._globalPos.x = this._localPos.x
            this._globalPosDirty = true;
        }
        /**
        public function set y(value:Number):void
        {
            if (this.y == value)
                return;

            this._localPos.y =  value;
            this._globalPos.y = this._localPos.y
            this._globalPosDirty = true;
        }
        /**
        public function get x():Number
        {
            return this._localPos.x;
        }
        /**
        public function get y():Number
        {
            return this._localPos.y;
        }
        /**
        public function get visible():Boolean
        {
            return true;
        }
        /**
        public function set visible(v:Boolean):void
        {

        }
        public function get canvas():HTMLCanvasElement
        {

            return this._pStage3DProxy.canvas;

        }
        /**
		public function get antiAlias():Number
		{
			return this._antiAlias;
		}
        /**
		public function set antiAlias(value:Number):void
		{
			this._antiAlias = value;
			this._pRenderer.antiAlias = value;
			this._pBackBufferInvalid = true;
		}
        /**
		public function get renderedFacesCount():Number
		{
			return this._pEntityCollector._pNumTriangles;//numTriangles;
		}
        /**
		public function get shareContext():Boolean
		{
			return this._pShareContext;
		}
        /**
		public function set shareContext(value:Boolean):void
		{
			if ( this._pShareContext == value)
			{
				return;
			}
			this._pShareContext = value;
			this._globalPosDirty = true;
		}
        /**
        public function pUpdateBackBuffer():void
        {
            // No reason trying to configure back buffer if there is no context available.
            // Doing this anyway (and relying on _stage3DProxy to cache width/height for
            // context does get available) means usesSoftwareRendering won't be reliable.

            if (this._pStage3DProxy._iContext3D && ! this._pShareContext)
            {

                if ( this._width && this._height)
                {

                    this._pStage3DProxy.configureBackBuffer( this._width, this._height, this._antiAlias, true);
                    this._pBackBufferInvalid = false;
                }

            }
        }
		/**
        public function render():void
        {

            if (!this._pStage3DProxy.recoverFromDisposal()) //if context3D has Disposed by the OS,don't render at this frame
            {
                this._pBackBufferInvalid = true;
                return;
            }

            if (this._pBackBufferInvalid)// reset or update render settings
            {
                this.pUpdateBackBuffer();
            }

            if (this._pShareContext && this._layeredView)
            {
                this._pStage3DProxy.clearDepthBuffer();
            }

            if (this._globalPosDirty)
            {
                this.pUpdateGlobalPos();
            }

            this.pUpdateTime();
            this.pUpdateViewSizeData();
            this._pEntityCollector.clear();
            this._pScene.traversePartitions( this._pEntityCollector );// collect stuff to render

            // TODO: implement & integrate mouse3DManager
            // update picking
            //_mouse3DManager.updateCollider(this);
            //_touch3DManager.updateCollider();

            if (this._pRequireDepthRender)
            {
                this.pRenderSceneDepthToTexture(this._pEntityCollector);
            }

            if (this._depthPrepass)
            {
                this.pRenderDepthPrepass(this._pEntityCollector);
            }

            this._pRenderer.iClearOnRender = !this._depthPrepass;

            if (this._pFilter3DRenderer && this._pStage3DProxy._iContext3D)
            {

                this._pRenderer.iRender( this._pEntityCollector, this._pFilter3DRenderer.getMainInputTexture( this._pStage3DProxy), this._pRttBufferManager.renderToTextureRect);
                this._pFilter3DRenderer.render( this._pStage3DProxy, this._pCamera , this._pDepthRender);

            }
            else
            {
                this._pRenderer.iShareContext = this._pShareContext;

                if (this._pShareContext)
                {
                    this._pRenderer.iRender( this._pEntityCollector, null, this._pScissorRect);
                }
                else
                {
                    this._pRenderer.iRender( this._pEntityCollector );
                }

            }

            if (! this._pShareContext)
            {
                this._pStage3DProxy.present();

                // TODO: imeplement mouse3dManager
                // fire collected mouse events
                //_mouse3DManager.fireMouseEvents();
                //_touch3DManager.fireTouchEvents();

            }

            // clean up data for this render
            this._pEntityCollector.cleanUp();

            // register that a view has been rendered
            this._pStage3DProxy.bufferClear = false;

        }
        /**
        public function pUpdateGlobalPos():void
        {

            this._globalPosDirty = false;

            if (!this._pStage3DProxy)
            {
                return;
            }

            if (this._pShareContext)
            {

                this._pScissorRect.x = this._globalPos.x - this._pStage3DProxy.x;
                this._pScissorRect.y = this._globalPos.y - this._pStage3DProxy.y;

            }
            else
            {

                this._pScissorRect.x = 0;
                this._pScissorRect.y = 0;
                this._pStage3DProxy.x = this._globalPos.x;
                this._pStage3DProxy.y = this._globalPos.y;

            }

            this._scissorRectDirty = true;
        }
        /**
		public function pUpdateTime():void
		{
			var time:Number = new Date().getTime();

			if ( this._time == 0 )
			{
				this._time = time;
			}

			this._deltaTime = time - this._time;
			this._time = time;

		}
        /**
        public function pUpdateViewSizeData():void
        {
            this._pCamera.lens.iAspectRatio = this._aspectRatio;

            if (this._scissorRectDirty)
            {
                this._scissorRectDirty = false;
                this._pCamera.lens.iUpdateScissorRect(this._pScissorRect.x, this._pScissorRect.y, this._pScissorRect.width, this._pScissorRect.height);
            }

            if (this._viewportDirty)
            {
                this._viewportDirty = false;
                this._pCamera.lens.iUpdateViewport(this._pStage3DProxy.viewPort.x, this._pStage3DProxy.viewPort.y, this._pStage3DProxy.viewPort.width, this._pStage3DProxy.viewPort.height);
            }

            if (this._pFilter3DRenderer || this._pRenderer.iRenderToTexture )
            {
                this._pRenderer.iTextureRatioX = this._pRttBufferManager.textureRatioX;
                this._pRenderer.iTextureRatioY = this._pRttBufferManager.textureRatioY;
            }
            else
            {
                this._pRenderer.iTextureRatioX = 1;
                this._pRenderer.iTextureRatioY = 1;
            }
        }
        /**
        public function pRenderDepthPrepass(entityCollector:EntityCollector):void
        {
            this._depthRenderer.disableColor = true;

            if ( this._pFilter3DRenderer || this._pRenderer.iRenderToTexture )
            {
                this._depthRenderer.iTextureRatioX = this._pRttBufferManager.textureRatioX;
                this._depthRenderer.iTextureRatioY = this._pRttBufferManager.textureRatioY;
                this._depthRenderer.iRender( entityCollector, this._pFilter3DRenderer.getMainInputTexture(this._pStage3DProxy), this._pRttBufferManager.renderToTextureRect);
            }
            else
            {
                this._depthRenderer.iTextureRatioX = 1;
                this._depthRenderer.iTextureRatioY = 1;
                this._depthRenderer.iRender(entityCollector);
            }

            this._depthRenderer.disableColor = false;

        }
        /**
        public function pRenderSceneDepthToTexture(entityCollector:EntityCollector):void
        {
            if (this._depthTextureInvalid || !this._pDepthRender)
            {
                this.initDepthTexture( this._pStage3DProxy._iContext3D);
            }
            this._depthRenderer.iTextureRatioX = this._pRttBufferManager.textureRatioX;
            this._depthRenderer.iTextureRatioY = this._pRttBufferManager.textureRatioY;
            this._depthRenderer.iRender(entityCollector, this._pDepthRender);
        }
        /**
		private function initDepthTexture(context:Context3D):void
		{
			this._depthTextureInvalid = false;
			
			if ( this._pDepthRender)
			{
				this._pDepthRender.dispose();
			}
			this._pDepthRender = context.createTexture( this._pRttBufferManager.textureWidth, this._pRttBufferManager.textureHeight, Context3DTextureFormat.BGRA, true );
		}
        /**
        public function dispose():void
        {
            this._pStage3DProxy.removeEventListener(Stage3DEvent.VIEWPORT_UPDATED, onViewportUpdated , this );

            if (!this.shareContext)
            {
                this._pStage3DProxy.dispose();
            }

            this._pRenderer.iDispose();

            if (this._pDepthRender)
            {
                this._pDepthRender.dispose();
            }

            if (this._pRttBufferManager)
            {
                this._pRttBufferManager.dispose();
            }

            // TODO: imeplement mouse3DManager / touch3DManager
            //this._mouse3DManager.disableMouseListeners(this);
            //this._mouse3DManager.dispose();
            //this._touch3DManager.disableTouchListeners(this);
            //this._touch3DManager.dispose();
            //this._mouse3DManager = null;
            //this._touch3DManager = null;

            this._pRttBufferManager = null;
            this._pDepthRender = null;
            this._depthRenderer = null;
            this._pStage3DProxy = null;
            this._pRenderer = null;
            this._pEntityCollector = null;
        }
        /**
		public function get iEntityCollector():EntityCollector
		{
			return this._pEntityCollector;
		}
        /**
		private function onLensChanged(event:CameraEvent):void
		{
			this._scissorRectDirty = true;
			this._viewportDirty = true;
		}
        /**
		private function onViewportUpdated(event:Stage3DEvent):void
		{
			if( this._pShareContext)
            {
				this._pScissorRect.x = this._globalPos.x - this._pStage3DProxy.x;
				this._pScissorRect.y = this._globalPos.y - this._pStage3DProxy.y;
				this._scissorRectDirty = true;
			}
			this._viewportDirty = true;
		}
        /**
		public function get depthPrepass():Boolean
		{
			return this._depthPrepass;
		}
        /**
		public function set depthPrepass(value:Boolean):void
		{
			this._depthPrepass = value;
		}
        /**
        private function onAddedToStage():void
        {

            this._addedToStage = true;

            if (this._pStage3DProxy == null )
            {

                this._pStage3DProxy= Stage3DManager.getInstance( this.stage ).getFreeStage3DProxy(this._forceSoftware, this._profile);
                this._pStage3DProxy.addEventListener(Stage3DEvent.VIEWPORT_UPDATED, onViewportUpdated , this );

            }

            this._globalPosDirty = true;
            this._pRttBufferManager = RTTBufferManager.getInstance(this._pStage3DProxy);
            this._depthRenderer.iStage3DProxy =  this._pStage3DProxy;
            this._pRenderer.iStage3DProxy = this._depthRenderer.iStage3DProxy

            if (this._width == 0)
            {
                this.width = this.stage.stageWidth;
            }
            else
            {
                this._pRttBufferManager.viewWidth = this._width;
            }

            if (this._height == 0)
            {
                this.height = this.stage.stageHeight;
            }
            else
            {
                this._pRttBufferManager.viewHeight = this._height;
            }

        }

        // TODO private function onAddedToStage(event:Event):void
        // TODO private function onAdded(event:Event):void

        public function project(point3d:Vector3D):Vector3D
        {
            var v:Vector3D = this._pCamera.project( point3d );
            v.x = (v.x + 1.0) * this._width/2.0;
            v.y = (v.y + 1.0) * this._height/2.0;
            return v;
        }

        public function unproject(sX:Number, sY:Number, sZ:Number):Vector3D
        {
            return this._pCamera.unproject( (sX*2 - this._width)/this._pStage3DProxy.width, (sY*2 - this._height)/this._pStage3DProxy.height, sZ );
        }

        public function getRay(sX:Number, sY:Number, sZ:Number):Vector3D
        {
            return this._pCamera.getRay( (sX*2 - this._width)/this._width, (sY*2 - this._height)/this._height, sZ );
        }
        /* TODO: implement Mouse3DManager
        /* TODO: implement Mouse3DManager
        /* TODO: implement Touch3DManager
        /* TODO: implement Touch3DManager
        /*TODO: implement Mouse3DManager
        /* TODO: implement Mouse3DManager
        /*TODO: implement Background
        /*TODO: implement Background

	}
}
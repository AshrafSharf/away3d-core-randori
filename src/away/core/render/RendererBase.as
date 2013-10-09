/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.render
{
	import away.core.display3D.Context3D;
	import away.managers.Stage3DProxy;
	import away.core.display3D.TextureBase;
	import away.core.sort.IEntitySorter;
	import away.core.display.BitmapData;
	import away.core.geom.Matrix3D;
	import away.core.sort.RenderableMergeSort;
	import away.core.traverse.EntityCollector;
	import away.events.Stage3DEvent;
	import away.core.geom.Rectangle;
	import away.core.display3D.Context3DCompareMode;
	import away.errors.AbstractMethodError;
	import away.events.Event;

	/**
	public class RendererBase
	{
		public var _pContext:Context3D;
		public var _pStage3DProxy:Stage3DProxy;
		
		private var _backgroundR:Number = 0;
		private var _backgroundG:Number = 0;
		private var _backgroundB:Number = 0;
		private var _backgroundAlpha:Number = 1;
		private var _shareContext:Boolean = false;
		
		public var _pRenderTarget:TextureBase;
		public var _pRenderTargetSurface:Number = 0;
		
		// only used by renderers that need to render geometry to textures
		private var _viewWidth:Number = 0;
		private var _viewHeight:Number = 0;
		
		public var _pRenderableSorter:IEntitySorter;

		//private _backgroundImageRenderer:BackgroundImageRenderer;
		//private _background:Texture2DBase;
		
		private var _renderToTexture:Boolean = false;
		private var _antiAlias:Number = 0;
		private var _textureRatioX:Number = 1;
		private var _textureRatioY:Number = 1;
		
		private var _snapshotBitmapData:BitmapData;
		private var _snapshotRequired:Boolean = false;
		
		private var _clearOnRender:Boolean = true;
		public var _pRttViewProjectionMatrix:Matrix3D = new Matrix3D();

		
		/**
		public function RendererBase(renderToTexture:Boolean):void
		{
			this._pRenderableSorter = new RenderableMergeSort();
			this._renderToTexture = renderToTexture;
		}
		
		public function iCreateEntityCollector():EntityCollector
		{
			return new EntityCollector();
		}
		
		public function get iViewWidth():Number
		{
			return this._viewWidth;
		}
		
		public function set iViewWidth(value:Number):void
		{
			this._viewWidth = value;
		}
		
		public function get iViewHeight():Number
		{
			return this._viewHeight;
		}
		
		public function set iViewHeight(value:Number):void
		{
			this._viewHeight = value;
		}
		
		public function get iRenderToTexture():Boolean
		{
			return this._renderToTexture;
		}
		
		public function get renderableSorter():IEntitySorter
		{
			return this._pRenderableSorter;
		}
		
		public function set renderableSorter(value:IEntitySorter):void
		{
			this._pRenderableSorter = value;
		}
		
		public function get iClearOnRender():Boolean
		{
			return this._clearOnRender;
		}
		
		public function set iClearOnRender(value:Boolean):void
		{
			this._clearOnRender = value;
		}
		
		/**
		public function get iBackgroundR():Number
		{
			return this._backgroundR;
		}
		
		public function set iBackgroundR(value:Number):void
		{
			this._backgroundR = value;
		}
		
		/**
		public function get iBackgroundG():Number
		{
			return this._backgroundG;
		}
		
		public function set iBackgroundG(value:Number):void
		{
			this._backgroundG = value;
		}
		
		/**
		public function get iBackgroundB():Number
		{
			return this._backgroundB;
		}
		
		public function set iBackgroundB(value:Number):void
		{
			this._backgroundB = value;
		}
		
		/**
		public function get iStage3DProxy():Stage3DProxy
		{
			return this._pStage3DProxy;
		}
		
		public function set iStage3DProxy(value:Stage3DProxy):void
		{

            this.iSetStage3DProxy( value );

		}

        public function iSetStage3DProxy(value:Stage3DProxy):void
        {

            if (value == this._pStage3DProxy)
            {

                return;

            }


            if (!value)
            {

                if (this._pStage3DProxy)
                {

                    this._pStage3DProxy.removeEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextUpdate , this );
                    this._pStage3DProxy.removeEventListener(Stage3DEvent.CONTEXT3D_RECREATED, onContextUpdate , this );

                }

                this._pStage3DProxy = null;
                this._pContext = null;

                return;
            }

            //else if (_pStage3DProxy) throw new Error("A Stage3D instance was already assigned!");

            this._pStage3DProxy = value;
            this._pStage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextUpdate , this );
            this._pStage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_RECREATED, onContextUpdate , this );

            /*
            if (value.context3D)
                this._pContext = value.context3D;

        }
		
		/**
		public function get iShareContext():Boolean
		{
			return this._shareContext;
		}
		
		public function set iShareContext(value:Boolean):void
		{
			this._shareContext = value;
		}
		
		/**
		public function iDispose():void
		{
			this._pStage3DProxy = null;

            /*
		}
		
		/**
		public function iRender(entityCollector:EntityCollector, target:TextureBase = null, scissorRect:Rectangle = null, surfaceSelector:Number = 0):void
		{
			target = target || null;
			scissorRect = scissorRect || null;
			surfaceSelector = surfaceSelector || 0;

			if (!this._pStage3DProxy || !this._pContext)
            {

                return;


            }

			
			this._pRttViewProjectionMatrix.copyFrom(entityCollector.camera.viewProjection);
            this._pRttViewProjectionMatrix.appendScale(this._textureRatioX, this._textureRatioY, 1);

            this.pExecuteRender(entityCollector, target, scissorRect, surfaceSelector);
			
			// clear buffers
			
			for (var i:Number = 0; i < 8; ++i)
            {

				this._pContext.setVertexBufferAt(i, null);
                this._pContext.setTextureAt(i, null);

			}
		}
		
		/**
		public function pExecuteRender(entityCollector:EntityCollector, target:TextureBase = null, scissorRect:Rectangle = null, surfaceSelector:Number = 0):void
		{
			target = target || null;
			scissorRect = scissorRect || null;
			surfaceSelector = surfaceSelector || 0;

			this._pRenderTarget = target;
			this._pRenderTargetSurface = surfaceSelector;
			
			if (this._pRenderableSorter)
            {

                this._pRenderableSorter.sort(entityCollector);

            }

			
			if (this._renderToTexture){

                this.pExecuteRenderToTexturePass(entityCollector);

            }

			this._pStage3DProxy.setRenderTarget(target, true, surfaceSelector);
			
			if ((target || !this._shareContext) && this._clearOnRender)
            {

               this. _pContext.clear(this._backgroundR, this._backgroundG, this._backgroundB, this._backgroundAlpha, 1, 0);

            }

			this._pContext.setDepthTest(false, Context3DCompareMode.ALWAYS);

			this._pStage3DProxy.scissorRect = scissorRect;

            /*

			this.pDraw(entityCollector, target);
			
			//line required for correct rendering when using away3d with starling. DO NOT REMOVE UNLESS STARLING INTEGRATION IS RETESTED!
			this._pContext.setDepthTest(false, Context3DCompareMode.LESS_EQUAL);
			
			if (!this._shareContext)
            {

				if (this._snapshotRequired && this._snapshotBitmapData)
                {

                    this._pContext.drawToBitmapData(this._snapshotBitmapData);
                    this._snapshotRequired = false;

				}

			}
            this._pStage3DProxy.scissorRect = null;
		}
		
		/*
		public function queueSnapshot(bmd:BitmapData):void
		{
			this._snapshotRequired = true;
            this._snapshotBitmapData = bmd;
		}
		
		public function pExecuteRenderToTexturePass(entityCollector:EntityCollector):void
		{
			throw new AbstractMethodError();
		}
		
		/**
		public function pDraw(entityCollector:EntityCollector, target:TextureBase):void
		{
            throw new AbstractMethodError();
		}
		
		/**
		private function onContextUpdate(event:Event):void
		{
			this._pContext = this._pStage3DProxy.context3D;
		}
		
		public function get iBackgroundAlpha():Number
		{
			return this._backgroundAlpha;
		}
		
		public function set iBackgroundAlpha(value:Number):void
		{
			this._backgroundAlpha = value;
		}

        /*

        /*
		/*

		public function get antiAlias():Number
		{
			return this._antiAlias;
		}
		
		public function set antiAlias(antiAlias:Number):void
		{
            this._antiAlias = antiAlias;
		}
		
		public function get iTextureRatioX():Number
		{
			return this._textureRatioX;
		}
		
		public function set iTextureRatioX(value:Number):void
		{
			this._textureRatioX = value;
		}
		
		public function get iTextureRatioY():Number
		{
			return this._textureRatioY;
		}
		
		public function set iTextureRatioY(value:Number):void
		{
			this._textureRatioY = value;
		}

	}
}
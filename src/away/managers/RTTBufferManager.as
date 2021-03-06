/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.managers
{
	import away.events.EventDispatcher;
	import away.core.display3D.VertexBuffer3D;
	import away.core.display3D.IndexBuffer3D;
	import away.core.geom.Rectangle;
	import away.utils.TextureUtils;
	import away.events.Event;
	import away.core.display3D.Context3D;

	public class RTTBufferManager extends EventDispatcher
	{
		private static var _instances:Vector.<RTTBufferManagerVO>;
		
		private var _renderToTextureVertexBuffer:VertexBuffer3D;
		private var _renderToScreenVertexBuffer:VertexBuffer3D;
		
		private var _indexBuffer:IndexBuffer3D;
		private var _stage3DProxy:Stage3DProxy;
		private var _viewWidth:Number = -1;
		private var _viewHeight:Number = -1;
		private var _textureWidth:Number = -1;
		private var _textureHeight:Number = -1;
		private var _renderToTextureRect:Rectangle;
		private var _buffersInvalid:Boolean = true;
		
		private var _textureRatioX:Number = 0;
		private var _textureRatioY:Number = 0;
		
		public function RTTBufferManager(se:SingletonEnforcer, stage3DProxy:Stage3DProxy):void
		{

            super();

			if (!se)
            {

                throw new Error("No cheating the multiton!");

            }

			
			this._renderToTextureRect = new Rectangle();
			
			this._stage3DProxy = stage3DProxy;

		}
		
		public static function getInstance(stage3DProxy:Stage3DProxy):RTTBufferManager
		{
			if (!stage3DProxy)
				throw new Error("stage3DProxy key cannot be null!");

            if ( RTTBufferManager._instances == null )
            {

                RTTBufferManager._instances = new Vector.<RTTBufferManagerVO>();
            }


            var rttBufferManager : RTTBufferManager = RTTBufferManager.getRTTBufferManagerFromStage3DProxy( stage3DProxy );

            if ( rttBufferManager == null )
            {

                rttBufferManager                = new RTTBufferManager( new SingletonEnforcer() , stage3DProxy );

                var vo : RTTBufferManagerVO     = new RTTBufferManagerVO();

                    vo.stage3dProxy             = stage3DProxy;
                    vo.rttbfm                   = rttBufferManager;

                RTTBufferManager._instances.push( vo );

            }

            return rttBufferManager;

		}

        private static function getRTTBufferManagerFromStage3DProxy(stage3DProxy:Stage3DProxy):RTTBufferManager
        {

            var l : Number = RTTBufferManager._instances.length;
            var r : RTTBufferManagerVO;

            for ( var c : Number = 0 ; c < l ; c ++ )
            {

                r = RTTBufferManager._instances[ c ];

                if (r.stage3dProxy === stage3DProxy )
                {

                    return r.rttbfm;

                }

            }

            return null;

        }

        private static function deleteRTTBufferManager(stage3DProxy:Stage3DProxy):void
        {

            var l : Number = RTTBufferManager._instances.length;
            var r : RTTBufferManagerVO;

            for ( var c : Number = 0 ; c < l ; c ++ )
            {

                r = RTTBufferManager._instances[ c ];

                if (r.stage3dProxy === stage3DProxy )
                {

                    RTTBufferManager._instances.splice( c , 1 );
                    return;

                }

            }


        }

		public function get textureRatioX():Number
		{

			if (this._buffersInvalid)
            {

                this.updateRTTBuffers();

            }

			return this._textureRatioX;

		}
		
		public function get textureRatioY():Number
		{

			if (this._buffersInvalid)
            {

                this.updateRTTBuffers();

            }

			return this._textureRatioY;

		}
		
		public function get viewWidth():Number
		{
			return this._viewWidth;
		}
		
		public function set viewWidth(value:Number):void
		{
			if (value == this._viewWidth)
            {

                return;

            }

			this._viewWidth = value;

            this._buffersInvalid = true;

            this._textureWidth = TextureUtils.getBestPowerOf2(this._viewWidth);
			
			if (this._textureWidth > this._viewWidth)
            {

                this._renderToTextureRect.x = Math.floor( (this._textureWidth - this._viewWidth)*.5);
                this._renderToTextureRect.width = this._viewWidth;

			}
            else
            {
				this._renderToTextureRect.x = 0;
                this._renderToTextureRect.width = this._textureWidth;

			}
			
			this.dispatchEvent( new Event(Event.RESIZE));

		}
		
		public function get viewHeight():Number
		{
			return this._viewHeight;
		}

		public function set viewHeight(value:Number):void
		{
			if (value == this._viewHeight)
            {

                return;

            }

			this._viewHeight = value;

            this._buffersInvalid = true;

            this._textureHeight = TextureUtils.getBestPowerOf2(this._viewHeight);
			
			if ( this._textureHeight > this._viewHeight)
            {

                this._renderToTextureRect.y = Math.floor((this._textureHeight - this._viewHeight)*.5);
                this._renderToTextureRect.height = this._viewHeight;

			}
            else
            {

                this._renderToTextureRect.y = 0;
                this._renderToTextureRect.height = this._textureHeight;

			}
			
			this.dispatchEvent(new Event(Event.RESIZE));

		}
		
		public function get renderToTextureVertexBuffer():VertexBuffer3D
		{

			if (this._buffersInvalid)
            {

                this.updateRTTBuffers();

            }

			return this._renderToTextureVertexBuffer;
		}
		
		public function get renderToScreenVertexBuffer():VertexBuffer3D
		{

			if (this._buffersInvalid)
            {

                this.updateRTTBuffers();

            }

			return this._renderToScreenVertexBuffer;

		}
		
		public function get indexBuffer():IndexBuffer3D
		{
			return this._indexBuffer;
		}
		
		public function get renderToTextureRect():Rectangle
		{

			if (this._buffersInvalid)
            {

				this.updateRTTBuffers();

            }

			return this._renderToTextureRect;
		}
		
		public function get textureWidth():Number
		{
			return this._textureWidth;
		}
		
		public function get textureHeight():Number
		{
			return this._textureHeight;
		}
		
		public function dispose():void
		{

            RTTBufferManager.deleteRTTBufferManager( this._stage3DProxy );

			if (this._indexBuffer)
            {

                this._indexBuffer.dispose();
                this._renderToScreenVertexBuffer.dispose();
                this._renderToTextureVertexBuffer.dispose();
                this._renderToScreenVertexBuffer = null;
                this._renderToTextureVertexBuffer = null;
                this._indexBuffer = null;

			}
		}
		
		// todo: place all this in a separate model, since it's used all over the place
		// maybe it even has a place in the core (together with screenRect etc)?
		// needs to be stored per view of course
		private function updateRTTBuffers():void
		{
			var context:Context3D = this._stage3DProxy._iContext3D;
			var textureVerts:Vector.<Number>;
			var screenVerts:Vector.<Number>;

			var x:Number;
            var y:Number;

            if ( this._renderToTextureVertexBuffer  == null )
            {

                this._renderToTextureVertexBuffer = context.createVertexBuffer(4, 5);

            }

            if ( this._renderToScreenVertexBuffer == null )
            {

                this._renderToScreenVertexBuffer = context.createVertexBuffer(4, 5);

            }

			if (!this._indexBuffer)
            {

				this._indexBuffer = context.createIndexBuffer(6);

                this._indexBuffer.uploadFromArray( new <Number>[2, 1, 0, 3, 2, 0], 0, 6);
			}
			
			x =  Math.min(this._viewWidth/this._textureWidth, 1);
			this._textureRatioX = x
            y =  Math.min(this._viewHeight/this._textureHeight, 1);
            this._textureRatioY = y
			
			var u1:Number = (1 - x)*.5;
			var u2:Number = (x + 1)*.5;
			var v1:Number = (y + 1)*.5;
			var v2:Number = (1 - y)*.5;
			
			// last element contains indices for data per vertex that can be passed to the vertex shader if necessary (ie: frustum corners for deferred rendering)
			textureVerts = new <Number>[    -x, -y, u1, v1, 0,
				                x, -y, u2, v1, 1,
				                x, y, u2, v2, 2,
				                -x, y, u1, v2, 3 ];
			
			screenVerts = new <Number>[     -1, -1, u1, v1, 0,
				                1, -1, u2, v1, 1,
				                1, 1, u2, v2, 2,
				                -1, 1, u1, v2, 3 ];
			
			this._renderToTextureVertexBuffer.uploadFromArray(textureVerts, 0, 4);
            this._renderToScreenVertexBuffer.uploadFromArray(screenVerts, 0, 4);
			
			this._buffersInvalid = false;
			
		}
	}
}
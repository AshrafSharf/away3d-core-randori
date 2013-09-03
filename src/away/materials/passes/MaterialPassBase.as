///<reference path="../../_definitions.ts"/>

package away.materials.passes
{
	import away.events.EventDispatcher;
	import away.materials.MaterialBase;
	import away.animators.IAnimationSet;
	import away.display3D.Program3D;
	import away.display3D.Context3D;
	import away.display3D.Context3DCompareMode;
	import away.display3D.Context3DBlendFactor;
	import away.materials.lightpickers.LightPickerBase;
	import away.display3D.Context3DTriangleFace;
	import away.display3D.TextureBase;
	import away.geom.Rectangle;
	import away.events.Event;
	import away.managers.AGALProgram3DCache;
	import away.base.IRenderable;
	import away.managers.Stage3DProxy;
	import away.cameras.Camera3D;
	import away.geom.Matrix3D;
	import away.errors.AbstractMethodError;
	import away.display.BlendMode;
	import away.errors.ArgumentError;
	//import away3d.animators.data.AnimationRegisterCache;
	//import away3d.animators.IAnimationSet;
	//import away3d.arcane;
	//import away3d.cameras.Camera3D;
	//import away3d.core.base.IRenderable;
	//import away3d.managers.AGALProgram3DCache;
	//import away3d.managers.Stage3DProxy;
	//import away3d.debug.Debug;
	//import away3d.errors.AbstractMethodError;
	//import away3d.materials.MaterialBase;
	//import away3d.materials.lightpickers.LightPickerBase;
	
	//import flash.display.BlendMode;
	//import flash.display3D.Context3D;
	//import flash.display3D.Context3DBlendFactor;
	//import flash.display3D.Context3DCompareMode;
	//import flash.display3D.Context3DTriangleFace;
	//import flash.display3D.Program3D;
	//import flash.display3D.textures.TextureBase;
	//import flash.events.Event;
	//import flash.events.EventDispatcher;
	//import flash.geom.Matrix3D;
	//import flash.geom.Rectangle;
	
	//use namespace arcane;
	
	/**
	public class MaterialPassBase extends EventDispatcher
	{
        public var _pMaterial:MaterialBase;
		private var _animationSet:IAnimationSet;

        public var _iProgram3Ds:Vector.<Program3D> = new Vector.<Program3D>( 8 );
        public var _iProgram3Dids:Vector.<Number> = new Vector.<Number>(-1, -1, -1, -1, -1, -1, -1, -1);//Vector.<int> = Vector.<int>([-1, -1, -1, -1, -1, -1, -1, -1]);
		// agal props. these NEED to be set by subclasses!
		// todo: can we perhaps figure these out manually by checking read operations in the bytecode, so other sources can be safely updated?
        public var _pNumUsedStreams:Number;
        public var _pNumUsedTextures:Number;
        public var _pNumUsedVertexConstants:Number;
        public var _pNumUsedFragmentConstants:Number;
        public var _pNumUsedVaryings:Number;

        public var _pSmooth:Boolean = true;
        public var _pRepeat:Boolean = false;
        public var _pMipmap:Boolean = true;
		private var _depthCompareMode:String = Context3DCompareMode.LESS_EQUAL;
		
		private var _blendFactorSource:String = Context3DBlendFactor.ONE;
		private var _blendFactorDest:String = Context3DBlendFactor.ZERO;

        public var _pEnableBlending:Boolean = false;
		
		public var _pBothSides:Boolean;
		
		public var _pLightPicker:LightPickerBase;

        // TODO: AGAL conversion
        public var _pAnimatableAttributes:Vector.<String> = new Vector.<String>();

        // TODO: AGAL conversion
        public var _pAnimationTargetRegisters:Vector.<String> = new Vector.<String>();

        // TODO: AGAL conversion
        public var _pShadedTarget:String = "ft0";
		
		// keep track of previously rendered usage for faster cleanup of old vertex buffer streams and textures
		private static var _previousUsedStreams:Vector.<Number> = new Vector.<Number>(0, 0, 0, 0, 0, 0, 0, 0);//Vector.<int> = Vector.<int>([0, 0, 0, 0, 0, 0, 0, 0]);
		
		private var _renderToTexture:Boolean;
		
		// render state mementos for render-to-texture passes
		private var _oldTarget:TextureBase;
		private var _oldSurface:Number;
		private var _oldDepthStencil:Boolean;
		private var _oldRect:Rectangle;

        public var _pAlphaPremultiplied:Boolean = false;
        public var _pNeedFragmentAnimation:Boolean;
        public var _pNeedUVAnimation:Boolean;
        public var _pUVTarget:String;
        public var _pUVSource:String;
		
		private var _writeDepth:Boolean = true;
		
		//public animationRegisterCache:AnimationRegisterCache; TODO: implement dependency AnimationRegisterCache
		
		/**
		public function MaterialPassBase(renderToTexture:Boolean = false):void
		{

            super();
			
			_pAnimatableAttributes.push( "va0");
			_pAnimationTargetRegisters.push( "vt0" );
		
			this._renderToTexture = renderToTexture;
            this._pNumUsedStreams = 1;
            this._pNumUsedVertexConstants = 5;

		}
		
		/**
		public function get material():MaterialBase
		{
			return _pMaterial;
		}
		
		public function set material(value:MaterialBase):void
		{
			this._pMaterial = value;
		}
		
		/**
		public function get writeDepth():Boolean
		{
			return _writeDepth;
		}
		
		public function set writeDepth(value:Boolean):void
		{
			this._writeDepth = value;
		}
		
		/**
		public function get mipmap():Boolean
		{
			return _pMipmap;
		}
		
		public function set mipmap(value:Boolean):void
		{

            this.setMipMap( value );

		}

        public function setMipMap(value:Boolean):void
        {

            if (_pMipmap == value)
            {

                return;

            }

            _pMipmap = value;
            iInvalidateShaderProgram( );

        }
		/**
		public function get smooth():Boolean
		{
			return _pSmooth;
		}
		
		public function set smooth(value:Boolean):void
		{
			if (this._pSmooth == value)
            {

                return;

            }

			this._pSmooth = value;
            this.iInvalidateShaderProgram( );
		}
		
		/**
		public function get repeat():Boolean
		{
			return _pRepeat;
		}
		
		public function set repeat(value:Boolean):void
		{
			if (this._pRepeat == value)
            {

                return;

            }

			this._pRepeat = value;
            this.iInvalidateShaderProgram( );
		}
		
		/**
		public function get bothSides():Boolean
		{
			return _pBothSides;
		}
		
		public function set bothSides(value:Boolean):void
		{
            this._pBothSides = value;
		}

		/**
		public function get depthCompareMode():String
		{
			return _depthCompareMode;
		}
		
		public function set depthCompareMode(value:String):void
		{
            this._depthCompareMode = value;
		}

		/**
		public function get animationSet():IAnimationSet
		{
			return _animationSet;
		}
		
		public function set animationSet(value:IAnimationSet):void
		{
			if (this._animationSet == value)
            {

                return;

            }

			
			this._animationSet = value;

            this.iInvalidateShaderProgram( );
		}
		
		/**
		public function get renderToTexture():Boolean
		{
			return _renderToTexture;
		}
		
		/**
		public function dispose():void
		{
			if (_pLightPicker)
            {

                _pLightPicker.removeEventListener(Event.CHANGE, onLightsChange , this );

            }

			
			for (var i:Number = 0; i < 8; ++i)
            {

				if (_iProgram3Ds[i])
                {

                    //away.Debug.throwPIR( 'away.materials.MaterialPassBase' , 'dispose' , 'required dependency: AGALProgram3DCache');
					AGALProgram3DCache.getInstanceFromIndex(i).freeProgram3D(_iProgram3Dids[i]);
					_iProgram3Ds[i] = null;

				}
			}
		}
		
		/**
		public function get numUsedStreams():Number
		{
			return _pNumUsedStreams;
		}
		
		/**
		public function get numUsedVertexConstants():Number
		{
			return _pNumUsedVertexConstants;
		}
		
		public function get numUsedVaryings():Number
		{
			return _pNumUsedVaryings;
		}

		/**
		public function get numUsedFragmentConstants():Number
		{
			return _pNumUsedFragmentConstants;
		}
		
		public function get needFragmentAnimation():Boolean
		{
			return _pNeedFragmentAnimation;
		}

		/**
		public function get needUVAnimation():Boolean
		{
			return _pNeedUVAnimation;
		}
		
		/**
		public function iUpdateAnimationState(renderable:IRenderable, stage3DProxy:Stage3DProxy, camera:Camera3D):void
		{
			renderable.animator.setRenderState(stage3DProxy, renderable, _pNumUsedVertexConstants, _pNumUsedStreams, camera);
		}
		
		/**
		public function iRender(renderable:IRenderable, stage3DProxy:Stage3DProxy, camera:Camera3D, viewProjection:Matrix3D):void
		{
			throw new AbstractMethodError();
		}

		/**
		public function iGetVertexCode():String
		{
            throw new AbstractMethodError();
		}

		/**
		public function iGetFragmentCode(fragmentAnimatorCode:String):String
		{
            throw new AbstractMethodError();
		}

		/**
		public function setBlendMode(value:String):void
		{
			switch (value)
            {

				case BlendMode.NORMAL:

					_blendFactorSource = Context3DBlendFactor.ONE;
					_blendFactorDest = Context3DBlendFactor.ZERO;
					_pEnableBlending = false;

					break;

				case BlendMode.LAYER:

					_blendFactorSource = Context3DBlendFactor.SOURCE_ALPHA;
                    _blendFactorDest = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
                    _pEnableBlending = true;

					break;

				case BlendMode.MULTIPLY:

					_blendFactorSource = Context3DBlendFactor.ZERO;
                    _blendFactorDest = Context3DBlendFactor.SOURCE_COLOR;
                    _pEnableBlending = true;

					break;

				case BlendMode.ADD:

					_blendFactorSource = Context3DBlendFactor.SOURCE_ALPHA;
                    _blendFactorDest =  Context3DBlendFactor.ONE;
                    _pEnableBlending = true;

					break;

				case BlendMode.ALPHA:

					_blendFactorSource = Context3DBlendFactor.ZERO;
					_blendFactorDest = Context3DBlendFactor.SOURCE_ALPHA;
					_pEnableBlending = true;

					break;

				default:

					throw new away.errors.ArgumentError("Unsupported blend mode!");

			}
		}

		/**
		public function iActivate(stage3DProxy:Stage3DProxy, camera:Camera3D):void
		{
			var contextIndex:Number = stage3DProxy._iStage3DIndex;//_stage3DIndex;
			var context:Context3D = stage3DProxy._iContext3D;

			context.setDepthTest( ( _writeDepth && ! _pEnableBlending ) , _depthCompareMode);

			if (_pEnableBlending)
            {

                context.setBlendFactors( _blendFactorSource, _blendFactorDest);

            }

			if ( _context3Ds[contextIndex] != context || ! _iProgram3Ds[contextIndex])
            {

				_context3Ds[contextIndex] = context;

                iUpdateProgram( stage3DProxy );
				dispatchEvent(new Event(Event.CHANGE));

			}

			var prevUsed:Number = MaterialPassBase._previousUsedStreams[contextIndex];
			var i:Number;

			for (i = _pNumUsedStreams; i < prevUsed; ++i)
            {

                context.setVertexBufferAt(i, null);

            }

			
			prevUsed = MaterialPassBase._previousUsedTexs[contextIndex];
			
			for (i = _pNumUsedTextures; i < prevUsed; ++i)
            {

                context.setTextureAt(i, null);

            }

			
			if ( _animationSet && ! _animationSet.usesCPU)
            {

                _animationSet.activate(stage3DProxy, this);

            }


			context.setProgram(_iProgram3Ds[contextIndex]);
			
			context.setCulling(_pBothSides? Context3DTriangleFace.NONE : _defaultCulling);
			
			if (_renderToTexture)
            {
				_oldTarget = stage3DProxy.renderTarget;
                _oldSurface = stage3DProxy.renderSurfaceSelector;
                _oldDepthStencil = stage3DProxy.enableDepthAndStencil;
                _oldRect = stage3DProxy.scissorRect;
			}
		}

		/**
		public function iDeactivate(stage3DProxy:Stage3DProxy):void
		{

			var index:Number = stage3DProxy._iStage3DIndex;//_stage3DIndex;
			MaterialPassBase._previousUsedStreams[index] = _pNumUsedStreams;
            MaterialPassBase._previousUsedTexs[index] = _pNumUsedTextures;
			
			if (_animationSet && !_animationSet.usesCPU)
            {

                _animationSet.deactivate(stage3DProxy, this);

            }

			
			if ( _renderToTexture)
            {

				// kindly restore state
				stage3DProxy.setRenderTarget(_oldTarget, _oldDepthStencil, _oldSurface);
				stage3DProxy.scissorRect = _oldRect;

			}

			stage3DProxy._iContext3D.setDepthTest(true, Context3DCompareMode.LESS_EQUAL); // TODO : imeplement
		}
		
		/**
		public function iInvalidateShaderProgram(updateMaterial:Boolean = true):void
		{
			for (var i:Number = 0; i < 8; ++i)
            {

                _iProgram3Ds[i] = null;

            }

			
			if (_pMaterial && updateMaterial)
            {

                _pMaterial.iInvalidatePasses(this);

            }

		}
		
		/**
		public function iUpdateProgram(stage3DProxy:Stage3DProxy):void
		{
			var animatorCode:String = "";
			var UVAnimatorCode:String = "";
			var fragmentAnimatorCode:String = "";
			var vertexCode:String = iGetVertexCode();//getVertexCode();
			
			if ( _animationSet && ! _animationSet.usesCPU)
            {

				animatorCode = _animationSet.getAGALVertexCode(this, _pAnimatableAttributes, _pAnimationTargetRegisters, stage3DProxy.profile);

				if (_pNeedFragmentAnimation)
                {

                    fragmentAnimatorCode = _animationSet.getAGALFragmentCode(this, _pShadedTarget, stage3DProxy.profile);

                }

				if ( _pNeedUVAnimation)
                {

                    UVAnimatorCode = _animationSet.getAGALUVCode(this, _pUVSource, _pUVTarget);

                }

				_animationSet.doneAGALCode(this);

			}
            else
            {
				var len:Number = _pAnimatableAttributes.length;
				
				// simply write attributes to targets, do not animate them
				// projection will pick up on targets[0] to do the projection
				for (var i:Number = 0; i < len; ++i)
                {
                    // TODO: AGAL <> GLSL conversion:
                    //away.Debug.throwPIR( 'away.materials.MaterialPassBase' , 'iUpdateProgram' , 'AGAL <> GLSL Conversion');
                    animatorCode += "mov " + _pAnimationTargetRegisters[i] + ", " + _pAnimatableAttributes[i] + "\n";

                }

				if (_pNeedUVAnimation)
                {

                    //away.Debug.throwPIR( 'away.materials.MaterialPassBase' , 'iUpdateProgram' , 'AGAL <> GLSL Conversion');
                    // TODO: AGAL <> GLSL conversion
                    UVAnimatorCode = "mov " + _pUVTarget+ "," + _pUVSource + "\n";

                }

			}
			
			vertexCode = animatorCode + UVAnimatorCode + vertexCode;
			
			var fragmentCode:String = iGetFragmentCode( fragmentAnimatorCode );

            /*

			AGALProgram3DCache.getInstance(stage3DProxy).setProgram3D(this, vertexCode, fragmentCode);

		}

		/**
		public function get lightPicker():LightPickerBase
		{
			return _pLightPicker;
		}
		
		public function set lightPicker(value:LightPickerBase):void
		{
			if ( this._pLightPicker)
            {

                this._pLightPicker.removeEventListener(Event.CHANGE, this.onLightsChange , this );

            }

			this._pLightPicker = value;

			if (this._pLightPicker)
            {

                this._pLightPicker.addEventListener(Event.CHANGE, this.onLightsChange , this );

            }

            this.pUpdateLights();

		}

		/**
		private function onLightsChange(event:Event):void
		{
            pUpdateLights();

		}

		/**
		public function pUpdateLights():void
		{
		
		}

		/**
		public function get alphaPremultiplied():Boolean
		{
			return _pAlphaPremultiplied;
		}
		
		public function set alphaPremultiplied(value:Boolean):void
		{
            this._pAlphaPremultiplied = value;
            this.iInvalidateShaderProgram( false );
		}
	}
}
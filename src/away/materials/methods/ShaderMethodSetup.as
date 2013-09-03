///<reference path="../../_definitions.ts"/>
package away.materials.methods
{
	import away.events.EventDispatcher;
	import away.events.ShadingMethodEvent;

	/**
	public class ShaderMethodSetup extends EventDispatcher
	{
		public var _iColorTransformMethod:ColorTransformMethod;
        public var _iColorTransformMethodVO:MethodVO;
        public var _iNormalMethod:BasicNormalMethod;
        public var _iNormalMethodVO:MethodVO;
        public var _iAmbientMethod:BasicAmbientMethod;
        public var _iAmbientMethodVO:MethodVO;
        public var _iShadowMethod:ShadowMapMethodBase;
        public var _iShadowMethodVO:MethodVO;
        public var _iDiffuseMethod:BasicDiffuseMethod;
        public var _iDiffuseMethodVO:MethodVO;
        public var _iSpecularMethod:BasicSpecularMethod;
        public var _iSpecularMethodVO:MethodVO;
        public var _iMethods:Vector.<MethodVOSet>;//Vector.<MethodVOSet>;
		/**
		public function ShaderMethodSetup():void
		{

            super();

			this._iMethods = new Vector.<MethodVOSet>();//Vector.<MethodVOSet>();
            this._iNormalMethod = new BasicNormalMethod();
            this._iAmbientMethod = new BasicAmbientMethod();
            this._iDiffuseMethod = new BasicDiffuseMethod();
            this._iSpecularMethod = new BasicSpecularMethod();
            this._iNormalMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated, this);
            this._iDiffuseMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated, this);
            this._iSpecularMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated, this);
            this._iAmbientMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this);
            this._iNormalMethodVO = this._iNormalMethod.iCreateMethodVO();
            this._iAmbientMethodVO = this._iAmbientMethod.iCreateMethodVO();
            this._iDiffuseMethodVO = this._iDiffuseMethod.iCreateMethodVO();
            this._iSpecularMethodVO = this._iSpecularMethod.iCreateMethodVO();
		}

		/**
		private function onShaderInvalidated(event:ShadingMethodEvent):void
		{
			invalidateShaderProgram();
		}

		/**
		private function invalidateShaderProgram():void
		{

			dispatchEvent( new ShadingMethodEvent(ShadingMethodEvent.SHADER_INVALIDATED) );

		}

		/**
		public function get normalMethod():BasicNormalMethod
		{
			return _iNormalMethod;
		}
		
		public function set normalMethod(value:BasicNormalMethod):void
		{
			if (this._iNormalMethod)
            {

                this._iNormalMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );

            }

			
			if (value)
            {

				if (this._iNormalMethod)
                {

                    value.copyFrom(this._iNormalMethod);

                }


				this._iNormalMethodVO = value.iCreateMethodVO();
				value.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );
			}
			
			this._iNormalMethod = value;
			
			if (value)
				this.invalidateShaderProgram();
		}

		/**
		public function get ambientMethod():BasicAmbientMethod
		{
			return _iAmbientMethod;
		}
		
		public function set ambientMethod(value:BasicAmbientMethod):void
		{
			if (this._iAmbientMethod)
				this._iAmbientMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );

			if (value)
            {

				if (this._iAmbientMethod)
					value.copyFrom(this._iAmbientMethod);

				value.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );
				this._iAmbientMethodVO = value.iCreateMethodVO();

			}
			this._iAmbientMethod = value;
			
			if (value)
				this.invalidateShaderProgram();
		}

		/**
		public function get shadowMethod():ShadowMapMethodBase
		{
			return _iShadowMethod;
		}
		
		public function set shadowMethod(value:ShadowMapMethodBase):void
		{
			if (this._iShadowMethod)
            {

                this._iShadowMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );

            }

			this._iShadowMethod = value;

			if ( this._iShadowMethod)
            {

				this._iShadowMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );
				this._iShadowMethodVO = this._iShadowMethod.iCreateMethodVO();

			}
            else
            {

                this._iShadowMethodVO = null;

            }

			this.invalidateShaderProgram();

		}

		/**
		 public function get diffuseMethod():BasicDiffuseMethod
		{
			return _iDiffuseMethod;
		}
		
		public function set diffuseMethod(value:BasicDiffuseMethod):void
		{
			if (this._iDiffuseMethod)
				this._iDiffuseMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );
			
			if (value)
            {

				if (this._iDiffuseMethod)
					value.copyFrom( this._iDiffuseMethod);

				value.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );

				this._iDiffuseMethodVO = value.iCreateMethodVO();
			}
			
			this._iDiffuseMethod = value;
			
			if (value)
				this.invalidateShaderProgram();

		}
		
		/**
		public function get specularMethod():BasicSpecularMethod
		{
			return _iSpecularMethod;
		}
		
		public function set specularMethod(value:BasicSpecularMethod):void
		{
			if (this._iSpecularMethod)
            {
				this._iSpecularMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );

				if (value)
					value.copyFrom(this._iSpecularMethod);

			}
			
			this._iSpecularMethod = value;
			if (this._iSpecularMethod)
            {

				this._iSpecularMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );
				this._iSpecularMethodVO = this._iSpecularMethod.iCreateMethodVO();

			}
            else
            {

                this._iSpecularMethodVO = null;

            }

			this.invalidateShaderProgram();

		}
		
		/**
		public function get iColorTransformMethod():ColorTransformMethod
		{
			return _iColorTransformMethod;
		}
		
		public function set iColorTransformMethod(value:ColorTransformMethod):void
		{
			if (this._iColorTransformMethod == value)
				return;

			if (this._iColorTransformMethod)
				this._iColorTransformMethod.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );

			if (!this._iColorTransformMethod || !value)
            {

                this.invalidateShaderProgram();

            }

			
			this._iColorTransformMethod = value;

			if (this._iColorTransformMethod)
            {
				this._iColorTransformMethod.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, this.onShaderInvalidated , this );
				this._iColorTransformMethodVO = this._iColorTransformMethod.iCreateMethodVO();

			}
            else
            {

                this._iColorTransformMethodVO = null;

            }

		}

		/**
		public function dispose():void
		{
			clearListeners(_iNormalMethod);
            clearListeners(_iDiffuseMethod);
            clearListeners(_iShadowMethod);
            clearListeners(_iAmbientMethod);
            clearListeners(_iSpecularMethod);
			
			for (var i:Number = 0; i < _iMethods.length; ++i)
            {

                clearListeners(_iMethods[i].method);

            }

			
			_iMethods = null;

		}

		/**
		private function clearListeners(method:ShadingMethodBase):void
		{
			if (method)
				method.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );
		}
		
		/**
		public function addMethod(method:EffectMethodBase):void
		{
			_iMethods.push(new MethodVOSet(method));

			method.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );

			invalidateShaderProgram();

		}

		/**
		public function hasMethod(method:EffectMethodBase):Boolean
		{

			return getMethodSetForMethod(method) != null;

		}
		
		/**
		public function addMethodAt(method:EffectMethodBase, index:Number):void
		{
			_iMethods.splice(index, 0, new MethodVOSet(method));

			method.addEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );

			invalidateShaderProgram();

		}

		/**
		public function getMethodAt(index:Number):EffectMethodBase
		{
			if (index > _iMethods.length - 1)
				return null;
			
			return _iMethods[index].method;

		}

		/**
		public function get numMethods():Number
		{

			return _iMethods.length;

		}
		
		/**
		public function removeMethod(method:EffectMethodBase):void
		{
			var methodSet:MethodVOSet = getMethodSetForMethod(method);

			if (methodSet != null)
            {
				var index:Number = _iMethods.indexOf(methodSet);

				_iMethods.splice(index, 1);

				method.removeEventListener(ShadingMethodEvent.SHADER_INVALIDATED, onShaderInvalidated , this );

				invalidateShaderProgram();

			}
		}
		
		private function getMethodSetForMethod(method:EffectMethodBase):MethodVOSet
		{
			var len:Number = _iMethods.length;

			for (var i:Number = 0; i < len; ++i)
            {
				if (_iMethods[i].method == method)
					return _iMethods[i];
			}
			
			return null;
		}
	}
}
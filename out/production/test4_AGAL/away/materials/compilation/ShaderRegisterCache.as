/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.compilation
{
	
	/**
	public class ShaderRegisterCache
	{
		private var _fragmentTempCache:RegisterPool;
		private var _vertexTempCache:RegisterPool;
		private var _varyingCache:RegisterPool;
		private var _fragmentConstantsCache:RegisterPool;
		private var _vertexConstantsCache:RegisterPool;
		private var _textureCache:RegisterPool;
		private var _vertexAttributesCache:RegisterPool;
		private var _vertexConstantOffset:Number = 0;//TODO: check if this should be initialised to 0
		private var _vertexAttributesOffset:Number = 0;//TODO: check if this should be initialised to 0
		private var _varyingsOffset:Number = 0;//TODO: check if this should be initialised to 0
		private var _fragmentConstantOffset:Number = 0;//TODO: check if this should be initialised to 0
		
		private var _fragmentOutputRegister:ShaderRegisterElement;
		private var _vertexOutputRegister:ShaderRegisterElement;
		private var _numUsedVertexConstants:Number = 0;
		private var _numUsedFragmentConstants:Number = 0;
		private var _numUsedStreams:Number = 0;
		private var _numUsedTextures:Number = 0;
		private var _numUsedVaryings:Number = 0;
		private var _profile:String = null;
		
		/**
		public function ShaderRegisterCache(profile:String):void
		{

			this._profile = profile;

		}
		
		/**
		public function reset():void
		{

            //TODO: AGAL <> GLSL Conversion

			this._fragmentTempCache = new RegisterPool("ft", 8, false);
            this._vertexTempCache = new RegisterPool("vt", 8, false);
            this._varyingCache = new RegisterPool("v", 8);
            this._textureCache = new RegisterPool("fs", 8);
            this._vertexAttributesCache = new RegisterPool("va", 8);
            this._fragmentConstantsCache = new RegisterPool("fc", 28);
            this._vertexConstantsCache = new RegisterPool("vc", 128);
            this._fragmentOutputRegister = new ShaderRegisterElement("oc", -1);
            this._vertexOutputRegister = new ShaderRegisterElement("op", -1);
            this._numUsedVertexConstants = 0;
            this._numUsedStreams = 0;
            this._numUsedTextures = 0;
            this._numUsedVaryings = 0;
            this._numUsedFragmentConstants = 0;

			var i:Number;

			for (i = 0; i < this._vertexAttributesOffset; ++i)
                this.getFreeVertexAttribute();

			for (i = 0; i < this._vertexConstantOffset; ++i)
                this.getFreeVertexConstant();

			for (i = 0; i < this._varyingsOffset; ++i)
                this.getFreeVarying();

			for (i = 0; i < this._fragmentConstantOffset; ++i)
                this.getFreeFragmentConstant();
		
		}

		/**
		public function dispose():void
		{

			this._fragmentTempCache.dispose();
            this._vertexTempCache.dispose();
            this._varyingCache.dispose();
            this._fragmentConstantsCache.dispose();
            this._vertexAttributesCache.dispose();

            this._fragmentTempCache = null;
            this._vertexTempCache = null;
            this._varyingCache = null;
            this._fragmentConstantsCache = null;
            this._vertexAttributesCache = null;
            this._fragmentOutputRegister = null;
            this._vertexOutputRegister = null;

		}
		
		/**
		public function addFragmentTempUsages(register:ShaderRegisterElement, usageCount:Number):void
		{
			this._fragmentTempCache.addUsage(register, usageCount);
		}
		
		/**
		public function removeFragmentTempUsage(register:ShaderRegisterElement):void
		{
            this._fragmentTempCache.removeUsage(register);
		}
		
		/**
		public function addVertexTempUsages(register:ShaderRegisterElement, usageCount:Number):void
		{
			this._vertexTempCache.addUsage(register, usageCount);
		}
		
		/**
		public function removeVertexTempUsage(register:ShaderRegisterElement):void
		{
			this._vertexTempCache.removeUsage(register);
		}
		
		/**
		public function getFreeFragmentVectorTemp():ShaderRegisterElement
		{
			return this._fragmentTempCache.requestFreeVectorReg();
		}
		
		/**
		public function getFreeFragmentSingleTemp():ShaderRegisterElement
		{
			return this._fragmentTempCache.requestFreeRegComponent();
		}
		
		/**
		public function getFreeVarying():ShaderRegisterElement
		{
			++this._numUsedVaryings;
			return this._varyingCache.requestFreeVectorReg();
		}
		
		/**
		public function getFreeFragmentConstant():ShaderRegisterElement
		{
			++this._numUsedFragmentConstants;
			return this._fragmentConstantsCache.requestFreeVectorReg();

		}
		
		/**
		public function getFreeVertexConstant():ShaderRegisterElement
		{
			++this._numUsedVertexConstants;
			return this._vertexConstantsCache.requestFreeVectorReg();
		}
		
		/**
		public function getFreeVertexVectorTemp():ShaderRegisterElement
		{
			return this._vertexTempCache.requestFreeVectorReg();
		}
		
		/**
		public function getFreeVertexSingleTemp():ShaderRegisterElement
		{
			return this._vertexTempCache.requestFreeRegComponent();
		}
		
		/**
		public function getFreeVertexAttribute():ShaderRegisterElement
		{
			++this._numUsedStreams;
			return this._vertexAttributesCache.requestFreeVectorReg();
		}
		
		/**
		public function getFreeTextureReg():ShaderRegisterElement
		{
			++this._numUsedTextures;
			return this._textureCache.requestFreeVectorReg();
		}
		
		/**
		public function get vertexConstantOffset():Number
		{
			return this._vertexConstantOffset;
		}
		
		public function set vertexConstantOffset(vertexConstantOffset:Number):void
		{
			this._vertexConstantOffset = vertexConstantOffset;
		}
		
		/**
		public function get vertexAttributesOffset():Number
		{
			return this._vertexAttributesOffset;
		}
		
		public function set vertexAttributesOffset(value:Number):void
		{
			this._vertexAttributesOffset = value;
		}

		/**
		public function get varyingsOffset():Number
		{
			return this._varyingsOffset;
		}
		
		public function set varyingsOffset(value:Number):void
		{
            this._varyingsOffset = value;
		}

		/**
		public function get fragmentConstantOffset():Number
		{
			return this._fragmentConstantOffset;
		}
		
		public function set fragmentConstantOffset(value:Number):void
		{
            this._fragmentConstantOffset = value;
		}
		
		/**
		public function get fragmentOutputRegister():ShaderRegisterElement
		{
			return this._fragmentOutputRegister;
		}
		
		/**
		public function get numUsedVertexConstants():Number
		{
			return this._numUsedVertexConstants;
		}
		
		/**
		public function get numUsedFragmentConstants():Number
		{
			return this._numUsedFragmentConstants;
		}
		
		/**
		public function get numUsedStreams():Number
		{
			return this._numUsedStreams;
		}

		/**
		public function get numUsedTextures():Number
		{
			return this._numUsedTextures;
		}

		/**
		public function get numUsedVaryings():Number
		{
			return this._numUsedVaryings;
		}
	}
}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.compilation
{
	import away.materials.methods.ShaderMethodSetup;
	import away.materials.methods.MethodVOSet;
	import away.materials.methods.ShadingMethodBase;
	import away.materials.methods.MethodVO;
	import away.materials.LightSources;
	import away.materials.methods.EffectMethodBase;

	/**
	public class ShaderCompiler
	{
        public var _pSharedRegisters:ShaderRegisterData;// PROTECTED
        public var _pRegisterCache:ShaderRegisterCache;// PROTECTED
		public var _pDependencyCounter:MethodDependencyCounter;// PROTECTED
        public var _pMethodSetup:ShaderMethodSetup;// PROTECTED

		private var _smooth:Boolean = false;
		private var _repeat:Boolean = false;
		private var _mipmap:Boolean = false;
		public var _pEnableLightFallOff:Boolean = false;
		private var _preserveAlpha:Boolean = true;
		private var _animateUVs:Boolean = false;
		public var _pAlphaPremultiplied:Boolean = false;// PROTECTED
		private var _vertexConstantData:Vector.<Number>;
		private var _fragmentConstantData:Vector.<Number>;

		public var _pVertexCode:String = '';
        public var _pFragmentCode:String = '';
		private var _fragmentLightCode:String = null;
		private var _fragmentPostLightCode:String = null;
		private var _commonsDataIndex:Number = -1;

		public var _pAnimatableAttributes:Vector.<String>;// PROTECTED
		public var _pAnimationTargetRegisters:Vector.<String>;// PROTECTED

		public var _pLightProbeDiffuseIndices:Vector.<Number>;/*uint*/
        public var _pLightProbeSpecularIndices:Vector.<Number>;/*uint*/
		private var _uvBufferIndex:Number = -1;
		private var _uvTransformIndex:Number = -1;
		private var _secondaryUVBufferIndex:Number = -1;
		public var _pNormalBufferIndex:Number = -1;// PROTECTED
		public var _pTangentBufferIndex:Number = -1;// PROTECTED
		public var _pLightFragmentConstantIndex:Number = -1;//PROTECTED
		private var _sceneMatrixIndex:Number = -1;
		public var _pSceneNormalMatrixIndex:Number = -1;//PROTECTED
		public var _pCameraPositionIndex:Number = -1;// PROTECTED
		public var _pProbeWeightsIndex:Number = -1;// PROTECTED

		private var _specularLightSources:Number = 0;
		private var _diffuseLightSources:Number = 0;

		public var _pNumLights:Number = 0;// PROTECTED
		public var _pNumLightProbes:Number = 0;// PROTECTED
		public var _pNumPointLights:Number = 0;// PROTECTED
		public var _pNumDirectionalLights:Number = 0;// PROTECTED

		public var _pNumProbeRegisters:Number = 0;// PROTECTED
		private var _combinedLightSources:Number = 0;

		public var _usingSpecularMethod:Boolean = false;

		private var _needUVAnimation:Boolean = false;
		private var _UVTarget:String = null;
		private var _UVSource:String = null;

		public var _pProfile:String = null;

		private var _forceSeperateMVP:Boolean = false;

		/**
		public function ShaderCompiler(profile:String):void
		{
			this._pSharedRegisters = new ShaderRegisterData();
            this._pDependencyCounter = new MethodDependencyCounter();
            this._pProfile = profile;
            this.initRegisterCache(profile);
		}

		/**
		public function get enableLightFallOff():Boolean
		{
			return this._pEnableLightFallOff;
		}

		public function set enableLightFallOff(value:Boolean):void
		{
            this._pEnableLightFallOff = value;
		}

		/**
		public function get needUVAnimation():Boolean
		{
			return this._needUVAnimation;
		}

		/**
		public function get UVTarget():String
		{
			return this._UVTarget;
		}

		/**
		public function get UVSource():String
		{
			return this._UVSource;
		}

		/**
		public function get forceSeperateMVP():Boolean
		{
			return this._forceSeperateMVP;
		}

		public function set forceSeperateMVP(value:Boolean):void
		{
            this._forceSeperateMVP = value;
		}

		/**
		private function initRegisterCache(profile:String):void
		{
            this._pRegisterCache = new ShaderRegisterCache(profile);
            this._pRegisterCache.vertexAttributesOffset = 1;
            this._pRegisterCache.reset();
		}

		/**
		public function get animateUVs():Boolean
		{
			return this._animateUVs;
		}

		public function set animateUVs(value:Boolean):void
		{
            this._animateUVs = value;
		}

		/**
		public function get alphaPremultiplied():Boolean
		{
			return this._pAlphaPremultiplied;
		}

		public function set alphaPremultiplied(value:Boolean):void
		{
            this._pAlphaPremultiplied = value;
		}

		/**
		public function get preserveAlpha():Boolean
		{
			return this._preserveAlpha;
		}

		public function set preserveAlpha(value:Boolean):void
		{
            this._preserveAlpha = value;
		}

		/**
		public function setTextureSampling(smooth:Boolean, repeat:Boolean, mipmap:Boolean):void
		{
            this._smooth = smooth;
            this._repeat = repeat;
            this._mipmap = mipmap;
		}

		/**
		public function setConstantDataBuffers(vertexConstantData:Vector.<Number>, fragmentConstantData:Vector.<Number>):void
		{
            this._vertexConstantData = vertexConstantData;
            this._fragmentConstantData = fragmentConstantData;
		}

		/**
		public function get methodSetup():ShaderMethodSetup
		{
			return this._pMethodSetup;
		}

		public function set methodSetup(value:ShaderMethodSetup):void
		{
            this._pMethodSetup = value;
		}

		/**
		public function compile():void
		{
			this.pInitRegisterIndices();
			this.pInitLightData();

			this._pAnimatableAttributes = new <String>[ 'va0' ];//Vector.<String>(["va0"]);
            this._pAnimationTargetRegisters = new <String>[ 'vt0' ];//Vector.<String>(["vt0"]);
            this._pVertexCode = "";
            this._pFragmentCode = "";

            this._pSharedRegisters.localPosition = this._pRegisterCache.getFreeVertexVectorTemp();
            this._pRegisterCache.addVertexTempUsages( this._pSharedRegisters.localPosition, 1);

            this.createCommons();
            this.pCalculateDependencies();
            this.updateMethodRegisters();

			for (var i:Number = 0; i < 4; ++i)
                this._pRegisterCache.getFreeVertexConstant();

            this.pCreateNormalRegisters();

			if (this._pDependencyCounter.globalPosDependencies > 0 || this._forceSeperateMVP)
                this.pCompileGlobalPositionCode();

            this.compileProjectionCode();
            this.pCompileMethodsCode();
            this.compileFragmentOutput();
            this._fragmentPostLightCode = this.fragmentCode;
		}

		/**
		public function pCreateNormalRegisters():void
		{

		}

		/**
		public function pCompileMethodsCode():void
		{
			if (this._pDependencyCounter.uvDependencies > 0)
                this.compileUVCode();

			if (this._pDependencyCounter.secondaryUVDependencies > 0)
                this.compileSecondaryUVCode();

			if (this._pDependencyCounter.normalDependencies > 0)
                this.pCompileNormalCode();

			if (this._pDependencyCounter.viewDirDependencies > 0)
                this.pCompileViewDirCode();

            this.pCompileLightingCode();
            this._fragmentLightCode = this._pFragmentCode;
            this._pFragmentCode = "";
            this.pCompileMethods();
		}

		/**
		public function pCompileLightingCode():void
		{

		}

		/**
		public function pCompileViewDirCode():void
		{

		}

		/**
		public function pCompileNormalCode():void
		{

		}

		/**
		private function compileUVCode():void
		{
			var uvAttributeReg:ShaderRegisterElement = this._pRegisterCache.getFreeVertexAttribute();
			this._uvBufferIndex = uvAttributeReg.index;

			var varying:ShaderRegisterElement = this._pRegisterCache.getFreeVarying();

			this._pSharedRegisters.uvVarying = varying;

			if (this.animateUVs)
            {

				// a, b, 0, tx
				// c, d, 0, ty
				var uvTransform1:ShaderRegisterElement = this._pRegisterCache.getFreeVertexConstant();
				var uvTransform2:ShaderRegisterElement = this._pRegisterCache.getFreeVertexConstant();
                this._uvTransformIndex = uvTransform1.index*4;

                // TODO: AGAL <> GLSL

                this._pVertexCode += "dp4 " + varying.toString() + ".x, " + uvAttributeReg.toString() + ", " + uvTransform1.toString() + "\n" +
					"dp4 " + varying.toString() + ".y, " + uvAttributeReg.toString() + ", " + uvTransform2.toString() + "\n" +
					"mov " + varying.toString() + ".zw, " + uvAttributeReg.toString() + ".zw \n";

			}
            else
            {

				this._uvTransformIndex = -1;
                this._needUVAnimation = true;
                this._UVTarget = varying.toString();
                this._UVSource = uvAttributeReg.toString();

			}
		}

		/**
		private function compileSecondaryUVCode():void
		{
            // TODO: AGAL <> GLSL

			var uvAttributeReg:ShaderRegisterElement = this._pRegisterCache.getFreeVertexAttribute();
            this._secondaryUVBufferIndex = uvAttributeReg.index;
            this._pSharedRegisters.secondaryUVVarying = this._pRegisterCache.getFreeVarying();
            this._pVertexCode += "mov " + this._pSharedRegisters.secondaryUVVarying.toString() + ", " + uvAttributeReg.toString() + "\n";
		}

		/**
		public function pCompileGlobalPositionCode():void
		{

            // TODO: AGAL <> GLSL

			this._pSharedRegisters.globalPositionVertex = this._pRegisterCache.getFreeVertexVectorTemp();
            this._pRegisterCache.addVertexTempUsages(this._pSharedRegisters.globalPositionVertex, this._pDependencyCounter.globalPosDependencies);
			var positionMatrixReg:ShaderRegisterElement = this._pRegisterCache.getFreeVertexConstant();
            this._pRegisterCache.getFreeVertexConstant();
            this._pRegisterCache.getFreeVertexConstant();
            this._pRegisterCache.getFreeVertexConstant();
            this._sceneMatrixIndex = positionMatrixReg.index*4;

            this._pVertexCode += "m44 " + this._pSharedRegisters.globalPositionVertex.toString() + ", " + this._pSharedRegisters.localPosition.toString() + ", " + positionMatrixReg.toString() + "\n";

			if (this._pDependencyCounter.usesGlobalPosFragment)
            {

                this._pSharedRegisters.globalPositionVarying = this._pRegisterCache.getFreeVarying();
                this._pVertexCode += "mov " + this._pSharedRegisters.globalPositionVarying.toString() + ", " + this._pSharedRegisters.globalPositionVertex.toString() + "\n";

			}
		}

		/**
		private function compileProjectionCode():void
		{
			var pos:String = this._pDependencyCounter.globalPosDependencies > 0 || this._forceSeperateMVP? this._pSharedRegisters.globalPositionVertex.toString() : this._pAnimationTargetRegisters[0];
			var code:String;

            // TODO: AGAL <> GLSL

			if (this._pDependencyCounter.projectionDependencies > 0)
            {

                this._pSharedRegisters.projectionFragment = this._pRegisterCache.getFreeVarying();

				code = "m44 vt5, " + pos + ", vc0		\n" +
					"mov " + this._pSharedRegisters.projectionFragment.toString() + ", vt5\n" +
					"mov op, vt5\n";
			}
            else
            {

                code = "m44 op, " + pos + ", vc0		\n";

            }


            this._pVertexCode += code;

		}

		/**
		private function compileFragmentOutput():void
		{
            // TODO: AGAL <> GLSL

			this._pFragmentCode += "mov " + this._pRegisterCache.fragmentOutputRegister.toString() + ", " + this._pSharedRegisters.shadedTarget.toString() + "\n";
            this._pRegisterCache.removeFragmentTempUsage(this._pSharedRegisters.shadedTarget);
		}

		/**
		public function pInitRegisterIndices():void
		{
			this._commonsDataIndex = -1;
            this._pCameraPositionIndex = -1;
            this._uvBufferIndex = -1;
            this._uvTransformIndex = -1;
            this._secondaryUVBufferIndex = -1;
            this._pNormalBufferIndex = -1;
            this._pTangentBufferIndex = -1;
            this._pLightFragmentConstantIndex = -1;
            this._sceneMatrixIndex = -1;
            this._pSceneNormalMatrixIndex = -1;
            this._pProbeWeightsIndex = -1;

		}

		/**
		public function pInitLightData():void
		{
            this._pNumLights = this._pNumPointLights + this._pNumDirectionalLights;
            this._pNumProbeRegisters = Math.ceil(this._pNumLightProbes/4);


			if (this._pMethodSetup._iSpecularMethod)
            {

                this._combinedLightSources = this._specularLightSources | this._diffuseLightSources;

            }
			else
            {

                this._combinedLightSources = this._diffuseLightSources;

            }

            this._usingSpecularMethod = Boolean(this._pMethodSetup._iSpecularMethod && (
                this.pUsesLightsForSpecular() ||
                this.pUsesProbesForSpecular()));

		}

		/**
		private function createCommons():void
		{
			this._pSharedRegisters.commons = this._pRegisterCache.getFreeFragmentConstant();
            this._commonsDataIndex = this._pSharedRegisters.commons.index*4;
		}

		/**
		public function pCalculateDependencies():void
		{
            this._pDependencyCounter.reset();



			var methods:Vector.<MethodVOSet> = this._pMethodSetup._iMethods;//Vector.<MethodVOSet>
			var len:Number;

			this.setupAndCountMethodDependencies(this._pMethodSetup._iDiffuseMethod, this._pMethodSetup._iDiffuseMethodVO);


			if (this._pMethodSetup._iShadowMethod)
				this.setupAndCountMethodDependencies(this._pMethodSetup._iShadowMethod, this._pMethodSetup._iShadowMethodVO);


			this.setupAndCountMethodDependencies(this._pMethodSetup._iAmbientMethod, this._pMethodSetup._iAmbientMethodVO);

			if (this._usingSpecularMethod)
				this.setupAndCountMethodDependencies(this._pMethodSetup._iSpecularMethod, this._pMethodSetup._iSpecularMethodVO);

			if (this._pMethodSetup._iColorTransformMethod)
				this.setupAndCountMethodDependencies(this._pMethodSetup._iColorTransformMethod, this._pMethodSetup._iColorTransformMethodVO);

			len = methods.length;

			for (var i:Number = 0; i < len; ++i)
				this.setupAndCountMethodDependencies(methods[i].method, methods[i].data);

			if (this.usesNormals)
				this.setupAndCountMethodDependencies(this._pMethodSetup._iNormalMethod, this._pMethodSetup._iNormalMethodVO);

			// todo: add spotlights to count check
			this._pDependencyCounter.setPositionedLights(this._pNumPointLights, this._combinedLightSources);

		}

		/**
		private function setupAndCountMethodDependencies(method:ShadingMethodBase, methodVO:MethodVO):void
		{
			this.setupMethod(method, methodVO);
			this._pDependencyCounter.includeMethodVO(methodVO);
		}

		/**
		private function setupMethod(method:ShadingMethodBase, methodVO:MethodVO):void
		{
			method.iReset();
			methodVO.reset();

			methodVO.vertexData = this._vertexConstantData;
			methodVO.fragmentData = this._fragmentConstantData;
			methodVO.useSmoothTextures = this._smooth;
			methodVO.repeatTextures = this._repeat;
			methodVO.useMipmapping = this._mipmap;
			methodVO.useLightFallOff = this._pEnableLightFallOff && this._pProfile != "baselineConstrained";
			methodVO.numLights = this._pNumLights + this._pNumLightProbes;

			method.iInitVO(methodVO);
		}

		/**
		public function get commonsDataIndex():Number
		{
			return this._commonsDataIndex;
		}

		/**
		private function updateMethodRegisters():void
		{
			this._pMethodSetup._iNormalMethod.iSharedRegisters= this._pSharedRegisters;
            this._pMethodSetup._iDiffuseMethod.iSharedRegisters = this._pSharedRegisters;

			if (this._pMethodSetup._iShadowMethod)
                this._pMethodSetup._iShadowMethod.iSharedRegisters = this._pSharedRegisters;

            this._pMethodSetup._iAmbientMethod.iSharedRegisters = this._pSharedRegisters;

			if (this._pMethodSetup._iSpecularMethod)
                this._pMethodSetup._iSpecularMethod.iSharedRegisters = this._pSharedRegisters;

			if (this._pMethodSetup._iColorTransformMethod)
                this._pMethodSetup._iColorTransformMethod.iSharedRegisters = this._pSharedRegisters;


            var methods : Vector.<MethodVOSet> = this._pMethodSetup._iMethods;//var methods:Vector.<MethodVOSet> = _pMethodSetup._methods;

			var len:Number = methods.length;

			for (var i:Number = 0; i < len; ++i)
            {

                methods[i].method.iSharedRegisters = this._pSharedRegisters;

            }


		}

		/**
		public function get numUsedVertexConstants():Number
		{
			return this._pRegisterCache.numUsedVertexConstants;
		}

		/**
		public function get numUsedFragmentConstants():Number
		{
			return this._pRegisterCache.numUsedFragmentConstants;
		}

		/**
		public function get numUsedStreams():Number
		{
			return this._pRegisterCache.numUsedStreams;
		}

		/**
		public function get numUsedTextures():Number
		{
			return this._pRegisterCache.numUsedTextures;
		}

		/**
		public function get numUsedVaryings():Number
		{
			return this._pRegisterCache.numUsedVaryings;
		}

		/**
		public function pUsesLightsForSpecular():Boolean
		{
			return this._pNumLights > 0 && ( this._specularLightSources & LightSources.LIGHTS) != 0;
		}

		/**
		public function pUsesLightsForDiffuse():Boolean
		{
			return this._pNumLights > 0 && ( this._diffuseLightSources & LightSources.LIGHTS) != 0;
		}

		/**
		public function dispose():void
		{
			this.cleanUpMethods();
			this._pRegisterCache.dispose();
			this._pRegisterCache = null;
			this._pSharedRegisters = null;
		}

		/**
		private function cleanUpMethods():void
		{
			if (this._pMethodSetup._iNormalMethod)
                this._pMethodSetup._iNormalMethod.iCleanCompilationData();

			if (this._pMethodSetup._iDiffuseMethod)
                this._pMethodSetup._iDiffuseMethod.iCleanCompilationData();

			if (this._pMethodSetup._iAmbientMethod)
                this._pMethodSetup._iAmbientMethod.iCleanCompilationData();

			if (this._pMethodSetup._iSpecularMethod)
                this._pMethodSetup._iSpecularMethod.iCleanCompilationData();

			if (this._pMethodSetup._iShadowMethod)
                this._pMethodSetup._iShadowMethod.iCleanCompilationData();

			if (this._pMethodSetup._iColorTransformMethod)
                this._pMethodSetup._iColorTransformMethod.iCleanCompilationData();

            var methods:Vector.<MethodVOSet>= this._pMethodSetup._iMethods;//var methods:Vector.<MethodVOSet> = _pMethodSetup._methods;

			var len:Number = methods.length;

			for (var i:Number = 0; i < len; ++i)
            {

                methods[i].method.iCleanCompilationData();

            }

		}

		/**
		public function get specularLightSources():Number
		{
			return this._specularLightSources;
		}

		public function set specularLightSources(value:Number):void
		{
            this._specularLightSources = value;
		}

		/**
		public function get diffuseLightSources():Number
		{
			return this._diffuseLightSources;
		}

		public function set diffuseLightSources(value:Number):void
		{
			this._diffuseLightSources = value;
		}

		/**
		public function pUsesProbesForSpecular():Boolean
		{
			return this._pNumLightProbes > 0 && (this._specularLightSources & LightSources.PROBES) != 0;
		}

		/**
		public function pUsesProbesForDiffuse():Boolean
		{
			return this._pNumLightProbes > 0 && (this._diffuseLightSources & LightSources.PROBES) != 0;
		}

		/**
		public function pUsesProbes():Boolean
		{
			return this._pNumLightProbes > 0 && ((this._diffuseLightSources | this._specularLightSources) & LightSources.PROBES) != 0;
		}

		/**
		public function get uvBufferIndex():Number
		{
			return this._uvBufferIndex;
		}

		/**
		public function get uvTransformIndex():Number
		{
			return this._uvTransformIndex;
		}

		/**
		public function get secondaryUVBufferIndex():Number
		{
			return this._secondaryUVBufferIndex;
		}

		/**
		public function get normalBufferIndex():Number
		{
			return this._pNormalBufferIndex;
		}

		/**
		public function get tangentBufferIndex():Number
		{
			return this._pTangentBufferIndex;
		}

		/**
		public function get lightFragmentConstantIndex():Number
		{
			return this._pLightFragmentConstantIndex;
		}

		/**
		public function get cameraPositionIndex():Number
		{
			return this._pCameraPositionIndex;
		}

		/**
		public function get sceneMatrixIndex():Number
		{
			return this._sceneMatrixIndex;
		}

		/**
		public function get sceneNormalMatrixIndex():Number
		{
			return this._pSceneNormalMatrixIndex;
		}

		/**
		public function get probeWeightsIndex():Number
		{
			return this._pProbeWeightsIndex;
		}

		/**
		public function get vertexCode():String
		{
			return this._pVertexCode;
		}

		/**
		public function get fragmentCode():String
		{
			return this._pFragmentCode;
		}

		/**
		public function get fragmentLightCode():String
		{
			return this._fragmentLightCode;
		}

		/**
		public function get fragmentPostLightCode():String
		{
			return this._fragmentPostLightCode;
		}

		/**
		public function get shadedTarget():String
		{
			return this._pSharedRegisters.shadedTarget.toString();
		}

		/**
		public function get numPointLights():Number
		{
			return this._pNumPointLights;
		}

		public function set numPointLights(numPointLights:Number):void
		{
            this._pNumPointLights = numPointLights;
		}

		/**
		public function get numDirectionalLights():Number
		{
			return this._pNumDirectionalLights;
		}

		public function set numDirectionalLights(value:Number):void
		{
            this._pNumDirectionalLights = value;
		}

		/**
		public function get numLightProbes():Number
		{
			return this._pNumLightProbes;
		}

		public function set numLightProbes(value:Number):void
		{
            this._pNumLightProbes = value;
		}

		/**
		public function get usingSpecularMethod():Boolean
		{
			return this._usingSpecularMethod;
		}

		/**
		public function get animatableAttributes():Vector.<String>
		{
			return this._pAnimatableAttributes;
		}

		/**
		public function get animationTargetRegisters():Vector.<String>
		{
			return this._pAnimationTargetRegisters;
		}

		/**
		public function get usesNormals():Boolean
		{
			return this._pDependencyCounter.normalDependencies > 0 && this._pMethodSetup._iNormalMethod.iHasOutput;
		}

		/**
		public function pUsesLights():Boolean
		{
			return this._pNumLights > 0 && (this._combinedLightSources & LightSources.LIGHTS) != 0;
		}

		/**
		public function pCompileMethods():void
		{
            var methods:Vector.<MethodVOSet> = this._pMethodSetup._iMethods;//var methods:Vector.<MethodVOSet> = this._pMethodSetup._iMethods;

			var numMethods:Number = methods.length;
			var method:EffectMethodBase;
			var data:MethodVO;
			var alphaReg:ShaderRegisterElement;

            // TODO: AGAL <> GLSL

			if (this._preserveAlpha)
            {
				alphaReg = this._pRegisterCache.getFreeFragmentSingleTemp();
                this._pRegisterCache.addFragmentTempUsages(alphaReg, 1);
                this._pFragmentCode += "mov " + alphaReg.toString() + ", " + this._pSharedRegisters.shadedTarget.toString() + ".w\n";
			}

			for (var i:Number = 0; i < numMethods; ++i)
            {

				method = methods[i].method;
				data = methods[i].data;

				this._pVertexCode += method.iGetVertexCode( data, this._pRegisterCache);

				if (data.needsGlobalVertexPos || data.needsGlobalFragmentPos)
                    this._pRegisterCache.removeVertexTempUsage(this._pSharedRegisters.globalPositionVertex);

                this._pFragmentCode += method.iGetFragmentCode(data, this._pRegisterCache, this._pSharedRegisters.shadedTarget);

				if (data.needsNormals)
					this._pRegisterCache.removeFragmentTempUsage(this._pSharedRegisters.normalFragment);

				if (data.needsView)
                    this._pRegisterCache.removeFragmentTempUsage(this._pSharedRegisters.viewDirFragment);
			}

			if (this._preserveAlpha)
            {

                this._pFragmentCode += "mov " + this._pSharedRegisters.shadedTarget.toString() + ".w, " + alphaReg.toString() + "\n";

                this._pRegisterCache.removeFragmentTempUsage(alphaReg);

			}

			if (this._pMethodSetup._iColorTransformMethod)
            {

                this._pVertexCode += this._pMethodSetup._iColorTransformMethod.iGetVertexCode(this._pMethodSetup._iColorTransformMethodVO, this._pRegisterCache);
                this._pFragmentCode += this._pMethodSetup._iColorTransformMethod.iGetFragmentCode(this._pMethodSetup._iColorTransformMethodVO, this._pRegisterCache, this._pSharedRegisters.shadedTarget);

			}
		}

		/**
		public function get lightProbeDiffuseIndices():Vector.<Number> /*uint*/		{
			return this._pLightProbeDiffuseIndices;
		}

		/**
		public function get lightProbeSpecularIndices():Vector.<Number> /*uint*/		{
			return this._pLightProbeSpecularIndices;
		}
	}
}
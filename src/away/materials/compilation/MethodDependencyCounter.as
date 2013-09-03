///<reference path="../../_definitions.ts"/>
package away.materials.compilation
{
	import away.materials.methods.MethodVO;
	import away.materials.LightSources;
	//import away3d.materials.LightSources;
	//import away3d.materials.methods.MethodVO;

	/**
	public class MethodDependencyCounter
	{
		private var _projectionDependencies:Number;
		private var _normalDependencies:Number;
		private var _viewDirDependencies:Number;
		private var _uvDependencies:Number;
		private var _secondaryUVDependencies:Number;
		private var _globalPosDependencies:Number;
		private var _tangentDependencies:Number;
		private var _usesGlobalPosFragment:Boolean = false;
		private var _numPointLights:Number;
		private var _lightSourceMask:Number;

		/**
		public function MethodDependencyCounter():void
		{
		}

		/**
		public function reset():void
		{
			_projectionDependencies = 0;
            _normalDependencies = 0;
            _viewDirDependencies = 0;
            _uvDependencies = 0;
            _secondaryUVDependencies = 0;
            _globalPosDependencies = 0;
            _tangentDependencies = 0;
            _usesGlobalPosFragment = false;
		}

		/**
		public function setPositionedLights(numPointLights:Number, lightSourceMask:Number):void
		{
            _numPointLights = numPointLights;
            _lightSourceMask = lightSourceMask;
		}

		/**
		public function includeMethodVO(methodVO:MethodVO):void
		{
			if (methodVO.needsProjection){

                ++_projectionDependencies;

            }

			if (methodVO.needsGlobalVertexPos)
            {

				++_globalPosDependencies;

				if (methodVO.needsGlobalFragmentPos)
                {

                    _usesGlobalPosFragment = true;

                }

			}
            else if (methodVO.needsGlobalFragmentPos)
            {

				++_globalPosDependencies;
                _usesGlobalPosFragment = true;

			}

			if (methodVO.needsNormals)
            {

                ++_normalDependencies;

            }

			if (methodVO.needsTangents)
            {

                ++_tangentDependencies;

            }

			if (methodVO.needsView)
            {

                ++_viewDirDependencies;

            }

			if (methodVO.needsUV)
            {

                ++_uvDependencies;

            }

			if (methodVO.needsSecondaryUV)
            {

                ++_secondaryUVDependencies;

            }

		}

		/**
		public function get tangentDependencies():Number
		{
			return _tangentDependencies;
		}

		/**
		public function get usesGlobalPosFragment():Boolean
		{
			return _usesGlobalPosFragment;
		}

		/**
		public function get projectionDependencies():Number
		{
			return _projectionDependencies;
		}

		/**
		public function get normalDependencies():Number
		{
			return _normalDependencies;
		}

		/**
		public function get viewDirDependencies():Number
		{
			return _viewDirDependencies;
		}

		/**
		public function get uvDependencies():Number
		{
			return _uvDependencies;
		}

		/**
		public function get secondaryUVDependencies():Number
		{
			return _secondaryUVDependencies;
		}

		/**
		public function get globalPosDependencies():Number
		{
			return _globalPosDependencies;
		}

		/**
		public function addWorldSpaceDependencies(fragmentLights:Boolean):void
		{
			if (_viewDirDependencies > 0)
            {

                ++_globalPosDependencies;

            }

			
			if (_numPointLights > 0 && (_lightSourceMask & LightSources.LIGHTS))
            {
				++_globalPosDependencies;

				if (fragmentLights)
                {

                    _usesGlobalPosFragment = true;

                }

			}
		}
	}
}
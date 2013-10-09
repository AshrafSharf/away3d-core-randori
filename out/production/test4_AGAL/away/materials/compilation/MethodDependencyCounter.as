/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.compilation
{
	import away.materials.methods.MethodVO;
	import away.materials.LightSources;
	//import away3d.materials.LightSources;
	//import away3d.materials.methods.MethodVO;

	/**
	public class MethodDependencyCounter
	{
		private var _projectionDependencies:Number = 0;
		private var _normalDependencies:Number = 0;
		private var _viewDirDependencies:Number = 0;
		private var _uvDependencies:Number = 0;
		private var _secondaryUVDependencies:Number = 0;
		private var _globalPosDependencies:Number = 0;
		private var _tangentDependencies:Number = 0;
		private var _usesGlobalPosFragment:Boolean = false;
		private var _numPointLights:Number = 0;
		private var _lightSourceMask:Number = 0;

		/**
		public function MethodDependencyCounter():void
		{
		}

		/**
		public function reset():void
		{
			this._projectionDependencies = 0;
            this._normalDependencies = 0;
            this._viewDirDependencies = 0;
            this._uvDependencies = 0;
            this._secondaryUVDependencies = 0;
            this._globalPosDependencies = 0;
            this._tangentDependencies = 0;
            this._usesGlobalPosFragment = false;
		}

		/**
		public function setPositionedLights(numPointLights:Number, lightSourceMask:Number):void
		{
            this._numPointLights = numPointLights;
            this._lightSourceMask = lightSourceMask;
		}

		/**
		public function includeMethodVO(methodVO:MethodVO):void
		{
			if (methodVO.needsProjection){

                ++this._projectionDependencies;

            }

			if (methodVO.needsGlobalVertexPos)
            {

				++this._globalPosDependencies;

				if (methodVO.needsGlobalFragmentPos)
                {

                    this._usesGlobalPosFragment = true;

                }

			}
            else if (methodVO.needsGlobalFragmentPos)
            {

				++this._globalPosDependencies;
                this._usesGlobalPosFragment = true;

			}

			if (methodVO.needsNormals)
            {

                ++this._normalDependencies;

            }

			if (methodVO.needsTangents)
            {

                ++this._tangentDependencies;

            }

			if (methodVO.needsView)
            {

                ++this._viewDirDependencies;

            }

			if (methodVO.needsUV)
            {

                ++this._uvDependencies;

            }

			if (methodVO.needsSecondaryUV)
            {

                ++this._secondaryUVDependencies;

            }

		}

		/**
		public function get tangentDependencies():Number
		{
			return this._tangentDependencies;
		}

		/**
		public function get usesGlobalPosFragment():Boolean
		{
			return this._usesGlobalPosFragment;
		}

		/**
		public function get projectionDependencies():Number
		{
			return this._projectionDependencies;
		}

		/**
		public function get normalDependencies():Number
		{
			return this._normalDependencies;
		}

		/**
		public function get viewDirDependencies():Number
		{
			return this._viewDirDependencies;
		}

		/**
		public function get uvDependencies():Number
		{
			return this._uvDependencies;
		}

		/**
		public function get secondaryUVDependencies():Number
		{
			return this._secondaryUVDependencies;
		}

		/**
		public function get globalPosDependencies():Number
		{
			return this._globalPosDependencies;
		}

		/**
		public function addWorldSpaceDependencies(fragmentLights:Boolean):void
		{
			if (this._viewDirDependencies > 0)
            {

                ++this._globalPosDependencies;

            }

			
			if (this._numPointLights > 0 && (this._lightSourceMask & LightSources.LIGHTS))
            {
				++this._globalPosDependencies;

				if (fragmentLights)
                {

                    this._usesGlobalPosFragment = true;

                }

			}
		}
	}
}
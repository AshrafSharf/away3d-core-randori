///<reference path="../_definitions.ts"/>
package away.base
{
	import away.materials.MaterialBase;
	import away.entities.Mesh;
	import away.geom.Matrix;
	import away.entities.Entity;
	import away.geom.Matrix3D;
	import away.managers.Stage3DProxy;
	import away.display3D.IndexBuffer3D;
	import away.animators.IAnimator;
	import away.bounds.BoundingVolumeBase;
	import away.cameras.Camera3D;

	/**
	public class SubMesh implements IRenderable
	{
		public var _iMaterial:MaterialBase;
		private var _parentMesh:Mesh;
		private var _subGeometry:ISubGeometry;
		public var _iIndex:Number = 0;
		private var _uvTransform:Matrix;
		private var _uvTransformDirty:Boolean;
		private var _uvRotation:Number = 0;
		private var _scaleU:Number = 1;
		private var _scaleV:Number = 1;
		private var _offsetU:Number = 0;
		private var _offsetV:Number = 0;
		
		//public animationSubGeometry:AnimationSubGeometry;// TODO: implement dependencies AnimationSubGeometry
		//public animatorSubGeometry:AnimationSubGeometry;// TODO: implement dependencies AnimationSubGeometry
		
		/**
		public function SubMesh(subGeometry:ISubGeometry, parentMesh:Mesh, material:MaterialBase = null):void
		{
			this._parentMesh = parentMesh;
            this._subGeometry = subGeometry;
			this.material = material;
		}
		
		public function get shaderPickingDetails():Boolean
		{

			return sourceEntity.shaderPickingDetails;
		}
		
		public function get offsetU():Number
		{
			return _offsetU;
		}
		
		public function set offsetU(value:Number):void
		{
			if (value == this._offsetU)
            {

                return;

            }

			this._offsetU = value;
            this._uvTransformDirty = true;
		}
		
		public function get offsetV():Number
		{
			return _offsetV;
		}
		
		public function set offsetV(value:Number):void
		{
			if (value == this._offsetV)
            {

                return;

            }

			this._offsetV = value;
            this._uvTransformDirty = true;

		}
		
		public function get scaleU():Number
		{
			return _scaleU;
		}
		
		public function set scaleU(value:Number):void
		{
			if (value == this._scaleU)
            {

                return;

            }

            this._scaleU = value;
            this._uvTransformDirty = true;
		}
		
		public function get scaleV():Number
		{
			return _scaleV;
		}
		
		public function set scaleV(value:Number):void
		{
			if (value ==this._scaleV)
            {

                return;

            }

			this._scaleV = value;
            this._uvTransformDirty = true;
		}
		
		public function get uvRotation():Number
		{
			return _uvRotation;
		}
		
		public function set uvRotation(value:Number):void
		{
			if (value == this._uvRotation)
            {

                return;

            }

			this._uvRotation = value;
            this._uvTransformDirty = true;
		}
		
		/**
		public function get sourceEntity():Entity
		{
			return _parentMesh;
		}
		
		/**
		public function get subGeometry():ISubGeometry
		{
			return _subGeometry;
		}
		
		public function set subGeometry(value:ISubGeometry):void
		{
            this._subGeometry = value;
		}
		
		/**
		public function get material():MaterialBase
		{
			return _iMaterial || _parentMesh.material;
		}
		
		public function set material(value:MaterialBase):void
		{

            //away.Debug.throwPIR( 'away.base.Submesh' , 'set material' , 'away.base.MaterialBase _iRemoveOwner , _iAddOwner');
            //*
			if (this._iMaterial)
            {

                this._iMaterial.iRemoveOwner(this);

            }

			this._iMaterial = value;
			
			if (this._iMaterial)
            {

                this._iMaterial.iAddOwner(this);

            }
            //*/
		}
		
		/**
		public function get sceneTransform():Matrix3D
		{
			return _parentMesh.sceneTransform;
		}
		
		/**
		public function get inverseSceneTransform():Matrix3D
		{
			return _parentMesh.inverseSceneTransform;
		}
		
		/**
		public function activateVertexBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
			_subGeometry.activateVertexBuffer(index, stage3DProxy);
		}
		
		/**
		public function activateVertexNormalBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
			_subGeometry.activateVertexNormalBuffer(index, stage3DProxy);
		}
		
		/**
		public function activateVertexTangentBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
			_subGeometry.activateVertexTangentBuffer(index, stage3DProxy);
		}
		
		/**
		public function activateUVBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
			_subGeometry.activateUVBuffer(index, stage3DProxy);
		}
		
		/**
		public function activateSecondaryUVBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
            _subGeometry.activateSecondaryUVBuffer(index, stage3DProxy);
		}
		
		/**
		public function getIndexBuffer(stage3DProxy:Stage3DProxy):IndexBuffer3D
		{
			return _subGeometry.getIndexBuffer(stage3DProxy);
		}
		
		/**
		public function get numTriangles():Number
		{
			return _subGeometry.numTriangles;
		}
		
		/**
		public function get animator():IAnimator
		{

			return _parentMesh.animator;

		}
		/**
		public function get mouseEnabled():Boolean
		{


			return _parentMesh.mouseEnabled || _parentMesh._iAncestorsAllowMouseEnabled;//this._parentMesh._ancestorsAllowMouseEnabled;
		}
		
		public function get castsShadows():Boolean
		{
			return _parentMesh.castsShadows;
		}
		
		/**
		public function get iParentMesh():Mesh
		{
			return _parentMesh;
		}
		
		public function set iParentMesh(value:Mesh):void
		{
            this._parentMesh = value;
		}
		
		public function get uvTransform():Matrix
		{
			if (_uvTransformDirty)
            {

                updateUVTransform();

            }

			return _uvTransform;
		}
		
		private function updateUVTransform():void
		{
            if ( _uvTransform  == null )
            {

                _uvTransform = new Matrix();
                //_uvTransform ||= new Matrix();

            }

			_uvTransform.identity();

			if (_uvRotation != 0)
            {

                _uvTransform.rotate(_uvRotation);

            }

			if (_scaleU != 1 || _scaleV != 1)
            {

                _uvTransform.scale(_scaleU, _scaleV);

            }

            _uvTransform.translate(_offsetU, _offsetV);
            _uvTransformDirty = false;
		}
		
		public function dispose():void
		{
            material = null;
		}
		
		public function get vertexData():Vector.<Number>
		{
			return _subGeometry.vertexData;
		}
		
		public function get indexData():Vector.<Number> /*uint*/		{
			return _subGeometry.indexData;
		}
		
		public function get UVData():Vector.<Number>
		{
			return _subGeometry.UVData;
		}
		
		public function get bounds():BoundingVolumeBase
		{
			return _parentMesh.getBounds(); // TODO: return smaller, sub mesh bounds instead
		}
		
		public function get visible():Boolean
		{
			return _parentMesh.visible;
		}
		
		public function get numVertices():Number
		{
			return _subGeometry.numVertices;
		}
		
		public function get vertexStride():Number
		{
			return _subGeometry.vertexStride;
		}
		
		public function get UVStride():Number
		{
			return _subGeometry.UVStride;
		}
		
		public function get vertexNormalData():Vector.<Number>
		{
			return _subGeometry.vertexNormalData;
		}
		
		public function get vertexTangentData():Vector.<Number>
		{
			return _subGeometry.vertexTangentData;
		}
		
		public function get UVOffset():Number
		{
			return _subGeometry.UVOffset;
		}
		
		public function get vertexOffset():Number
		{
			return _subGeometry.vertexOffset;
		}
		
		public function get vertexNormalOffset():Number
		{
			return _subGeometry.vertexNormalOffset;
		}
		
		public function get vertexTangentOffset():Number
		{
			return _subGeometry.vertexTangentOffset;
		}
		
		public function getRenderSceneTransform(camera:Camera3D):Matrix3D
		{
			return _parentMesh.sceneTransform;
		}
	}
}
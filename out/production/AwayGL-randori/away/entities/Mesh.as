/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.entities
{
	import away.core.base.IMaterialOwner;
	import away.core.base.SubMesh;
	import away.core.base.Geometry;
	import away.materials.MaterialBase;
	import away.animators.IAnimator;
	import away.materials.utils.DefaultMaterialManager;
	import away.library.assets.AssetType;
	import away.events.GeometryEvent;
	import away.utils.Debug;
	import away.core.base.ISubGeometry;
	import away.core.base.Object3D;
	import away.containers.ObjectContainer3D;
	import away.core.partition.EntityNode;
	import away.core.partition.MeshNode;
	import away.core.base.SubGeometry;
	//import away3d.materials.utils.DefaultMaterialManager;
	//import away3d.animators.IAnimator;
	//import away3d.arcane;
	//import away3d.containers.*;
	//import away3d.core.base.*;
	//import away3d.core.partition.*;
	//import away3d.events.*;
	//import away3d.library.assets.*;
	//import away3d.materials.*;
	
	//use namespace arcane;
	
	/**
	public class Mesh extends Entity implements IMaterialOwner
	{
		private var _subMeshes:Vector.<SubMesh>;//:Vector.<SubMesh>
		private var _geometry:Geometry;//Geometry
		private var _material:MaterialBase;
		private var _animator:IAnimator;
		private var _castsShadows:Boolean = true;
		private var _shareAnimationGeometry:Boolean = true;
		
		/**
		public function Mesh(geometry:Geometry, material:MaterialBase = null):void
		{
			material = material || null;

			super();

			this._subMeshes = new Vector.<SubMesh>();//Vector.<SubMesh>();

            //this.geometry = geometry || new Geometry(); //this should never happen, but if people insist on trying to create their meshes before they have geometry to fill it, it becomes necessary
            if ( geometry == null )
            {
                this.geometry = new Geometry();
            }
            else
            {
                this.geometry = geometry;
            }

			if ( material == null)
            {
                this.material = DefaultMaterialManager.getDefaultMaterial(this);
            }
            else
            {
                this.material = material;
            }

		}
		
		public function bakeTransformations():void
		{
			this.geometry.applyTransformation(this.transform);
            this.transform.identity();
		}
		
		override public function get assetType():String
		{
			return AssetType.MESH;
		}
		
		private function onGeometryBoundsInvalid(event:GeometryEvent):void
		{
            this.pInvalidateBounds();//this.invalidateBounds();

		}
		
		/**
		public function get castsShadows():Boolean
		{
			return this._castsShadows;
		}
		
		public function set castsShadows(value:Boolean):void
		{
            this._castsShadows = value;
		}
		
		/**


		public function get animator():IAnimator
		{
			return this._animator;
		}


		public function set animator(value:IAnimator):void
		{

            Debug.throwPIR('Mesh' , 'set animator' , 'Partial Implementation')
            /*
		}

		/**
		public function get geometry():Geometry
		{
			return this._geometry;
		}
		
		public function set geometry(value:Geometry):void
		{
			var i:Number;

			if (this._geometry)
            {

                this._geometry.removeEventListener(GeometryEvent.BOUNDS_INVALID, onGeometryBoundsInvalid , this);
                this._geometry.removeEventListener(GeometryEvent.SUB_GEOMETRY_ADDED, onSubGeometryAdded, this);
                this._geometry.removeEventListener(GeometryEvent.SUB_GEOMETRY_REMOVED, onSubGeometryRemoved, this);
				
				for (i = 0; i < this._subMeshes.length; ++i)
                {

                    this._subMeshes[i].dispose();
                }

				this._subMeshes.length = 0;

			}
			
			this._geometry = value;

			if (this._geometry)
            {

				this._geometry.addEventListener(GeometryEvent.BOUNDS_INVALID, onGeometryBoundsInvalid , this );
                this._geometry.addEventListener(GeometryEvent.SUB_GEOMETRY_ADDED, onSubGeometryAdded , this );
                this._geometry.addEventListener(GeometryEvent.SUB_GEOMETRY_REMOVED, onSubGeometryRemoved , this );

                //var subGeoms:Vector.<ISubGeometry> = _geometry.subGeometries;
                var subGeoms:Vector.<ISubGeometry> = this._geometry.subGeometries;//
				
				for (i = 0; i < subGeoms.length; ++i)
                {

                    this.addSubMesh(subGeoms[i]);

                }

			}
			
			if (this._material)
            {

                this._material.iRemoveOwner(this);
                this._material.iAddOwner(this);

			}
		}
		
		/**
		public function get material():MaterialBase
		{
			return this._material;
		}
		
		public function set material(value:MaterialBase):void
		{

			if (value == this._material)
            {

                return;

            }

			if (this._material)
            {

                this._material.iRemoveOwner(this);

            }

            this._material = value;

			if (this._material)
            {

                this._material.iAddOwner(this);

            }

		}
		
		/**
		public function get subMeshes():Vector.<SubMesh>//Vector.<SubMesh>
			// Since this getter is invoked every iteration of the render loop, and
			// the geometry construct could affect the sub-meshes, the geometry is
			// validated here to give it a chance to rebuild.

            this._geometry.iValidate();

			return this._subMeshes;
		}
		
		/**
		public function get shareAnimationGeometry():Boolean
		{
			return this._shareAnimationGeometry;
		}
		
		public function set shareAnimationGeometry(value:Boolean):void
		{
            this._shareAnimationGeometry = value;
		}
		
		/**
		public function clearAnimationGeometry():void
		{

            Debug.throwPIR( "away.entities.Mesh" , "away.entities.Mesh" , "Missing Dependency: IAnimator" );

            /* TODO: Missing Dependency: IAnimator
		}
		
		/**
		override public function dispose():void
		{
			super.dispose();
			
			this.material = null;
            this.geometry = null;
		}
		
		/**
		public function disposeWithAnimatorAndChildren():void
		{
			this.disposeWithChildren();

            Debug.throwPIR( "away.entities.Mesh" , "away.entities.Mesh" , "Missing Dependency: IAnimator" );

            /* TODO: Missing Dependency: IAnimator
		}
		
		/**
		override public function clone():Object3D
		{
			var clone:Mesh = new Mesh(this._geometry, this._material);
			clone.transform = this.transform;
			clone.pivotPoint = this.pivotPoint;
			clone.partition = this.partition;
			clone.bounds = this._pBounds.clone(); // TODO: check _pBounds is the correct prop ( in case of problem / debug note )


			clone.name = this.name;
			clone.castsShadows = this.castsShadows;
			clone.shareAnimationGeometry = this.shareAnimationGeometry;
			clone.mouseEnabled = this.mouseEnabled;
			clone.mouseChildren = this.mouseChildren;
			//this is of course no proper cloning
			//maybe use this instead?: http://blog.another-d-mention.ro/programming/how-to-clone-duplicate-an-object-in-actionscript-3/
			clone.extra = this.extra;
			
			var len:Number = this._subMeshes.length;
			for (var i:Number = 0; i < len; ++i)
            {
                clone._subMeshes[i].material = this._subMeshes[i].material;
            }

			
			len = this.numChildren;
            var obj : *;

			for (i = 0; i < len; ++i)
            {

                obj = this.getChildAt(i).clone();
                clone.addChild( (obj as ObjectContainer3D) ) ;

            }

            /* TODO: implement dependency IAnimator
			
			return clone;
		}
		
		/**
		override public function pUpdateBounds():void
		{
			this._pBounds.fromGeometry(this._geometry);
            this._pBoundsInvalid = false;//this._boundsInvalid = false;
		}
		
		/**
		override public function pCreateEntityPartitionNode():EntityNode
		{
			return new MeshNode(this);
		}
		
		/**
		private function onSubGeometryAdded(event:GeometryEvent):void
		{
			this.addSubMesh( event.subGeometry );
		}
		
		/**
		private function onSubGeometryRemoved(event:GeometryEvent):void
		{
			var subMesh:SubMesh;
			var subGeom:ISubGeometry = event.subGeometry;
			var len:Number = this._subMeshes.length;
			var i:Number;
			
			// Important! This has to be done here, and not delayed until the
			// next render loop, since this may be caused by the geometry being
			// rebuilt IN THE RENDER LOOP. Invalidating and waiting will delay
			// it until the NEXT RENDER FRAME which is probably not desirable.
			
			for (i = 0; i < len; ++i)
            {

				subMesh = this._subMeshes[i];

				if (subMesh.subGeometry == subGeom)
                {
					subMesh.dispose();

					this._subMeshes.splice(i, 1);

					break;
				}
			}
			
			--len;
			for (; i < len; ++i){

                this._subMeshes[i]._iIndex = i;

            }

		}
		
		/**
		private function addSubMesh(subGeometry:ISubGeometry):void
		{

			var subMesh:SubMesh = new SubMesh(subGeometry, this, null);
			var len:Number = this._subMeshes.length;

			subMesh._iIndex = len;

			this._subMeshes[len] = subMesh;

            this.pInvalidateBounds();
		}
		
		public function getSubMeshForSubGeometry(subGeometry:SubGeometry):SubMesh
		{
			return this._subMeshes[this._geometry.subGeometries.indexOf(subGeometry)];
		}
		
		override public function iCollidesBefore(shortestCollisionDistance:Number, findClosest:Boolean):Boolean
		{

            this._iPickingCollider.setLocalRay(this._iPickingCollisionVO.localRayPosition, this._iPickingCollisionVO.localRayDirection);
            this._iPickingCollisionVO.renderable = null;
			var len:Number = this._subMeshes.length;
			for (var i:Number = 0; i < len; ++i) {
				var subMesh:SubMesh = this._subMeshes[i];
				
				//var ignoreFacesLookingAway:boolean = _material ? !_material.bothSides : true;

				if (this._iPickingCollider.testSubMeshCollision(subMesh, this._iPickingCollisionVO, shortestCollisionDistance))
                {

					shortestCollisionDistance = this._iPickingCollisionVO.rayEntryDistance;

                    this._iPickingCollisionVO.renderable = subMesh;

					if (!findClosest)
                    {

                        return true;

                    }

				}
			}
			
			return this._iPickingCollisionVO.renderable != null;
		}
	}
}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.containers
{
	import away.core.base.Object3D;
	import away.core.geom.Matrix3D;
	import away.core.partition.Partition3D;
	import away.events.Object3DEvent;
	import away.core.geom.Vector3D;
	import away.library.assets.AssetType;
	import away.events.Scene3DEvent;
	import away.errors.Error;
	public class ObjectContainer3D extends Object3D
	{
		public var _iAncestorsAllowMouseEnabled:Boolean = false;
		public var _iIsRoot:Boolean = false;
		
		public var _pScene:Scene3D;
		public var _pParent:ObjectContainer3D;
		public var _pSceneTransform:Matrix3D = new Matrix3D();
		public var _pSceneTransformDirty:Boolean = true;
		
		public var _pExplicitPartition:Partition3D;
		public var _pImplicitPartition:Partition3D;
		public var _pMouseEnabled:Boolean = false;
		
		private var _sceneTransformChanged:Object3DEvent;
		private var _scenechanged:Object3DEvent;
		private var _children:Vector.<ObjectContainer3D> = new Vector.<ObjectContainer3D>();
		private var _mouseChildren:Boolean = true;
		private var _oldScene:Scene3D;
		private var _inverseSceneTransform:Matrix3D = new Matrix3D();
		private var _inverseSceneTransformDirty:Boolean = true;
		private var _scenePosition:Vector3D = new Vector3D();
		private var _scenePositionDirty:Boolean = true;
		private var _explicitVisibility:Boolean = true;
		private var _implicitVisibility:Boolean = true;
		private var _listenToSceneTransformChanged:Boolean = false;
		private var _listenToSceneChanged:Boolean = false;
		
		public var _pIgnoreTransform:Boolean = false;
		
		public function ObjectContainer3D():void
		{
			super();
		}
		
		public function getIgnoreTransform():Boolean
		{
			return this._pIgnoreTransform;
		}
		
		public function setIgnoreTransform(value:Boolean):void
		{
			this._pIgnoreTransform = value;
			this._pSceneTransformDirty = !value;
			this._inverseSceneTransformDirty = !value;
			this._scenePositionDirty = !value;
			
			if( value ) {
				this._pSceneTransform.identity();
				this._scenePosition.setTo( 0, 0, 0 );
			}
		}

        /*        public get iImplicitPartition():away.partition.Partition3D        {            return this._pImplicitPartition;        }        */
        public function iGetImplicitPartition():Partition3D
        {

            return this._pImplicitPartition;
        }

        /*		public set iImplicitPartition( value:away.partition.Partition3D )		{            this.iSetImplicitPartition( value );		}        */
        public function iSetImplicitPartition(value:Partition3D):void
        {

            if (value == this._pImplicitPartition)
                return;

            var i:Number = 0;
            var len:Number = this._children.length;
            var child:ObjectContainer3D;

            this._pImplicitPartition = value;

            while (i < len)
            {
                child = this._children[i++];

                // assign implicit partition if no explicit one is given
                if (!child._pExplicitPartition)
                    child._pImplicitPartition = value;
            }

            /*            if ( value == this._pImplicitPartition )            {                return;            }            console.log( 'ObjectContainer3D','iSetImplicitPartition' , value );            var i:number = 0;            var len:number = this._children.length;            var child:away.containers.ObjectContainer3D;            this._pImplicitPartition = value;            while (i < len)            {                child = this._children[i++];                if( !child._pExplicitPartition )                {                    child._pImplicitPartition = value;                }            }            */

        }
		
		public function get _iIsVisible():Boolean
		{
			return this._implicitVisibility && this._explicitVisibility;
		}
		
		public function iSetParent(value:ObjectContainer3D):void
		{
			this._pParent = value;

			this.pUpdateMouseChildren();
			
			if( value == null ) {
				this.scene = null;
				return;
			}
			
			this.notifySceneTransformChange();
			this.notifySceneChange();
		}
		
		private function notifySceneTransformChange():void
		{
			if ( this._pSceneTransformDirty || this._pIgnoreTransform )
			{
				return;
			}
			
			this.pInvalidateSceneTransform();
			
			var i:Number = 0;
			var len:Number = this._children.length;
			
			while( i < len )
			{
				this._children[i++].notifySceneTransformChange();
			}
			
			if( this._listenToSceneTransformChanged )
			{
				if( !this._sceneTransformChanged )
				{
					this._sceneTransformChanged = new Object3DEvent( Object3DEvent.SCENETRANSFORM_CHANGED, this );
				}
				this.dispatchEvent( this._sceneTransformChanged );
			}
		}
		
		private function notifySceneChange():void
		{
			this.notifySceneTransformChange();
			
			var i:Number;
			var len:Number = this._children.length;
			
			while(i < len)
			{
				this._children[i++].notifySceneChange();
			}
			
			if( this._listenToSceneChanged )
			{
				if( !this._scenechanged )
				{
					this._scenechanged = new Object3DEvent( Object3DEvent.SCENE_CHANGED, this );
				}
				this.dispatchEvent( this._scenechanged );
			}
		}
		
		public function pUpdateMouseChildren():void
		{

			if( this._pParent && !this._pParent._iIsRoot )
			{
				this._iAncestorsAllowMouseEnabled = this._pParent._iAncestorsAllowMouseEnabled && this._pParent.mouseChildren;
			}
			else
			{
				this._iAncestorsAllowMouseEnabled = this.mouseChildren;
			}
			
			var len:Number = this._children.length;
			for( var i:Number = 0; i < len; ++i )
			{
				this._children[i].pUpdateMouseChildren();
			}
		}
		
		public function get mouseEnabled():Boolean
		{
			return this._pMouseEnabled;
		}
		
		public function set mouseEnabled(value:Boolean):void
		{
			this._pMouseEnabled = value;
			this.pUpdateMouseChildren();
		}

        /**         * @inheritDoc         */
        override public function iInvalidateTransform():void
        {
            super.iInvalidateTransform();

            this.notifySceneTransformChange();
        }


        public function pInvalidateSceneTransform():void
		{
			this._pSceneTransformDirty = !this._pIgnoreTransform;
			this._inverseSceneTransformDirty = !this._pIgnoreTransform;
			this._scenePositionDirty = !this._pIgnoreTransform;
		}
		
		public function pUpdateSceneTransform():void
		{
			if ( this._pParent && !this._pParent._iIsRoot )
			{
				this._pSceneTransform.copyFrom( this._pParent.sceneTransform );
				this._pSceneTransform.prepend( this.transform );
			}
			else
			{
				this._pSceneTransform.copyFrom( this.transform );
			}
			this._pSceneTransformDirty = false;
		}
		
		public function get mouseChildren():Boolean
		{
			return this._mouseChildren;
		}
		
		public function set mouseChildren(value:Boolean):void
		{
			this._mouseChildren = value;
			this.pUpdateMouseChildren();
		}
		
		public function get visible():Boolean
		{
			return this._explicitVisibility;
		}
		
		public function set visible(value:Boolean):void
		{
			var len:Number = this._children.length;
			
			this._explicitVisibility = value;
			
			for( var i:Number = 0; i < len; ++i )
			{
				this._children[i].updateImplicitVisibility();
			}
		}
		
		override public function get assetType():String
		{
			return AssetType.CONTAINER;
		}
		
		public function get scenePosition():Vector3D
		{
			if ( this._scenePositionDirty )
			{
				this.sceneTransform.copyColumnTo( 3, this._scenePosition );
				this._scenePositionDirty = false;
			}
			return this._scenePosition;
		}
		
		public function get minX():Number
		{
			var i:Number;
			var len:Number = this._children.length;
			var min:Number = Number.POSITIVE_INFINITY;
			var m:Number;
			
			while( i < len ) {
				var child:ObjectContainer3D = this._children[i++];
				m = child.minX + child.x;
				if( m < min )
				{
					min = m;
				}
			}
			return min;
		}
		
		public function get minY():Number
		{
			var i:Number;
			var len:Number = this._children.length;
			var min:Number = Number.POSITIVE_INFINITY;
			var m:Number;
			
			while( i < len )
			{
				var child:ObjectContainer3D = this._children[i++];
				m = child.minY + child.y;
				if( m < min )
				{
					min = m;
				}
			}
			return min;
		}
		
		public function get minZ():Number
		{
			var i:Number;
			var len:Number = this._children.length;
			var min:Number = Number.POSITIVE_INFINITY;
			var m:Number;
			
			while( i < len )
			{
				var child:ObjectContainer3D = this._children[i++];
				m = child.minZ + child.z;
				if( m < min )
				{
					min = m;
				}
			}
			return min;
		}
		
		public function get maxX():Number
		{
			var i:Number;
			var len:Number = this._children.length;
			var max:Number = Number.NEGATIVE_INFINITY;
			var m:Number;
			
			while( i < len ) {
				var child:ObjectContainer3D = this._children[i++];
				m = child.maxX + child.x;
				if( m > max )
				{
					max = m;
				}
			}
			return max;
		}
		
		public function get maxY():Number
		{
			var i:Number;
			var len:Number = this._children.length;
			var max:Number = Number.NEGATIVE_INFINITY;
			var m:Number;
			
			while( i < len )
			{
				var child:ObjectContainer3D = this._children[i++];
				m = child.maxY + child.y;
				if( m > max )
				{
					max = m;
				}
			}
			return max;
		}
		
		public function get maxZ():Number
		{
			var i:Number;
			var len:Number = this._children.length;
			var max:Number = Number.NEGATIVE_INFINITY;
			var m:Number;
			
			while( i < len ) {
				var child:ObjectContainer3D = this._children[i++];
				m = child.maxZ + child.z;
				if( m > max )
				{
					max = m;
				}
			}
			return max;
		}
		
		public function get partition():Partition3D
		{
			return this._pExplicitPartition;
		}
		
		public function set partition(value:Partition3D):void
		{
			this._pExplicitPartition = value;
			this.iSetImplicitPartition( value ? value : ( this._pParent ? this._pParent.iGetImplicitPartition() : null) );
		}
		
		public function get sceneTransform():Matrix3D
		{
			if( this._pSceneTransformDirty )
			{
				this.pUpdateSceneTransform();
			}
			return this._pSceneTransform;
		}

        public function get scene():Scene3D
        {
            return this._pScene;
        }

        public function set scene(value:Scene3D):void
        {

            this.setScene( value );

        }

        public function setScene(value:Scene3D):void
        {

            //console.log( 'ObjectContainer3D' , 'setScene' , value );

            var i:Number = 0;
            var len:Number = this._children.length;

            while (i < len)
            {
                this._children[i++].scene = value;
            }

            if (this._pScene == value)
                return;

            // test to see if we're switching roots while we're already using a scene partition
            if (value == null)
                this._oldScene = this._pScene;

            if (this._pExplicitPartition && this._oldScene && this._oldScene != this._pScene)
                this.partition = null;

            if (value)
            {
                this._oldScene = null;
            }
            // end of stupid partition test code

            this._pScene = value;

            if (this._pScene)
            {
                this._pScene.dispatchEvent(new Scene3DEvent(Scene3DEvent.ADDED_TO_SCENE, this));
            }
            else if (this._oldScene)
            {
                this._oldScene.dispatchEvent(new Scene3DEvent(Scene3DEvent.REMOVED_FROM_SCENE, this));
            }

        }
		
		public function get inverseSceneTransform():Matrix3D
		{
			if ( this._inverseSceneTransformDirty )
			{
				this._inverseSceneTransform.copyFrom( this.sceneTransform );
				this._inverseSceneTransform.invert();
				this._inverseSceneTransformDirty = false;
			}
			return this._inverseSceneTransform;
		}
		
		public function get parent():ObjectContainer3D
		{
			return this._pParent;
		}
		
		public function contains(child:ObjectContainer3D):Boolean
		{
			return this._children.indexOf( child ) >= 0;
		}
		
		public function addChild(child:ObjectContainer3D):ObjectContainer3D
		{
			if (child == null)
			{
				throw new away.errors.Error("Parameter child cannot be null.");
			}
			
			if (child._pParent)
			{
				child._pParent.removeChild(child);
			}

            //console.log( 'ObjectContainer3D' , 'addChild' , 'child._pExplicitPartition' ,  child._pExplicitPartition );

			if (!child._pExplicitPartition)
			{

                //console.log( 'ObjectContainer3D' , 'addChild' , 'set iImplicitPartition' ,  this._pImplicitPartition);

                child.iSetImplicitPartition( this._pImplicitPartition );
				//child.iImplicitPartition = this._pImplicitPartition;
			}
			
			child.iSetParent( this );
			child.scene = this._pScene;
			child.notifySceneTransformChange();
			child.pUpdateMouseChildren();
			child.updateImplicitVisibility();
			
			this._children.push(child);
			
			return child;
		}
		
		public function addChildren(childarray:ObjectContainer3D):void
		{
			for(var child in childarray )
			{
				this.addChild( child );
			}
		}
		
		public function removeChild(child:ObjectContainer3D):void
		{
			if ( child == null )
			{
				throw new away.errors.Error("Parameter child cannot be null");
			}
			
			var childIndex:Number = this._children.indexOf(child);
			
			if ( childIndex == -1 )
			{
				throw new away.errors.Error("Parameter is not a child of the caller");
			}
			
			this.removeChildInternal( childIndex, child );
		}
		
		public function removeChildAt(index:Number):void
		{
			var child:ObjectContainer3D = this._children[index];
			this.removeChildInternal( index, child );
		}
		
		private function removeChildInternal(childIndex:Number, child:ObjectContainer3D):void
		{
			this._children.splice( childIndex, 1 );
			child.iSetParent( null );
			
			if ( !child._pExplicitPartition )
			{
				child.iSetImplicitPartition( null );
			}
		}
		
		public function getChildAt(index:Number):ObjectContainer3D
		{
			return this._children[index];
		}
		
		public function get numChildren():Number
		{
			return this._children.length;
		}
		
		//@override 
		override public function lookAt(target:Vector3D, upAxis:Vector3D = null):void
		{
			upAxis = upAxis || null;


			super.lookAt( target, upAxis );
			this.notifySceneTransformChange();
		}
		
		//@override
		override public function translateLocal(axis:Vector3D, distance:Number):void
		{
    		super.translateLocal( axis, distance );
			this.notifySceneTransformChange();
		}
		
		//@override
		override public function dispose():void
		{
			if( this.parent )
			{
				this.parent.removeChild( this );
			}
		}
		
		public function disposeWithChildren():void
		{
			this.dispose();
			while( this.numChildren > 0 )
			{
				this.getChildAt(0).dispose();
			}
		}
		
		//override

		override public function clone():Object3D
		{
			var clone:ObjectContainer3D = new ObjectContainer3D();
			clone.pivotPoint = this.pivotPoint;
			clone.transform = this.transform;
			clone.partition = this.partition;
			clone.name = name;
			
			var len:Number = this._children.length;
			
			for(var i:Number = 0; i < len; ++i)
			{
				clone.addChild( (this._children[i].clone( ) as ObjectContainer3D) );
			}
			// todo: implement for all subtypes
			return clone;
		}

		
		//@override
		override public function rotate(axis:Vector3D, angle:Number):void
		{
			super.rotate(axis, angle);
			this.notifySceneTransformChange();
		}
		
		//TODO override public function dispatchEvent(event:Event):Boolean
		
		public function updateImplicitVisibility():void
		{
			var len:Number = this._children.length;
			
			this._implicitVisibility = this._pParent._explicitVisibility && this._pParent._implicitVisibility;
			
			for (var i:Number = 0; i < len; ++i)
			{
				this._children[i].updateImplicitVisibility();
			}
		}
		
		//TODO override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		//TODO override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		
	}
}
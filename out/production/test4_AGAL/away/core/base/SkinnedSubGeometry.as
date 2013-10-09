/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.core.base
{
	import away.core.display3D.VertexBuffer3D;
	import away.core.display3D.Context3D;
	import away.managers.Stage3DProxy;
	import away.utils.VectorInit;
	import away.utils.VectorInit;

    /**
	public class SkinnedSubGeometry extends CompactSubGeometry
	{
		private var _bufferFormat:String = null;
		private var _jointWeightsData:Vector.<Number>;
		private var _jointIndexData:Vector.<Number>;
		private var _animatedData:Vector.<Number>;// used for cpu fallback
		private var _jointWeightsBuffer:Vector.<VertexBuffer3D> = VectorInit.AnyClass(VertexBuffer3D, 8);
		private var _jointIndexBuffer:Vector.<VertexBuffer3D> = VectorInit.AnyClass(VertexBuffer3D, 8);
		private var _jointWeightsInvalid:Vector.<Boolean> = VectorInit.Bool(8);
		private var _jointIndicesInvalid:Vector.<Boolean> = VectorInit.Bool(8);
		private var _jointWeightContext:Vector.<Context3D> = VectorInit.AnyClass(Context3D, 8);
		private var _jointIndexContext:Vector.<Context3D> = VectorInit.AnyClass(Context3D, 8);
		private var _jointsPerVertex:Number = 0;
		
		private var _condensedJointIndexData:Vector.<Number>;
		private var _condensedIndexLookUp:Vector.<Number>;/*uint*/// used for linking condensed indices to the real ones
		private var _numCondensedJoints:Number = 0;
		
		/**
		public function SkinnedSubGeometry(jointsPerVertex:Number):void
		{
			super();

			this._jointsPerVertex = jointsPerVertex;
            this._bufferFormat = "float" + this._jointsPerVertex;
		}
		
		/**
		public function get condensedIndexLookUp():Vector.<Number> /*uint*/		{
			return this._condensedIndexLookUp;
		}
		
		/**
		public function get numCondensedJoints():Number
		{
			return this._numCondensedJoints;
		}
		
		/**
		public function get animatedData():Vector.<Number>
		{
			return this._animatedData ||this._vertexData.concat();
		}
		
		public function updateAnimatedData(value:Vector.<Number>):void
		{
            this._animatedData = value;
            this.pInvalidateBuffers( this._pVertexDataInvalid );
		}
		
		/**
		public function activateJointWeightsBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
			var contextIndex:Number = stage3DProxy._iStage3DIndex;
			var context:Context3D = stage3DProxy._iContext3D;
			if (this._jointWeightContext[contextIndex] != context || !this._jointWeightsBuffer[contextIndex]) {
                this._jointWeightsBuffer[contextIndex] = context.createVertexBuffer(this._pNumVertices, this._jointsPerVertex);
                this._jointWeightContext[contextIndex] = context;
                this._jointWeightsInvalid[contextIndex] = true;
			}
			if (this._jointWeightsInvalid[contextIndex]) {
                this._jointWeightsBuffer[contextIndex].uploadFromArray(this._jointWeightsData, 0, this._jointWeightsData.length/this._jointsPerVertex);
                this._jointWeightsInvalid[contextIndex] = false;
			}
			context.setVertexBufferAt(index, this._jointWeightsBuffer[contextIndex], 0, this._bufferFormat);
		}
		
		/**
		public function activateJointIndexBuffer(index:Number, stage3DProxy:Stage3DProxy):void
		{
			var contextIndex:Number = stage3DProxy._iStage3DIndex;
			var context:Context3D = stage3DProxy._iContext3D;
			
			if (this._jointIndexContext[contextIndex] != context || !this._jointIndexBuffer[contextIndex]) {
                this._jointIndexBuffer[contextIndex] = context.createVertexBuffer(this._pNumVertices, this._jointsPerVertex);
                this._jointIndexContext[contextIndex] = context;
                this._jointIndicesInvalid[contextIndex] = true;
			}
			if (this._jointIndicesInvalid[contextIndex]) {
                this._jointIndexBuffer[contextIndex].uploadFromArray(this._numCondensedJoints > 0? this._condensedJointIndexData : this._jointIndexData, 0, this._jointIndexData.length/this._jointsPerVertex);
                this._jointIndicesInvalid[contextIndex] = false;
			}
			context.setVertexBufferAt(index, this._jointIndexBuffer[contextIndex], 0, this._bufferFormat);
		}
		
		override public function pUploadData(contextIndex:Number):void
		{
			if (this._animatedData) {
                this._pActiveBuffer.uploadFromArray(this._animatedData, 0, this._pNumVertices);
                this._pVertexDataInvalid[contextIndex] = false;
                this._pActiveDataInvalid = false;

			}
            else
            {
				super.pUploadData(contextIndex);
            }
		}
		
		/**
		override public function clone():ISubGeometry
		{
			var clone:SkinnedSubGeometry = new SkinnedSubGeometry(this._jointsPerVertex);

			clone.updateData(this._vertexData.concat());
			clone.updateIndexData(this._indices.concat());
			clone.iUpdateJointIndexData(this._jointIndexData.concat());
			clone.iUpdateJointWeightsData(this._jointWeightsData.concat());
			clone._autoDeriveVertexNormals = this._autoDeriveVertexNormals;
			clone._autoDeriveVertexTangents = this._autoDeriveVertexTangents;
			clone._numCondensedJoints = this._numCondensedJoints;
			clone._condensedIndexLookUp = this._condensedIndexLookUp;
			clone._condensedJointIndexData = this._condensedJointIndexData;

			return clone;
		}
		
		/**
		override public function dispose():void
		{
			super.dispose();
            this.pDisposeVertexBuffers(this._jointWeightsBuffer);
            this.pDisposeVertexBuffers(this._jointIndexBuffer);
		}
		
		/**
		public function iCondenseIndexData():void
		{
			var len:Number = this._jointIndexData.length;
			var oldIndex:Number;
			var newIndex:Number = 0;
			var dic:Object = new Object();

            this._condensedJointIndexData = VectorInit.Num(len);
            this._condensedIndexLookUp = VectorInit.Num();
			
			for (var i:Number = 0; i < len; ++i) {
				oldIndex = this._jointIndexData[i];
				
				// if we encounter a new index, assign it a new condensed index
				if (dic[oldIndex] == undefined) {
					dic[oldIndex] = newIndex;
                    this._condensedIndexLookUp[newIndex++] = oldIndex;
                    this._condensedIndexLookUp[newIndex++] = oldIndex + 1;
                    this._condensedIndexLookUp[newIndex++] = oldIndex + 2;
				}
                this._condensedJointIndexData[i] = dic[oldIndex];
			}
            this._numCondensedJoints = newIndex/3;

            this.pInvalidateBuffers(this._jointIndicesInvalid);
		}
		
		/**
		public function get iJointWeightsData():Vector.<Number>
		{
			return this._jointWeightsData;
		}
		
		public function iUpdateJointWeightsData(value:Vector.<Number>):void
		{
			// invalidate condensed stuff
            this._numCondensedJoints = 0;
            this._condensedIndexLookUp = null;
            this._condensedJointIndexData = null;

            this._jointWeightsData = value;
            this.pInvalidateBuffers(this._jointWeightsInvalid);
		}
		
		/**
		public function get iJointIndexData():Vector.<Number>
		{
			return this._jointIndexData;
		}
		
		public function iUpdateJointIndexData(value:Vector.<Number>):void
		{
            this._jointIndexData = value;
			this.pInvalidateBuffers(this._jointIndicesInvalid);
		}
	}
}
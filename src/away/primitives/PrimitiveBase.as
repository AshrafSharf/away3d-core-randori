///<reference path="../_definitions.ts"/>

package away.primitives
{
	import away.base.Geometry;
	import away.base.CompactSubGeometry;
	import away.base.ISubGeometry;
	import away.geom.Matrix3D;
	import away.errors.AbstractMethodError;
	//import away3d.arcane;
	//import away3d.core.base.CompactSubGeometry;
	//import away3d.core.base.Geometry;
	//import away3d.core.base.ISubGeometry;
	//import away3d.errors.AbstractMethodError;
	
	//import flash.geom.Matrix3D;
	
	//use namespace arcane;
	
	/**	 * PrimitiveBase is an abstract base class for mesh primitives, which are prebuilt simple meshes.	 */
	public class PrimitiveBase extends Geometry
	{
		private var _geomDirty:Boolean = true;
		private var _uvDirty:Boolean = true;
		
		private var _subGeometry:CompactSubGeometry;
		
		/**		 * Creates a new PrimitiveBase object.		 * @param material The material with which to render the object		 */
		public function PrimitiveBase():void
		{
            super();

			_subGeometry = new CompactSubGeometry();
			_subGeometry.autoGenerateDummyUVs = false;
			addSubGeometry( _subGeometry );
		}
		
		/**		 * @inheritDoc		 */
		override public function get subGeometries():Vector.<ISubGeometry>
		{
			if (_geomDirty)
            {

                updateGeometry();

            }

			if ( _uvDirty )
            {

                updateUVs();
            }

			
			return super.getSubGeometries();
		}
		
		/**		 * @inheritDoc		 */
		override public function clone():Geometry
		{
			if (_geomDirty)
            {

                updateGeometry();

            }

			if ( _uvDirty )
            {
                updateUVs();
            }

			
			return super.clone();
		}
		
		/**		 * @inheritDoc		 */
		override public function scale(scale:Number):void
		{
			if ( _geomDirty)
            {
                updateGeometry();
            }

			
			super.scale(scale);
		}
		
		/**		 * @inheritDoc		 */
		override public function scaleUV(scaleU:Number = 1, scaleV:Number = 1):void
		{
			if (_uvDirty)
            {

                updateUVs();

            }

			
			super.scaleUV(scaleU, scaleV);
		}
		
		/**		 * @inheritDoc		 */
		override public function applyTransformation(transform:Matrix3D):void
		{
			if (_geomDirty)
            {

                updateGeometry();

            }

			super.applyTransformation(transform);

		}
		
		/**		 * Builds the primitive's geometry when invalid. This method should not be called directly. The calling should		 * be triggered by the invalidateGeometry method (and in turn by updateGeometry).		 */
		public function pBuildGeometry(target:CompactSubGeometry):void
		{
			throw new AbstractMethodError();
		}
		
		/**		 * Builds the primitive's uv coordinates when invalid. This method should not be called directly. The calling		 * should be triggered by the invalidateUVs method (and in turn by updateUVs).		 */
		public function pBuildUVs(target:CompactSubGeometry):void
		{
			throw new AbstractMethodError();
		}
		
		/**		 * Invalidates the primitive's geometry, causing it to be updated when requested.		 */
		public function pInvalidateGeometry():void
		{
			_geomDirty = true;
		}
		
		/**		 * Invalidates the primitive's uv coordinates, causing them to be updated when requested.		 */
		public function pInvalidateUVs():void
		{
			_uvDirty = true;
		}
		
		/**		 * Updates the geometry when invalid.		 */
		private function updateGeometry():void
		{
			pBuildGeometry(_subGeometry);
			_geomDirty = false;
		}
		
		/**		 * Updates the uv coordinates when invalid.		 */
		private function updateUVs():void
		{
			pBuildUVs(_subGeometry);
			_uvDirty = false;
		}
		
		override public function iValidate():void
		{
			if (_geomDirty)
            {

                updateGeometry();

            }

			if (_uvDirty)
            {

                updateUVs();

            }

		}
	}
}

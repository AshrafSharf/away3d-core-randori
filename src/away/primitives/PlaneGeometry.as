///<reference path="../_definitions.ts"/>

package away.primitives
{
	import away.base.CompactSubGeometry;
	/**
	public class PlaneGeometry extends PrimitiveBase
	{
		private var _segmentsW:Number;
		private var _segmentsH:Number;
		private var _yUp:Boolean;
		private var _width:Number;
		private var _height:Number;
		private var _doubleSided:Boolean;
		
		/**
		public function PlaneGeometry(width:Number = 100, height:Number = 100, segmentsW:Number = 1, segmentsH:Number = 1, yUp:Boolean = true, doubleSided:Boolean = false):void
		{

			super();
			
			this._segmentsW = segmentsW;
            this._segmentsH = segmentsH;
            this._yUp = yUp;
            this._width = width;
            this._height = height;
            this._doubleSided = doubleSided;

		}
		
		/**
		public function get segmentsW():Number
		{
			return _segmentsW;
		}
		
		public function set segmentsW(value:Number):void
		{

            this._segmentsW = value;

            this.pInvalidateGeometry();
            this.pInvalidateUVs();

		}
		
		/**
		public function get segmentsH():Number
		{
			return _segmentsH;
		}
		
		public function set segmentsH(value:Number):void
		{

            this._segmentsH = value;

            this.pInvalidateGeometry();
            this.pInvalidateUVs();

		}
		
		/**
		public function get yUp():Boolean
		{
			return _yUp;
		}
		
		public function set yUp(value:Boolean):void
		{
            this._yUp = value;
            this.pInvalidateGeometry();
		}
		
		/**
		public function get doubleSided():Boolean
		{
			return _doubleSided;
		}
		
		public function set doubleSided(value:Boolean):void
		{
            this._doubleSided = value;
            this.pInvalidateGeometry();
		}
		
		/**
		public function get width():Number
		{
			return _width;
		}
		
		public function set width(value:Number):void
		{
			this._width = value;
            this.pInvalidateGeometry();
		}
		
		/**
		public function get height():Number
		{
			return _height;
		}
		
		public function set height(value:Number):void
		{
			this._height = value;
            this.pInvalidateGeometry();//invalidateGeometry();
		}
		
		/**
		override public function pBuildGeometry(target:CompactSubGeometry):void
		{
			var data:Vector.<Number>;
			var indices:Vector.<Number> /*uint*/;
			var x:Number, y:Number;
			var numIndices:Number;
			var base:Number;
			var tw:Number = _segmentsW + 1;
			var numVertices:Number = (_segmentsH + 1)*tw;
			var stride:Number = target.vertexStride;
			var skip:Number = stride - 9;

			if (_doubleSided)
				numVertices *= 2;
			
			numIndices = _segmentsH*_segmentsW*6;

			if (_doubleSided)
				numIndices <<= 1;
			
			if (numVertices == target.numVertices)
            {

                data = target.vertexData;

                if ( indices == null )
                {
                    indices = new Vector.<Number>( numIndices );
                }
                else
                {
                    indices = target.indexData;
                }
			}
            else
            {
				data = new Vector.<Number>( numVertices*stride );//new Vector.<Number>(numVertices*stride, true);
				indices = new Vector.<Number>( numIndices );//new Vector.<uint>(numIndices, true);

                pInvalidateUVs();//invalidateUVs();
			}
			
			numIndices = 0;

			var index:Number = target.vertexOffset;

			for (var yi:Number = 0; yi <= _segmentsH; ++yi)
            {

				for (var xi:Number = 0; xi <= _segmentsW; ++xi)
                {
					x = (xi/_segmentsW - .5)*_width;
					y = (yi/_segmentsH - .5)*_height;
					
					data[index++] = x;
					if (_yUp)
                    {
						data[index++] = 0;
						data[index++] = y;
					}
                    else
                    {
						data[index++] = y;
						data[index++] = 0;
					}
					
					data[index++] = 0;

					if (_yUp)
                    {
						data[index++] = 1;
						data[index++] = 0;
					}
                    else
                    {
						data[index++] = 0;
						data[index++] = -1;
					}
					
					data[index++] = 1;
					data[index++] = 0;
					data[index++] = 0;
					
					index += skip;
					
					// add vertex with same position, but with inverted normal & tangent
					if (_doubleSided)
                    {

						for (var i:Number = 0; i < 3; ++i)
                        {
							data[index] = data[index - stride];
							++index;
						}

						for (i = 0; i < 3; ++i)
                        {
							data[index] = -data[index - stride];
							++index;
						}

						for (i = 0; i < 3; ++i)
                        {
							data[index] = -data[index - stride];
							++index;
						}

						index += skip;

					}
					
					if (xi != _segmentsW && yi != _segmentsH)
                    {

						base = xi + yi*tw;
						var mult:Number = _doubleSided? 2 : 1;
						
						indices[numIndices++] = base*mult;
						indices[numIndices++] = (base + tw)*mult;
						indices[numIndices++] = (base + tw + 1)*mult;
						indices[numIndices++] = base*mult;
						indices[numIndices++] = (base + tw + 1)*mult;
						indices[numIndices++] = (base + 1)*mult;
						
						if (_doubleSided)
                        {

							indices[numIndices++] = (base + tw + 1)*mult + 1;
							indices[numIndices++] = (base + tw)*mult + 1;
							indices[numIndices++] = base*mult + 1;
							indices[numIndices++] = (base + 1)*mult + 1;
							indices[numIndices++] = (base + tw + 1)*mult + 1;
							indices[numIndices++] = base*mult + 1;

						}
					}
				}
			}

			target.updateData(data);
			target.updateIndexData(indices);

		}
		
		/**
		override public function pBuildUVs(target:CompactSubGeometry):void
		{
			var data:Vector.<Number>;
			var stride:Number = target.UVStride;
			var numUvs:Number = ( _segmentsH + 1 )*( _segmentsW + 1 ) * stride;
			var skip:Number = stride - 2;
			
			if (_doubleSided)
            {
                numUvs *= 2;
            }

			
			if (target.UVData && numUvs == target.UVData.length)
            {
                data = target.UVData;
            }
			else
            {
				data = new Vector.<Number>( numUvs );//Vector.<Number>(numUvs, true);
                pInvalidateGeometry()
			}
			
			var index:Number = target.UVOffset;
			
			for (var yi:Number = 0; yi <= _segmentsH; ++yi)
            {

				for (var xi:Number = 0; xi <= _segmentsW; ++xi)
                {
					data[index++] = (1 - (xi/_segmentsW)*target.scaleU );
					data[index++] = (1 - yi/_segmentsH)*target.scaleV;
					index += skip;
					
					if (_doubleSided)
                    {
						data[index++] = (1 - (xi/_segmentsW)*target.scaleU ) ;
						data[index++] = ( 1 - yi/_segmentsH)*target.scaleV;
						index += skip;
					}
				}
			}
			
			target.updateData(data);
		}
	}
}
///<reference path="../_definitions.ts"/>
package away.primitives
{
	import away.geom.Vector3D;
	//import flash.geom.Vector3D;
	
	/**
	public class WireframePlane extends WireframePrimitiveBase
	{
		public static var ORIENTATION_YZ:String = "yz";
		public static var ORIENTATION_XY:String = "xy";
		public static var ORIENTATION_XZ:String = "xz";
		
		private var _width:Number;
		private var _height:Number;
		private var _segmentsW:Number;
		private var _segmentsH:Number;
		private var _orientation:String;
		
		/**
		public function WireframePlane(width:Number, height:Number, segmentsW:Number = 10, segmentsH:Number = 10, color:Number = 0xFFFFFF, thickness:Number = 1, orientation:String = "yz"):void
		{
			super(color, thickness);
			
			this._width = width;
            this._height = height;
            this._segmentsW = segmentsW;
            this._segmentsH = segmentsH;
            this._orientation = orientation;
		}
		
		/**
		public function get orientation():String
		{
			return _orientation;
		}
		
		public function set orientation(value:String):void
		{
            this._orientation = value;
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
			if (value <= 0)
				throw new Error("Value needs to be greater than 0");
            this._height = value;
            this.pInvalidateGeometry();
		}
		
		/**
		public function get segmentsW():Number
		{
			return _segmentsW;
		}
		
		public function set segmentsW(value:Number):void
		{
            this._segmentsW = value;
            this.removeAllSegments();
            this.pInvalidateGeometry();
		}
		
		/**
		public function get segmentsH():Number
		{
			return _segmentsH;
		}
		
		public function set segmentsH(value:Number):void
		{
            this._segmentsH = value;
            this.removeAllSegments();
            this.pInvalidateGeometry();
		}
		
		/**
		override public function pBuildGeometry():void
		{
			var v0:Vector3D = new Vector3D();
			var v1:Vector3D = new Vector3D();
			var hw:Number = _width*.5;
			var hh:Number = _height*.5;
			var index:Number = 0;
			var ws:Number, hs:Number;
			
			if ( _orientation == WireframePlane.ORIENTATION_XY)
            {

				v0.y = hh;
				v0.z = 0;
				v1.y = -hh;
				v1.z = 0;
				
				for (ws = 0; ws <= _segmentsW; ++ws)
                {
					v0.x = v1.x = (ws/_segmentsW - .5)*_width;
                    pUpdateOrAddSegment(index++, v0, v1);
				}
				
				v0.x = -hw;
				v1.x = hw;
				
				for (hs = 0; hs <= _segmentsH; ++hs)
                {
					v0.y = v1.y = (hs/_segmentsH - .5)*_height;
					pUpdateOrAddSegment(index++, v0, v1);
				}
			}
			else if (_orientation == WireframePlane.ORIENTATION_XZ)
            {
				v0.z = hh;
				v0.y = 0;
				v1.z = -hh;
				v1.y = 0;
				
				for (ws = 0; ws <= _segmentsW; ++ws)
                {
					v0.x = v1.x = (ws/_segmentsW - .5)*_width;
                    pUpdateOrAddSegment(index++, v0, v1);
				}
				
				v0.x = -hw;
				v1.x = hw;
				
				for (hs = 0; hs <= _segmentsH; ++hs)
                {
					v0.z = v1.z = (hs/_segmentsH - .5)*_height;
                    pUpdateOrAddSegment(index++, v0, v1);
				}
			}
			else if (_orientation == WireframePlane.ORIENTATION_YZ)
            {
				v0.y = hh;
				v0.x = 0;
				v1.y = -hh;
				v1.x = 0;
				
				for (ws = 0; ws <= _segmentsW; ++ws)
                {
					v0.z = v1.z = (ws/_segmentsW - .5)*_width;
                    pUpdateOrAddSegment(index++, v0, v1);
				}
				
				v0.z = hw;
				v1.z = -hw;
				
				for (hs = 0; hs <= _segmentsH; ++hs)
                {
					v0.y = v1.y = (hs/_segmentsH - .5)*_height;
                    pUpdateOrAddSegment(index++, v0, v1);
				}
			}
		}
	
	}
}
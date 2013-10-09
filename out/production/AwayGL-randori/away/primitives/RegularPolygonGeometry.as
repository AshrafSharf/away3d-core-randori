/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.primitives
{
	
	/**
	public class RegularPolygonGeometry extends CylinderGeometry
	{
		
		/**
		public function get radius():Number
		{
			return this._pBottomRadius;
		}
		
		public function set radius(value:Number):void
		{
			this._pBottomRadius = value;
			this.pInvalidateGeometry();
		}
		
		/**
		public function get sides():Number
		{
			return this._pSegmentsW;
		}
		
		public function set sides(value:Number):void
		{
			this.setSegmentsW ( value );
		}
		
		/**
		public function get subdivisions():Number
		{
			return this._pSegmentsH;
		}
		
		public function set subdivisions(value:Number):void
		{
			this.setSegmentsH ( value );
		}
		
		/**
		public function RegularPolygonGeometry(radius:Number = 100, sides:Number = 16, yUp:Boolean = true):void
		{
			radius = radius || 100;
			sides = sides || 16;

			super(radius, 0, 0, sides, 1, true, false, false, yUp);
		}
	}
}
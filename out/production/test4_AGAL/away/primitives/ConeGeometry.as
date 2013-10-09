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
	public class ConeGeometry extends CylinderGeometry
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
		public function ConeGeometry(radius:Number = 50, height:Number = 100, segmentsW:Number = 16, segmentsH:Number = 1, closed:Boolean = true, yUp:Boolean = true):void
		{
			radius = radius || 50;
			height = height || 100;
			segmentsW = segmentsW || 16;
			segmentsH = segmentsH || 1;
			closed = closed || true;
			yUp = yUp || true;

			super(0, radius, height, segmentsW, segmentsH, false, closed, true, yUp);
		}
	}
}
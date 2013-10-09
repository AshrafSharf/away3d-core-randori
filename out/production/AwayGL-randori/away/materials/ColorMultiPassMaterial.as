/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials
{

	/**
	public class ColorMultiPassMaterial extends MultiPassMaterialBase
	{
		/**
		public function ColorMultiPassMaterial(color:Number = 0xcccccc):void
		{
			color = color || 0xcccccc;

			super();
			this.color = color;
		}
		
		/**
		public function get color():Number
		{
			return this.diffuseMethod.diffuseColor;
		}
		
		public function set color(value:Number):void
		{
			this.diffuseMethod.diffuseColor = value;
		}
	}
}
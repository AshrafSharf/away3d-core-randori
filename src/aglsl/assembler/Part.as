/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package aglsl.assembler
{
	import away.utils.ByteArray;
	public class Part
	{
		public var name:String = "";
		public var version:Number = 0;
		public var data:ByteArray;
		
		public function Part(name:String = null, version:Number = null):void
		{
			name = name || null;
			version = version || null;

			this.name = name;
			this.version = version;
			this.data = new ByteArray();
		}
	}
}
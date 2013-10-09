/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.compilation
{
	
	/**
	public class ShaderRegisterElement
	{
		private var _regName:String = null;
		private var _index:Number = 0;
		private var _toStr:String = null;
		
		private static var COMPONENTS:Vector.<String> = new <String>['x','y','z','w'];
		
		public var _component:Number = 0;
		
		/**
		public function ShaderRegisterElement(regName:String, index:Number, component:Number = -1):void
		{
			component = component || -1;

			this._component = component;
			this._regName = regName;
            this._index = index;

            this._toStr = this._regName;
			
			if (this._index >= 0)
            {

                this._toStr += this._index;

            }

			if (component > -1)
            {

                this._toStr += "." + ShaderRegisterElement.COMPONENTS[component];

            }

		}
		
		/**
		public function toString():String
		{
			return this._toStr;
		}
		
		/**
		public function get regName():String
		{
			return this._regName;
		}
		
		/**
		public function get index():Number
		{
			return this._index;
		}
	}
}
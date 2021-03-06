/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.compilation
{
	/**	 * ShaderRegisterData contains the "named" registers, generated by the compiler and to be passed on to the methods.	 */
	public class ShaderRegisterData
	{
		public var normalVarying:ShaderRegisterElement;
		public var tangentVarying:ShaderRegisterElement;
		public var bitangentVarying:ShaderRegisterElement;
		public var uvVarying:ShaderRegisterElement;
		public var secondaryUVVarying:ShaderRegisterElement;
		public var viewDirVarying:ShaderRegisterElement;
		public var shadedTarget:ShaderRegisterElement;
		public var globalPositionVertex:ShaderRegisterElement;
		public var globalPositionVarying:ShaderRegisterElement;
		public var localPosition:ShaderRegisterElement;
		public var normalInput:ShaderRegisterElement;
		public var tangentInput:ShaderRegisterElement;
		public var animatedNormal:ShaderRegisterElement;
		public var animatedTangent:ShaderRegisterElement;
		public var commons:ShaderRegisterElement;
		public var projectionFragment:ShaderRegisterElement;
		public var normalFragment:ShaderRegisterElement;
		public var viewDirFragment:ShaderRegisterElement;
		public var bitangent:ShaderRegisterElement;
		
		public function ShaderRegisterData():void
		{
		
		}
	}
}

/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.methods
{
	import away.library.assets.NamedAssetBase;
	import away.materials.compilation.ShaderRegisterData;
	import away.materials.passes.MaterialPassBase;
	import away.materials.compilation.ShaderRegisterCache;
	import away.managers.Stage3DProxy;
	import away.core.base.IRenderable;
	import away.cameras.Camera3D;
	import away.materials.compilation.ShaderRegisterElement;
	import away.textures.TextureProxyBase;
	import away.core.display3D.Context3DTextureFormat;
	import away.events.ShadingMethodEvent;
	//import away3d.*;
	//import away3d.cameras.*;
	//import away3d.core.base.*;
	//import away3d.managers.*;
	//import away3d.events.*;
	//import away3d.library.assets.*;
	//import away3d.materials.compilation.*;
	//import away3d.materials.passes.*;
	//import away3d.textures.*;
	
	//import flash.display3D.*;
	
	//use namespace arcane;
	
	/**
	public class ShadingMethodBase extends NamedAssetBase
	{
		public var _sharedRegisters:ShaderRegisterData;// should be protected
		private var _passes:Vector.<MaterialPassBase>;//Vector.<MaterialPassBase>
		
		/**
		public function ShadingMethodBase():void // needsNormals : boolean, needsView : boolean, needsGlobalPos : boolean
            super(null);
		}

		/**
		public function iInitVO(vo:MethodVO):void
		{
		
		}

		/**
		public function iInitConstants(vo:MethodVO):void
		{



		}

		/**
		public function get iSharedRegisters():ShaderRegisterData
		{
			return this._sharedRegisters;
		}

        public function set iSharedRegisters(value:ShaderRegisterData):void
        {
            this._sharedRegisters = value;
        }

        public function setISharedRegisters(value:ShaderRegisterData):void
        {
            this._sharedRegisters = value;
        }
		
		/**
		public function get passes():Vector.<MaterialPassBase>//Vector.<MaterialPassBase>
			return this._passes;
		}
		
		/**
		override public function dispose():void
		{
		
		}
		
		/**
		public function iCreateMethodVO():MethodVO
		{
			return new MethodVO();
		}

		/**
		public function iReset():void
		{
			this.iCleanCompilationData();
		}
		
		/**
		public function iCleanCompilationData():void
		{
		}
		
		/**
		public function iGetVertexCode(vo:MethodVO, regCache:ShaderRegisterCache):String
		{
			return "";
		}
		
		/**
		public function iActivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
		
		}
		
		/**
		public function iSetRenderState(vo:MethodVO, renderable:IRenderable, stage3DProxy:Stage3DProxy, camera:Camera3D):void
		{
		
		}
		
		/**
		public function iDeactivate(vo:MethodVO, stage3DProxy:Stage3DProxy):void
		{
		
		}
		
		/**
		public function pGetTex2DSampleCode(vo:MethodVO, targetReg:ShaderRegisterElement, inputReg:ShaderRegisterElement, texture:TextureProxyBase, uvReg:ShaderRegisterElement = null, forceWrap:String = null):String
		{
			uvReg = uvReg || null;
			forceWrap = forceWrap || null;

			var wrap:String = forceWrap || (vo.repeatTextures? "wrap" : "clamp");
			var filter:String;

			var format:String = this.getFormatStringForTexture(texture);
			var enableMipMaps:Boolean = vo.useMipmapping && texture.hasMipMaps;
			
			if (vo.useSmoothTextures)
				filter = enableMipMaps? "linear,miplinear" : "linear";
			else
				filter = enableMipMaps? "nearest,mipnearest" : "nearest";

            //uvReg ||= _sharedRegisters.uvVarying;
            if ( uvReg == null )
            {

                uvReg = this._sharedRegisters.uvVarying;

            }

			return "tex " + targetReg.toString() + ", " + uvReg.toString() + ", " + inputReg.toString() + " <2d," + filter + "," + format + wrap + ">\n";

		}

		/**
		public function pGetTexCubeSampleCode(vo:MethodVO, targetReg:ShaderRegisterElement, inputReg:ShaderRegisterElement, texture:TextureProxyBase, uvReg:ShaderRegisterElement):String
		{
			var filter:String;
			var format:String = this.getFormatStringForTexture(texture);
			var enableMipMaps:Boolean = vo.useMipmapping && texture.hasMipMaps;
			
			if (vo.useSmoothTextures)
				filter = enableMipMaps? "linear,miplinear" : "linear";
			else
				filter = enableMipMaps? "nearest,mipnearest" : "nearest";
			
			return "tex " + targetReg.toString() + ", " + uvReg.toString() + ", " + inputReg.toString() + " <cube," + format + filter + ">\n";
		}

		/**
		private function getFormatStringForTexture(texture:TextureProxyBase):String
		{
			switch (texture.format) {
				case Context3DTextureFormat.COMPRESSED:
					return "dxt1,";
					break;
				case "compressedAlpha":
					return "dxt5,";
					break;
				default:
					return "";
			}
		}
		
		/**
		public function iInvalidateShaderProgram():void
		{
			this.dispatchEvent(new ShadingMethodEvent(ShadingMethodEvent.SHADER_INVALIDATED));
		}
		
		/**
		public function copyFrom(method:ShadingMethodBase):void
		{
		}
	}
}
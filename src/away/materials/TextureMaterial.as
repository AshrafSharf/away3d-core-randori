///<reference path="../_definitions.ts"/>

package away.materials
{
	import away.textures.Texture2DBase;
	import away.geom.ColorTransform;
	import away.display.BlendMode;
	//import away3d.*;
	//import away3d.textures.*;
	
	//import flash.display.*;
	//import flash.geom.*;
	
	//use namespace arcane;
	
	/**
	public class TextureMaterial extends SinglePassMaterialBase
	{
		/**
		public function TextureMaterial(texture:Texture2DBase = null, smooth:Boolean = true, repeat:Boolean = false, mipmap:Boolean = false):void
		{
			super();


			this.texture = texture;

			this.smooth = smooth;
			this.repeat = repeat;
			this.mipmap = mipmap;

		}

		/**
		public function get animateUVs():Boolean
		{
			return _pScreenPass.animateUVs;
		}
		
		public function set animateUVs(value:Boolean):void
		{
			this._pScreenPass.animateUVs = value;
		}
		
		/**
		public function get alpha():Number
		{
			return _pScreenPass.colorTransform? _pScreenPass.colorTransform.alphaMultiplier : 1;
		}
		
		public function set alpha(value:Number):void
		{
			if (value > 1)
				value = 1;
			else if (value < 0)
				value = 0;

            if ( this.colorTransform == null )
            {
                    //colorTransform ||= new ColorTransform();
                this.colorTransform = new ColorTransform();
            }

			this.colorTransform.alphaMultiplier = value;

            this._pScreenPass.preserveAlpha = this.getRequiresBlending();

            this._pScreenPass.setBlendMode( this.getBlendMode() == BlendMode.NORMAL && this.getRequiresBlending() ? BlendMode.LAYER : this.getBlendMode() );

		}
		
		/**

		public function get texture():Texture2DBase
		{
			return _pScreenPass.diffuseMethod.texture;
		}
		
		public function set texture(value:Texture2DBase):void
		{
            this._pScreenPass.diffuseMethod.texture = value;
		}
		/**
		public function get ambientTexture():Texture2DBase
		{
			return _pScreenPass.ambientMethod.texture;
		}
		
		public function set ambientTexture(value:Texture2DBase):void
		{
            this._pScreenPass.ambientMethod.texture = value;
            this._pScreenPass.diffuseMethod.iUseAmbientTexture = ! (value == null ); // Boolean( value ) //<-------- TODO: Check this works as expected
		}

	}
}
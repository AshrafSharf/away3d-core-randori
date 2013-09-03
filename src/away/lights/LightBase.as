/**

///<reference path="../_definitions.ts" />

package away.lights
{
	import away.entities.Entity;
	import away.lights.shadowmaps.ShadowMapperBase;
	import away.events.LightEvent;
	import away.errors.AbstractMethodError;
	import away.base.IRenderable;
	import away.geom.Matrix3D;
	import away.partition.EntityNode;
	import away.partition.LightNode;
	import away.library.assets.AssetType;
	public class LightBase extends Entity
	{
		
		private var _color:Number = 0xffffff;
		private var _colorR:Number = 1;
		private var _colorG:Number = 1;
		private var _colorB:Number = 1;
		
		private var _ambientColor:Number = 0xffffff;
		private var _ambient:Number = 0;
		public var _iAmbientR:Number = 0;
		public var _iAmbientG:Number = 0;
		public var _iAmbientB:Number = 0;
		
		private var _specular:Number = 1;
		public var _iSpecularR:Number = 1;
		public var _iSpecularG:Number = 1;
		public var _iSpecularB:Number = 1;
		
		private var _diffuse:Number = 1;
		public var _iDiffuseR:Number = 1;
		public var _iDiffuseG:Number = 1;
		public var _iDiffuseB:Number = 1;
		
		private var _castsShadows:Boolean = false;
		
		private var _shadowMapper:ShadowMapperBase;
		
		public function LightBase():void
		{
			super();
		}
		
		public function get castsShadows():Boolean
		{
			return _castsShadows;
		}
		
		public function set castsShadows(value:Boolean):void
		{
			if( this._castsShadows == value )
			{
				return;
			}
			
			this._castsShadows = value;
			
			if( value )
			{

                if ( this._shadowMapper == null )
                {

                    this._shadowMapper = this.pCreateShadowMapper();

                }

				this._shadowMapper.light = this;
			} else {
                this._shadowMapper.dispose();
                this._shadowMapper = null;
			}
			//*/
			this.dispatchEvent(new LightEvent( LightEvent.CASTS_SHADOW_CHANGE) );
		}
		
		public function pCreateShadowMapper():ShadowMapperBase
		{
			throw new AbstractMethodError();
		}

		public function get specular():Number
		{
			return _specular;
		}
		
		public function set specular(value:Number):void
		{
			if( value < 0 )
			{
				value = 0;
			}
			this._specular = value;
			this.updateSpecular();
		}
		
		public function get diffuse():Number
		{
			return _diffuse;
		}
		
		public function set diffuse(value:Number):void
		{
			if (value < 0)
			{
				value = 0;
			}
			this._diffuse = value;
			this.updateDiffuse();
		}
		
		public function get color():Number
		{
			return _color;
		}
		
		public function set color(value:Number):void
		{
			this._color = value;
			this._colorR = ((this._color >> 16) & 0xff)/0xff;
			this._colorG = ((this._color >> 8) & 0xff)/0xff;
			this._colorB = (this._color & 0xff)/0xff;
			this.updateDiffuse();
			this.updateSpecular();
		}
		
		public function get ambient():Number
		{
			return _ambient;
		}
		
		public function set ambient(value:Number):void
		{
			if( value < 0 )
			{
				value = 0;
			}
			else if( value > 1 )
			{
				value = 1;
			}
			this._ambient = value;
			this.updateAmbient();
		}
		
		public function get ambientColor():Number
		{
			return _ambientColor;
		}
		
		public function set ambientColor(value:Number):void
		{
			this._ambientColor = value;
			this.updateAmbient();
		}
		
		private function updateAmbient():void
		{
			_iAmbientR = ((_ambientColor >> 16) & 0xff)/0xff*_ambient;
			_iAmbientG = ((_ambientColor >> 8) & 0xff)/0xff*_ambient;
			_iAmbientB = (_ambientColor & 0xff)/0xff*_ambient;
		}
		
		public function iGetObjectProjectionMatrix(renderable:IRenderable, target:Matrix3D = null):Matrix3D
		{
			throw new AbstractMethodError();
		}
		
		//@override
		override public function pCreateEntityPartitionNode():EntityNode
		{
			return new LightNode( this );
		}
		
		//@override
		override public function get assetType():String
		{
			return AssetType.LIGHT;
		}
		
		private function updateSpecular():void
		{
			_iSpecularR = _colorR*_specular;
			_iSpecularG = _colorG*_specular;
			_iSpecularB = _colorB*_specular;
		}
		
		private function updateDiffuse():void
		{
			_iDiffuseR = _colorR*_diffuse;
			_iDiffuseG = _colorG*_diffuse;
			_iDiffuseB = _colorB*_diffuse;
		}
		
		public function get shadowMapper():ShadowMapperBase
		{
			return _shadowMapper;
		}

		public function set shadowMapper(value:ShadowMapperBase):void
		{
			this._shadowMapper = value;
			this._shadowMapper.light = this;
		}
	}
}
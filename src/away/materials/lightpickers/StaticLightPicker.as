///<reference path="../../_definitions.ts"/>

package away.materials.lightpickers
{
	import away.lights.LightBase;
	import away.lights.PointLight;
	import away.lights.DirectionalLight;
	import away.lights.LightProbe;
	import away.events.LightEvent;
	import away.events.Event;
	//import flash.events.Event;
	
	//import away3d.events.LightEvent;
	//import away3d.lights.DirectionalLight;
	//import away3d.lights.LightBase;
	//import away3d.lights.LightProbe;
	//import away3d.lights.PointLight;

	/**
	public class StaticLightPicker extends LightPickerBase
	{
		private var _lights:Vector.<LightBase>; // not typed in AS3 - should it be lightbase ?
		/**
		public function StaticLightPicker(lights):void
		{
            super();
			this.lights = lights;
		}

		/**
		public function get lights():Vector.<LightBase>
		{
			return _lights;
		}

		public function set lights(value:Vector.<LightBase>):void
		{
			var numPointLights:Number = 0;
			var numDirectionalLights:Number = 0;
			var numCastingPointLights:Number = 0;
			var numCastingDirectionalLights:Number = 0;
			var numLightProbes:Number = 0;
			var light:LightBase;
			
			if (this._lights)
				this.clearListeners();
			
			this._lights = value;
			this._pAllPickedLights = value;
            this._pPointLights = new Vector.<PointLight>();
            this._pCastingPointLights = new Vector.<PointLight>();
            this._pDirectionalLights = new Vector.<DirectionalLight>();
            this._pCastingDirectionalLights = new Vector.<DirectionalLight>();
            this._pLightProbes = new Vector.<LightProbe>();
			
			var len:Number = value.length;

			for (var i:Number = 0; i < len; ++i)
            {
				light = value[i];
				light.addEventListener(LightEvent.CASTS_SHADOW_CHANGE, this.onCastShadowChange , this );

				if (light instanceof PointLight)
                {
					if (light.castsShadows)
						this._pCastingPointLights[numCastingPointLights++] = PointLight(light);
					else
						this._pPointLights[numPointLights++] = PointLight(light);
					
				}
                else if (light instanceof DirectionalLight)
                {
					if (light.castsShadows)
						this._pCastingDirectionalLights[numCastingDirectionalLights++] = DirectionalLight(light);
					else
						this._pDirectionalLights[numDirectionalLights++] = DirectionalLight(light);

				}
                else if (light instanceof LightProbe)
                {
					this._pLightProbes[numLightProbes++] = LightProbe(light);

                }
			}
			
			if (this._pNumDirectionalLights == numDirectionalLights && this._pNumPointLights == numPointLights && this._pNumLightProbes == numLightProbes &&
				this._pNumCastingPointLights == numCastingPointLights && this._pNumCastingDirectionalLights == numCastingDirectionalLights) {
				return;
			}
			
			this._pNumDirectionalLights = numDirectionalLights;
			this._pNumCastingDirectionalLights = numCastingDirectionalLights;
			this._pNumPointLights = numPointLights;
			this._pNumCastingPointLights = numCastingPointLights;
			this._pNumLightProbes = numLightProbes;
			
			// MUST HAVE MULTIPLE OF 4 ELEMENTS!
			this._pLightProbeWeights = new Vector.<Number>(Math.ceil(numLightProbes/4)*4 );
			
			// notify material lights have changed
			this.dispatchEvent(new Event(Event.CHANGE));

		}

		/**
		private function clearListeners():void
		{
			var len:Number = _lights.length;
			for (var i:Number = 0; i < len; ++i)
				_lights[i].removeEventListener(LightEvent.CASTS_SHADOW_CHANGE, onCastShadowChange , this );
		}

		/**
		private function onCastShadowChange(event:LightEvent):void
		{
			// TODO: Assign to special caster collections, just append it to the lights in SinglePass
			// But keep seperated in multipass
			
			var light:LightBase = LightBase(event.target);
			
			if (light instanceof PointLight)
            {

                var pl : PointLight = PointLight(light);
                updatePointCasting( pl );

            }
			else if (light instanceof DirectionalLight)
            {

                var dl : DirectionalLight = DirectionalLight(light);
				updateDirectionalCasting( dl );

            }

			dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		private function updateDirectionalCasting(light:DirectionalLight):void
		{

            var dl : DirectionalLight = DirectionalLight(light);

			if (light.castsShadows)
            {
				-- _pNumDirectionalLights;
				++_pNumCastingDirectionalLights;



				_pDirectionalLights.splice(_pDirectionalLights.indexOf( dl ), 1);
				_pCastingDirectionalLights.push(light);

			}
            else
            {
				++_pNumDirectionalLights;
				--_pNumCastingDirectionalLights;

				_pCastingDirectionalLights.splice(_pCastingDirectionalLights.indexOf( dl ), 1);
				_pDirectionalLights.push(light);
			}
		}

		/**
		private function updatePointCasting(light:PointLight):void
		{

            var pl : PointLight = PointLight(light);

			if (light.castsShadows)
            {

				--_pNumPointLights;
				++_pNumCastingPointLights;
                _pPointLights.splice( _pPointLights.indexOf( pl ), 1);
                _pCastingPointLights.push(light);

			}
            else
            {

				++_pNumPointLights;
				--_pNumCastingPointLights;

                _pCastingPointLights.splice(_pCastingPointLights.indexOf( pl ) , 1);
                _pPointLights.push(light);

			}
		}
	}
}
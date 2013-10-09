/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.loaders.misc
{
	import away.events.EventDispatcher;
	import away.loaders.AssetLoader;
	//import away3d.arcane;
	//import away3d.events.AssetEvent;
	//import away3d.events.LoaderEvent;
	//import away3d.loaders.AssetLoader;
	
	//import flash.events.Event;
	//import flash.events.EventDispatcher;
	
	//use namespace arcane;
	
	
	/**
	//[Event(name="assetComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="resourceComplete", type="away3d.events.LoaderEvent")]
	
	
	/**
	//[Event(name="dependencyComplete", type="away3d.events.LoaderEvent")]
	
	
	/**
	//[Event(name="loadError", type="away3d.events.LoaderEvent")]
	
	
	/**
	//[Event(name="parseError", type="away3d.events.ParserEvent")]
	
	
	/**
	//[Event(name="skyboxComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="cameraComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="meshComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="geometryComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="skeletonComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="skeletonPoseComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="containerComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="textureComplete", type="away3d.events.AssetEvent")]
	
	/**
	//[Event(name="textureProjectorComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="materialComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animatorComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animationSetComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animationStateComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="animationNodeComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="stateTransitionComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="lightComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="lightPickerComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="effectMethodComplete", type="away3d.events.AssetEvent")]
	
	
	/**
	//[Event(name="shadowMapMethodComplete", type="away3d.events.AssetEvent")]
	
	/**
	public class AssetLoaderToken extends EventDispatcher
	{
		public var _iLoader:AssetLoader;
		
		public function AssetLoaderToken(loader:AssetLoader):void
		{
			super();
			
			this._iLoader = loader;
		}
		
		override public function addEventListener(type:String, listener:Function, target:Object):void
		{
            this._iLoader.addEventListener( type, listener, target );
		}


        override public function removeEventListener(type:String, listener:Function, target:Object):void
		{
            this._iLoader.removeEventListener(type, listener, target);
		}
		
		override public function hasEventListener(type:String, listener:Function = null, target:Object = null):Boolean
		{
			listener = listener || null;
			target = target || null;

			return this._iLoader.hasEventListener(type , listener , target );
		}

		/*
	}
}
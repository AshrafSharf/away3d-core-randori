

///<reference path="../_definitions.ts"/>

package away.managers
{
	import away.display.Stage;
	//import away3d.arcane;
	
	//import flash.display.Stage;
	//import flash.utils.Dictionary;
	
	//use namespace arcane;
	
	/**
	public class Stage3DManager
	{
        //private static _instances:Object;
        private static var _instances:Vector.<Stage3DManagerInstanceData>;
		private static var _stageProxies:Vector.<Stage3DProxy>;//.<Stage3DProxy>;
		
		private var _stage:Stage;
		
		/**
		public function Stage3DManager(stage:Stage, stage3DManagerSingletonEnforcer:Stage3DManagerSingletonEnforcer):void
		{
			if (!stage3DManagerSingletonEnforcer)
            {
                throw new Error("This class is a multiton and cannot be instantiated manually. Use Stage3DManager.getInstance instead.");
            }

			this._stage = stage;
			
			if (!Stage3DManager._stageProxies)
            {
                Stage3DManager._stageProxies = new Vector.<Stage3DProxy>( this._stage.stage3Ds.length ) ;//, true);
            }

		}
		
		/**
		public static function getInstance(stage:Stage):Stage3DManager
		{

            var stage3dManager : Stage3DManager = Stage3DManager.getStage3DManagerByStageRef( stage );

            if ( stage3dManager == null)
            {

                stage3dManager = new Stage3DManager( stage , new Stage3DManagerSingletonEnforcer());

                var stageInstanceData : Stage3DManagerInstanceData = new Stage3DManagerInstanceData();
                    stageInstanceData.stage = stage;
                    stageInstanceData.stage3DManager = stage3dManager;

                Stage3DManager._instances.push( stageInstanceData );

            }

			return stage3dManager;

		}

        /**
        private static function getStage3DManagerByStageRef(stage:Stage):Stage3DManager
        {

            if ( Stage3DManager._instances == null )
            {

                Stage3DManager._instances = new Vector.<Stage3DManagerInstanceData>();

            }

            var l : Number = Stage3DManager._instances.length;
            var s : Stage3DManagerInstanceData;

            for ( var c : Number = 0 ; c < l ; c ++ )
            {

                s = Stage3DManager._instances[c];

                if ( s.stage == stage ){

                    return s.stage3DManager;

                }


            }

            return null;

        }

		/**
		public function getStage3DProxy(index:Number, forceSoftware:Boolean = false, profile:String = "baseline"):Stage3DProxy
		{
			if (!Stage3DManager._stageProxies[index])
            {

                Stage3DManager._numStageProxies++;
                Stage3DManager._stageProxies[index] = new Stage3DProxy(index, _stage.stage3Ds[index], this, forceSoftware, profile);

			}
			
			return Stage3DManager._stageProxies[index];
		}
		
		/**
		public function iRemoveStage3DProxy(stage3DProxy:Stage3DProxy):void
		{
            Stage3DManager._numStageProxies--;
            Stage3DManager._stageProxies[ stage3DProxy._iStage3DIndex ] = null;
		}
		
		/**
		public function getFreeStage3DProxy(forceSoftware:Boolean = false, profile:String = "baseline"):Stage3DProxy
		{
			var i:Number = 0;
			var len:Number = Stage3DManager._stageProxies.length;

            //console.log( Stage3DManager._stageProxies );

			while (i < len)
            {

				if ( ! Stage3DManager._stageProxies[i] )
                {

                    getStage3DProxy(i, forceSoftware, profile);

                    Stage3DManager._stageProxies[i].width = _stage.stageWidth;
                    Stage3DManager._stageProxies[i].height = _stage.stageHeight;

					return Stage3DManager._stageProxies[i];

				}

				++i;

			}
			
			throw new Error("Too many Stage3D instances used!");
			return null;

		}
		
		/**
		public function get hasFreeStage3DProxy():Boolean
		{
			return Stage3DManager._numStageProxies < Stage3DManager._stageProxies.length? true : false;
		}
		
		/**
		public function get numProxySlotsFree():Number
		{
			return Stage3DManager._stageProxies.length - Stage3DManager._numStageProxies;
		}
		
		/**
		public function get numProxySlotsUsed():Number
		{
			return Stage3DManager._numStageProxies;
		}
		
		/**
		public function get numProxySlotsTotal():Number
		{
			return Stage3DManager._stageProxies.length;
		}
	}
}
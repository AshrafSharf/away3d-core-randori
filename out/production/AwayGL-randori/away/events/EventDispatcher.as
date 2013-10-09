/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.events {

    /**
    public class EventDispatcher{

        private var listeners:Vector.<Object> = new Vector.<Object>();
        private var lFncLength:Number = 0;

        /**
        public function addEventListener(type:String, listener:Function, target:Object):void {
        
            if ( this.listeners[ type ] === undefined ) {

                this.listeners[ type ] = new Vector.<EventData>();

            }

            if ( this.getEventListenerIndex( type , listener , target ) === -1 ) {

                var d : EventData   = new EventData();
                    d.listener      = listener;
                    d.type          = type;
                    d.target        = target;

                this.listeners[ type ].push( d );

            }

        }
        /**
        public function removeEventListener(type:String, listener:Function, target:Object):void {
        
            var index : Number = this.getEventListenerIndex( type , listener , target );

            if ( index !== - 1 ) {

                this.listeners[ type ].splice( index, 1 );

            }

        }
        /**
        public function dispatchEvent(event:Event):void {
        
            var listenerArray : Vector.<EventData> = Vector.<EventData>(listeners[ event.type ]);

            if (listenerArray != null) {

                this.lFncLength     = listenerArray.length;
                event.target        = this;

                var eventData : EventData;

                for ( var i:int = 0; i < this.lFncLength; ++i ) {

                    eventData = listenerArray[i];
                    eventData.listener.call( eventData.target , event );

                }
            }

        }
        /**
        private function getEventListenerIndex(type:String, listener:Function, target:Object):Number {
        
            if ( this.listeners[ type ] !== undefined ) {

                var a : Vector.<EventData> = Vector.<EventData>(listeners[ type ]);
                var l : Number = a.length;
                var d : EventData;

                for ( var c : Number = 0 ; c < l ; c ++ ){

                    d = a[c];

                    if ( target == d.target && listener == d.listener ){

                        return c;

                    }

                }


            }

            return -1;

        }
        /**

        //todo: hasEventListener - relax check by not requiring target in param

        public function hasEventListener(type:String, listener:Function = null, target:Object = null):Boolean {
        			listener = listener || null;
			target = target || null;


            if ( this.listeners != null && target != null )
            {

                return ( this.getEventListenerIndex( type, listener , target ) !== -1 ) ;

            }
            else
            {

                if ( this.listeners[ type ] !== undefined )
                {

                    var a : Vector.<EventData> = Vector.<EventData>(listeners[ type ]);
                    return ( a.length > 0 );

                }

                return false;


            }

           return false;

        }



    }
   

}
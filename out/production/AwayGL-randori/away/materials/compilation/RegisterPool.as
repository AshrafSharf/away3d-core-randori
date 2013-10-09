/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials.compilation
{
	import away.utils.VectorInit;
	//import flash.utils.Dictionary;
	
	/**
	public class RegisterPool
	{
		private static var _regPool:Object = new Object();//= new Dictionary()
		private static var _regCompsPool:Object = new Object();//new Dictionary()
		
		private var _vectorRegisters:Vector.<ShaderRegisterElement>;//Vector.<ShaderRegisterElement>
		private var _registerComponents;
		
		private var _regName:String = null;
		private var _usedSingleCount:Vector.<Vector.<Number>>;//Vector.<Vector.<uint>>
		private var _usedVectorCount:Vector.<Number>;/*uint*/
		private var _regCount:Number = 0;
		
		private var _persistent:Boolean = false;
		
		/**
		public function RegisterPool(regName:String, regCount:Number, persistent:Boolean = true):void
		{
			this._regName = regName;
            this._regCount = regCount;
            this._persistent = persistent;
            this.initRegisters(regName, regCount);
		}
		
		/**
		public function requestFreeVectorReg():ShaderRegisterElement
		{
			for (var i:Number = 0; i < this._regCount; ++i)
            {

				if (!this.isRegisterUsed(i))
                {
					if (this._persistent)
						this._usedVectorCount[i]++;

					return this._vectorRegisters[i];

				}
			}
			
			throw new Error("Register overflow!");
		}
		
		/**
		public function requestFreeRegComponent():ShaderRegisterElement
		{

            //away.Debug.log( 'RegisterPool' , 'requestFreeRegComponent' , this._regCount);

			for (var i:Number = 0; i < this._regCount; ++i)
            {

                //away.Debug.log( 'RegisterPool' , 'requestFreeRegComponent' , this._regCount , 'this._usedVectorCount:' + this._usedVectorCount[i] );

				if (this._usedVectorCount[i] > 0)
					continue;

				for (var j:Number = 0; j < 4; ++j)
                {

					if (this._usedSingleCount[j][i] == 0)
                    {

						if (this._persistent)
                        {

                            this._usedSingleCount[j][i]++;

                        }

						return this._registerComponents[j][i];

					}
				}
			}
			
			throw new Error("Register overflow!");
		}
		
		/**
		public function addUsage(register:ShaderRegisterElement, usageCount:Number):void
		{
			if (register._component > -1)
            {

                this._usedSingleCount[register._component][register.index] += usageCount;

            }
			else
            {

                this._usedVectorCount[register.index] += usageCount;

            }

		}
		
		/**
		public function removeUsage(register:ShaderRegisterElement):void
		{
			if (register._component > -1)
            {

				if (--this._usedSingleCount[register._component][register.index] < 0)
                {

                    throw new Error("More usages removed than exist!");

                }


			}
            else
            {
				if (--this._usedVectorCount[register.index] < 0)
                {

                    throw new Error("More usages removed than exist!");

                }

			}
		}

		/**
		public function dispose():void
		{
			this._vectorRegisters = null;
            this._registerComponents = null;
            this._usedSingleCount = null;
            this._usedVectorCount = null;
		}
		
		/**
		public function hasRegisteredRegs():Boolean
		{
			for (var i:Number = 0; i < this._regCount; ++i)
            {

				if (this.isRegisterUsed(i))
					return true;

			}
			
			return false;
		}
		
		/**
		private function initRegisters(regName:String, regCount:Number):void
		{
			
			var hash:String = RegisterPool._initPool(regName, regCount);
			
			this._vectorRegisters = RegisterPool._regPool[hash];
			this._registerComponents = RegisterPool._regCompsPool[hash];
			
			this._usedVectorCount = VectorInit.Num(regCount);

            this._usedSingleCount = VectorInit.VecNum(4);
			this._usedSingleCount[0] = VectorInit.Num(regCount );
            this._usedSingleCount[1] = VectorInit.Num(regCount );
            this._usedSingleCount[2] = VectorInit.Num(regCount );
            this._usedSingleCount[3] = VectorInit.Num(regCount );

            //console.log( 'this._usedVectorCount: ' , this._usedVectorCount );
            //console.log( 'this._usedSingleCount: ' , this._usedSingleCount );

		}
		
		private static function _initPool(regName:String, regCount:Number):String
		{
			var hash:String = regName + regCount;
			
			if (RegisterPool._regPool[hash] != undefined)
            {

                return hash;

            }

			var vectorRegisters:Vector.<ShaderRegisterElement> = VectorInit.AnyClass(regCount);///Vector.<ShaderRegisterElement> = new Vector.<ShaderRegisterElement>(regCount, true);
            RegisterPool._regPool[hash] = vectorRegisters;
			
			var registerComponents = [
				[],
				[],
				[],
				[]
				];
            RegisterPool._regCompsPool[hash] = registerComponents;
			
			for (var i:Number = 0; i < regCount; ++i)
            {

				vectorRegisters[i] = new ShaderRegisterElement(regName, i);
				
				for (var j:Number = 0; j < 4; ++j)
                {

                    registerComponents[j][i] = new ShaderRegisterElement(regName, i, j);

                }

			}

            //console.log ( 'RegisterPool._regCompsPool[hash] : ' , RegisterPool._regCompsPool[hash]  );
            //console.log ( 'RegisterPool._regPool[hash] : ' , RegisterPool._regPool[hash]  );

			return hash;
		}


		/**
		private function isRegisterUsed(index:Number):Boolean
		{
			if (this._usedVectorCount[index] > 0)
            {

                return true;

            }

			for (var i:Number = 0; i < 4; ++i)
            {

				if (this._usedSingleCount[i][index] > 0)
                {

                    return true;

                }

			}
			
			return false;
		}
	}
}
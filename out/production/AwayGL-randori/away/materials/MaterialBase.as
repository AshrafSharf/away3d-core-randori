/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.materials
{
	import away.library.assets.NamedAssetBase;
	import away.library.assets.IAsset;
	import away.animators.IAnimationSet;
	import away.core.base.IMaterialOwner;
	import away.core.display.BlendMode;
	import away.materials.passes.MaterialPassBase;
	import away.materials.passes.DepthMapPass;
	import away.materials.passes.DistanceMapPass;
	import away.materials.lightpickers.LightPickerBase;
	import away.core.display3D.Context3DCompareMode;
	import away.events.Event;
	import away.library.assets.AssetType;
	import away.managers.Stage3DProxy;
	import away.cameras.Camera3D;
	import away.core.base.IRenderable;
	import away.core.geom.Matrix3D;
	import away.core.traverse.EntityCollector;
	import away.core.display3D.Context3D;

    /**
    public class MaterialBase extends NamedAssetBase implements IAsset
    {
        /**
        private static var MATERIAL_ID_COUNT:Number = 0;

        /**
        public var extra:Object;

        /**
        public var _iClassification:String = null;//Arcane

        /**
        public var _iUniqueId:Number = 0;//Arcane

        /**
        public var _iRenderOrderId:Number = 0;//Arcane

        /**
        public var _iDepthPassId:Number = 0;//Arcane

        private var _bothSides:Boolean = false;// update
        private var _animationSet:IAnimationSet;

        /**


        private var _owners:Vector.<IMaterialOwner>;//:Vector.<IMaterialOwner>

        private var _alphaPremultiplied:Boolean = false;

        public var _pBlendMode:String = BlendMode.NORMAL;

        private var _numPasses:Number = 0;
        private var _passes:Vector.<MaterialPassBase>;//Vector.<MaterialPassBase>

        public var _pMipmap:Boolean = true;
        private var _smooth:Boolean = true;
        private var _repeat:Boolean = false;// Update

        public var _pDepthPass:DepthMapPass;
        public var _pDistancePass:DistanceMapPass;
        public var _pLightPicker:LightPickerBase;

        private var _distanceBasedDepthRender:Boolean = false;
        public var _pDepthCompareMode:String = Context3DCompareMode.LESS_EQUAL;

        /**
            public function MaterialBase():void
        {

            super(null);

            this._owners = new Vector.< IMaterialOwner>();
            this._passes = new Vector.<MaterialPassBase>();
            this._pDepthPass= new DepthMapPass();
            this._pDistancePass = new DistanceMapPass();

            this._pDepthPass.addEventListener(Event.CHANGE, onDepthPassChange, this );
            this._pDistancePass.addEventListener(Event.CHANGE, onDistancePassChange , this);

            this.alphaPremultiplied= true;

            this._iUniqueId = MaterialBase.MATERIAL_ID_COUNT++;

        }

        /**
        override public function get assetType():String
        {
            return AssetType.MATERIAL;
        }

        /**
        public function get lightPicker():LightPickerBase
        {
            return this._pLightPicker;
        }

        public function set lightPicker(value:LightPickerBase):void
        {

            this.setLightPicker( value );

        }

        public function setLightPicker(value:LightPickerBase):void
        {

            if (value != this._pLightPicker)
            {

                this._pLightPicker = value;
                var len:Number = this._passes.length;

                for (var i:Number = 0; i < len; ++i)
                {

                    this._passes[i].lightPicker = this._pLightPicker;

                }

            }

        }

        /**
        public function get mipmap():Boolean
        {
            return this._pMipmap;
        }

        public function set mipmap(value:Boolean):void
        {

            this.setMipMap( value );

        }

        public function setMipMap(value:Boolean):void
        {

            this._pMipmap = value;

            for (var i:Number = 0; i < this._numPasses; ++i)
            {

                this._passes[i].mipmap = value;

            }

        }

        /**
        public function get smooth():Boolean
        {
            return this._smooth;
        }

        public function set smooth(value:Boolean):void
        {
            this._smooth = value;

            for (var i:Number = 0; i < this._numPasses; ++i)
            {

                this._passes[i].smooth = value;

            }


        }

        /**

        public function get depthCompareMode():String
        {
            return this._pDepthCompareMode;
        }

        public function set depthCompareMode(value:String):void
        {
            this.setDepthCompareMode( value );
        }

        public function setDepthCompareMode(value:String):void
        {
            this._pDepthCompareMode = value;
        }

        /**
        public function get repeat():Boolean
        {
            return this._repeat;
        }

        public function set repeat(value:Boolean):void
        {
            this._repeat = value;


            for (var i:Number = 0; i < this._numPasses; ++i)
            {

                this._passes[i].repeat = value;

            }

        }

        /**
        override public function dispose():void
        {
            var i:Number;

            for (i = 0; i < this._numPasses; ++i)
            {
                this._passes[i].dispose();
            }

            this._pDepthPass.dispose();
            this._pDistancePass.dispose();

            this._pDepthPass.removeEventListener(Event.CHANGE, onDepthPassChange , this );
            this._pDistancePass.removeEventListener(Event.CHANGE, onDistancePassChange , this );

        }

        /**
        public function get bothSides():Boolean
        {
            return this._bothSides;
        }

        public function set bothSides(value:Boolean):void
        {
            this._bothSides = value;


            for (var i:Number = 0; i < this._numPasses; ++i)
            {

                this._passes[i].bothSides = value;

            }

            this._pDepthPass.bothSides = value;
            this._pDistancePass.bothSides = value;

        }

        /**
        public function get blendMode():String
        {
            return this.getBlendMode();
        }

        public function getBlendMode():String
        {
            return this._pBlendMode;
        }

        public function set blendMode(value:String):void
        {
            this.setBlendMode( value );
        }

        public function setBlendMode(value:String):void
        {

            this._pBlendMode = value;

        }

        /**
        public function get alphaPremultiplied():Boolean
        {
            return this._alphaPremultiplied;
        }

        public function set alphaPremultiplied(value:Boolean):void
        {
            this._alphaPremultiplied = value;

            for (var i:Number = 0; i < this._numPasses; ++i)
            {
                this._passes[i].alphaPremultiplied = value;
            }

        }

        /**
        public function get requiresBlending():Boolean
        {

            return this.getRequiresBlending();

        }

        public function getRequiresBlending():Boolean
        {

            return this._pBlendMode != BlendMode.NORMAL;

        }

        /**
        public function get uniqueId():Number
        {
            return this._iUniqueId;
        }

        /**
        public function get _iNumPasses():Number // ARCANE
            return this._numPasses;
        }

        /**

        public function iHasDepthAlphaThreshold():Boolean
        {

            return this._pDepthPass.alphaThreshold > 0;

        }

        /**
        public function iActivateForDepth(stage3DProxy:Stage3DProxy, camera:Camera3D, distanceBased:Boolean = false):void // ARCANE


            this._distanceBasedDepthRender = distanceBased;

            if (distanceBased)
            {

                this._pDistancePass.iActivate(stage3DProxy, camera);

            }
            else
            {

                this._pDepthPass.iActivate(stage3DProxy, camera);

            }

        }

        /**
        public function iDeactivateForDepth(stage3DProxy:Stage3DProxy):void
        {


            if (this._distanceBasedDepthRender)
            {

                this._pDistancePass.iDeactivate(stage3DProxy);

            }
            else
            {

                this._pDepthPass.iDeactivate(stage3DProxy);

            }


        }
        /**
        public function iRenderDepth(renderable:IRenderable, stage3DProxy:Stage3DProxy, camera:Camera3D, viewProjection:Matrix3D):void // ARCANE

            if (this._distanceBasedDepthRender)
            {

                if (renderable.animator)
                {

                    this._pDistancePass.iUpdateAnimationState(renderable, stage3DProxy, camera);

                }


                this._pDistancePass.iRender(renderable, stage3DProxy, camera, viewProjection);

            }
            else
            {
                if (renderable.animator)
                {

                    this._pDepthPass.iUpdateAnimationState(renderable, stage3DProxy, camera);

                }


                this._pDepthPass.iRender(renderable, stage3DProxy, camera, viewProjection);

            }


        }
        //*/
        /**

        public function iPassRendersToTexture(index:Number):Boolean
        {

            return this._passes[index].renderToTexture;

        }

        /**

        public function iActivatePass(index:Number, stage3DProxy:Stage3DProxy, camera:Camera3D):void // ARCANE
            this._passes[index].iActivate(stage3DProxy, camera);

        }

        /**

        public function iDeactivatePass(index:Number, stage3DProxy:Stage3DProxy):void // ARCANE
            this._passes[index].iDeactivate(stage3DProxy);
        }

        /**
        public function iRenderPass(index:Number, renderable:IRenderable, stage3DProxy:Stage3DProxy, entityCollector:EntityCollector, viewProjection:Matrix3D):void
        {
            if (this._pLightPicker)
            {

                this._pLightPicker.collectLights(renderable, entityCollector);

            }

            var pass:MaterialPassBase = this._passes[index];

            if (renderable.animator)
            {

                pass.iUpdateAnimationState(renderable, stage3DProxy, entityCollector.camera);

            }


            pass.iRender(renderable, stage3DProxy, entityCollector.camera, viewProjection);

        }

        //
        // MATERIAL MANAGEMENT
        //
        /**

        public function iAddOwner(owner:IMaterialOwner):void // ARCANE
            this._owners.push(owner);

            if (owner.animator) {

                if (this._animationSet && owner.animator.animationSet != this._animationSet)
                {

                    throw new Error("A Material instance cannot be shared across renderables with different animator libraries");

                }
                else
                {

                    if (this._animationSet != owner.animator.animationSet)
                    {

                        this._animationSet = owner.animator.animationSet;

                        for (var i:Number = 0; i < this._numPasses; ++i){

                            this._passes[i].animationSet = this._animationSet;

                        }

                        this._pDepthPass.animationSet = this._animationSet;
                        this._pDistancePass.animationSet = this._animationSet;

                        this.iInvalidatePasses( null );//this.invalidatePasses(null);

                    }
                }
            }
        }
        //*/
        /**

        public function iRemoveOwner(owner:IMaterialOwner):void // ARCANE
            this._owners.splice(this._owners.indexOf(owner), 1);

            if (this._owners.length == 0)
            {
                this._animationSet = null;

                for (var i:Number = 0; i < this._numPasses; ++i)
                {

                    this._passes[i].animationSet = this._animationSet;

                }

                this._pDepthPass.animationSet = this._animationSet;
                this._pDistancePass.animationSet = this._animationSet;
                this.iInvalidatePasses(null);
            }
        }
        //*/
        /**
        public function get iOwners():Vector.<IMaterialOwner>//Vector.<IMaterialOwner> // ARCANE
            return this._owners;
        }

        /**
        public function iUpdateMaterial(context:Context3D):void // ARCANE
            //throw new away.errors.AbstractMethodError();
        }

        /**
        public function iDeactivate(stage3DProxy:Stage3DProxy):void // ARCANE

            this._passes[this._numPasses - 1].iDeactivate(stage3DProxy);

        }
        /**

        public function iInvalidatePasses(triggerPass:MaterialPassBase):void
        {
            var owner:IMaterialOwner;

            var l : Number;
            var c : Number;

            this._pDepthPass.iInvalidateShaderProgram();
            this._pDistancePass.iInvalidateShaderProgram();

            // test if the depth and distance passes support animating the animation set in the vertex shader
            // if any object using this material fails to support accelerated animations for any of the passes,
            // we should do everything on cpu (otherwise we have the cost of both gpu + cpu animations)

            if (this._animationSet)
            {

                this._animationSet.resetGPUCompatibility();

                l = this._owners.length;

                for ( c = 0 ; c < l ;c ++ )
                {

                    owner = this._owners[c];

                    if (owner.animator)
                    {

                        owner.animator.testGPUCompatibility(this._pDepthPass);
                        owner.animator.testGPUCompatibility(this._pDistancePass);

                    }

                }

            }

            for (var i:Number = 0; i < this._numPasses; ++i)
            {
                // only invalidate the pass if it wasn't the triggering pass
                if (this._passes[i] != triggerPass)
                {

                    this._passes[i].iInvalidateShaderProgram(false);

                }


                // test if animation will be able to run on gpu BEFORE compiling materials
                // test if the pass supports animating the animation set in the vertex shader
                // if any object using this material fails to support accelerated animations for any of the passes,
                // we should do everything on cpu (otherwise we have the cost of both gpu + cpu animations)
                if (this._animationSet)
                {


                    l = this._owners.length;

                    for ( c = 0 ; c < l ;c ++ )
                    {

                        owner = this._owners[c];

                        if (owner.animator)
                        {

                            owner.animator.testGPUCompatibility(this._passes[i]);

                        }

                    }

                }
            }
        }

        /**

        public function pRemovePass(pass:MaterialPassBase):void // protected
            this._passes.splice(this._passes.indexOf(pass), 1);
            --this._numPasses;
        }

        /**

        public function pClearPasses():void
        {
            for (var i:Number = 0; i < this._numPasses; ++i)
            {

                this._passes[i].removeEventListener(Event.CHANGE, onPassChange , this );

            }


            this._passes.length = 0;
            this._numPasses = 0;
        }

        /**

        public function pAddPass(pass:MaterialPassBase):void
        {
            this._passes[this._numPasses++] = pass;
            pass.animationSet = this._animationSet;
            pass.alphaPremultiplied = this._alphaPremultiplied;
            pass.mipmap = this._pMipmap;
            pass.smooth = this._smooth;
            pass.repeat = this._repeat;
            pass.lightPicker = this._pLightPicker;
            pass.bothSides = this._bothSides;
            pass.addEventListener(Event.CHANGE, onPassChange , this );
            this.iInvalidatePasses(null);

        }

        /**

        private function onPassChange(event:Event):void
        {
            var mult:Number = 1;
            var ids:Vector.<Number>;////Vector.<int>;
            var len:Number;

            this._iRenderOrderId = 0;

            for (var i:Number = 0; i < this._numPasses; ++i)
            {

                ids = this._passes[i]._iProgram3Dids;
                len = ids.length;

                for (var j:Number = 0; j < len; ++j)
                {

                    if (ids[j] != -1)
                    {

                        this._iRenderOrderId += mult*ids[j];
                        j = len;

                    }

                }

                mult *= 1000;
            }
        }

        /**
        private function onDistancePassChange(event:Event):void
        {

            var ids:Vector.<Number> = this._pDistancePass._iProgram3Dids;
            var len:Number = ids.length;

            this._iDepthPassId = 0;

            for (var j:Number = 0; j < len; ++j)
            {
                if (ids[j] != -1)
                {

                    this._iDepthPassId += ids[j];
                    j = len;

                }

            }


        }

        /**

        private function onDepthPassChange(event:Event):void
        {

            var ids:Vector.<Number> = this._pDepthPass._iProgram3Dids;
            var len:Number = ids.length;

            this._iDepthPassId = 0;

            for (var j:Number = 0; j < len; ++j)
            {

                if (ids[j] != -1)
                {

                    this._iDepthPassId += ids[j];
                    j = len;

                }

            }


        }

    }
}
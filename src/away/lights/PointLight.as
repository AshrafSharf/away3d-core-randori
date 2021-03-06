/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.lights
{
	import away.lights.shadowmaps.ShadowMapperBase;
	import away.lights.shadowmaps.CubeMapShadowMapper;
	import away.core.partition.EntityNode;
	import away.core.partition.PointLightNode;
	import away.core.geom.Vector3D;
	import away.bounds.BoundingVolumeBase;
	import away.bounds.BoundingSphere;
	import away.core.base.IRenderable;
	import away.core.geom.Matrix3D;
	public class PointLight extends LightBase
	{
		
		public var _pRadius:Number = 90000;
		public var _pFallOff:Number = 100000;
		public var _pFallOffFactor:Number = 0;
		
		public function PointLight():void
		{
			super();
			this._pFallOffFactor = 1/(this._pFallOff*this._pFallOff - this._pRadius*this._pRadius);
		}
		
		override public function pCreateShadowMapper():ShadowMapperBase
		{
			return new CubeMapShadowMapper();
		}
		
		override public function pCreateEntityPartitionNode():EntityNode
		{
			return new PointLightNode( this );
		}
		
		public function get radius():Number
		{
			return this._pRadius;
		}
		
		public function set radius(value:Number):void
		{
			this._pRadius = value;
			if (this._pRadius < 0)
			{
				this._pRadius = 0;
			}
			else if( this._pRadius > this._pFallOff )
			{
				this._pFallOff = this._pRadius;
				this.pInvalidateBounds();
			}
			this._pFallOffFactor = 1/( this._pFallOff*this._pFallOff - this._pRadius*this._pRadius );
		}
		
		public function iFallOffFactor():Number
		{
			return this._pFallOffFactor;
		}
		
		public function get fallOff():Number
		{
			return this._pFallOff;
		}
		
		public function set fallOff(value:Number):void
		{
			this._pFallOff = value;
			if( this._pFallOff < 0)
			{
				this._pFallOff = 0;
			}
			if( this._pFallOff < this._pRadius )
			{
				this._pRadius = this._pFallOff;
			}
			this._pFallOffFactor = 1/( this._pFallOff*this._pFallOff - this._pRadius*this._pRadius);
			this.pInvalidateBounds();
		}
		
		override public function pUpdateBounds():void
		{
			this._pBounds.fromSphere( new Vector3D(), this._pFallOff );
			this._pBoundsInvalid = false;
		}
		
		override public function pGetDefaultBoundingVolume():BoundingVolumeBase
		{
			return new BoundingSphere();
		}
		
		override public function iGetObjectProjectionMatrix(renderable:IRenderable, target:Matrix3D = null):Matrix3D
		{
			target = target || null;

			var raw:Vector.<Number> = new Vector.<Number>();
			var bounds:BoundingVolumeBase = renderable.sourceEntity.bounds;
			var m:Matrix3D = new Matrix3D();
			
			// todo: do not use lookAt on Light
			m.copyFrom( renderable.sceneTransform );
			m.append( this._pParent.inverseSceneTransform );
			this.lookAt( m.position );
			
			m.copyFrom( renderable.sceneTransform );
			m.append( this.inverseSceneTransform );
			m.copyColumnTo( 3, this._pPos );
			
			var v1:Vector3D = m.deltaTransformVector( bounds.min );
			var v2:Vector3D = m.deltaTransformVector( bounds.max );
			var z:Number = this._pPos.z;
			var d1:Number = v1.x*v1.x + v1.y*v1.y + v1.z*v1.z;
			var d2:Number = v2.x*v2.x + v2.y*v2.y + v2.z*v2.z;
			var d:Number = Math.sqrt(d1 > d2? d1 : d2);
			var zMin:Number;
			var zMax:Number;
			
			zMin = z - d;
			zMax = z + d;
			
			raw[0] =  zMin/d;
			raw[5] = raw[0]
			raw[10] = zMax/(zMax - zMin);
			raw[11] = 1;
			raw[15] =  0;
			raw[13] = raw[15]
			raw[12] = raw[13]
			raw[9] = raw[12]
			raw[8] = raw[9]
			raw[7] = raw[8]
			raw[6] = raw[7]
			raw[4] = raw[6]
			raw[3] = raw[4]
			raw[2] = raw[3]
			raw[1] = raw[2]
			raw[14] = -zMin*raw[10];
			
			if(!target)
			{
				target = new Matrix3D();
			}
			target.copyRawDataFrom(raw);
			target.prepend(m);
			
			return target;
		}
	}
}
/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.animators
{
	import away.managers.Stage3DProxy;
	import away.core.base.IRenderable;
	import away.cameras.Camera3D;
	import away.materials.passes.MaterialPassBase;
	import away.entities.Mesh;
	import away.animators.nodes.AnimationNodeBase;
	import away.animators.states.AnimationStateBase;
	//import away3d.animators.nodes.*;
	//import away3d.animators.states.*;
	//import away3d.cameras.Camera3D;
	//import away3d.core.base.*;
	//import away3d.managers.*;
	//import away3d.entities.*;
	//import away3d.materials.passes.*;
	
	/**
	public interface IAnimator
	{
		/**
		function get animationSet():IAnimationSet; //GET
		/**
		function setRenderState(stage3DProxy:Stage3DProxy, renderable:IRenderable, vertexConstantOffset:Number, vertexStreamOffset:Number, camera:Camera3D):void;
		
		/**
		function testGPUCompatibility(pass:MaterialPassBase):void;
		
		/**
		function addOwner(mesh:Mesh):void;
		
		/**
		function removeOwner(mesh:Mesh):void;
		
		function getAnimationState(node:AnimationNodeBase):AnimationStateBase;
		
		function getAnimationStateByName(name:String):AnimationStateBase;
		
		/**
		function clone():IAnimator;
		
		function dispose():void;
	}
}
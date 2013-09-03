///<reference path="../_definitions.ts" />
package away.base
{
	import away.geom.Matrix3D;
	import away.entities.Entity;
	import away.geom.Matrix;
	import away.cameras.Camera3D;
	import away.managers.Stage3DProxy;
	import away.display3D.IndexBuffer3D;
	//import away3d.cameras.Camera3D;
	//import away3d.managers.Stage3DProxy;
	//import away3d.entities.Entity;
	
	//import flash.display3D.IndexBuffer3D;
	//import flash.geom.Matrix;
	//import flash.geom.Matrix3D;
	
	/**
	public interface IRenderable extends IMaterialOwner
	{
		/**
		function get sceneTransform():Matrix3D; // GET
		/**
		function getRenderSceneTransform(camera:Camera3D):Matrix3D;
		
		/**
		function get inverseSceneTransform():Matrix3D; //GET
		/**
		function get mouseEnabled():Boolean; //GET
		/**
		function get sourceEntity():Entity; // GET
		/**
		function get castsShadows():Boolean; //GET
		/**
		function get uvTransform():Matrix;//GET
		function get shaderPickingDetails():Boolean;//GET
		/**
		function get numVertices():Number;//GET
		/**
		function get numTriangles():Number;//GET
		/**
		function get vertexStride():Number;//GET
		/**

		function activateVertexBuffer(index:Number, stage3DProxy:Stage3DProxy):void;
		
		/**

		function activateUVBuffer(index:Number, stage3DProxy:Stage3DProxy):void;
		
		/**

		function activateSecondaryUVBuffer(index:Number, stage3DProxy:Stage3DProxy):void;
		
		/**

		function activateVertexNormalBuffer(index:Number, stage3DProxy:Stage3DProxy):void;
		
		/**

		function activateVertexTangentBuffer(index:Number, stage3DProxy:Stage3DProxy):void;
		
		/**
		function getIndexBuffer(stage3DProxy:Stage3DProxy):IndexBuffer3D;
		
		/**
        function get vertexData():Vector.<Number>; //GET
		/**
		function get vertexNormalData():Vector.<Number>;//GET
		/**
		function get vertexTangentData():Vector.<Number>;//GET
		/**
		function get indexData():Vector.<Number> /*uint*///GET
		/**
		function get UVData():Vector.<Number>;//GET
}
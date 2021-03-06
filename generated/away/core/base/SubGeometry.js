/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:07 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.core == "undefined")
	away.core = {};
if (typeof away.core.base == "undefined")
	away.core.base = {};

away.core.base.SubGeometry = function() {
	this._secondaryUvsInvalid = away.utils.VectorInit.Bool(8, false);
	this._secondaryUvs = null;
	this._secondaryUvBuffer = away.utils.VectorInit.AnyClass(8);
	this._numVertices = 0;
	this._uvBuffer = away.utils.VectorInit.AnyClass(8);
	this._normalsInvalid = away.utils.VectorInit.Bool(8, false);
	this._vertexNormalBufferContext = away.utils.VectorInit.AnyClass(8);
	this._vertexTangents = null;
	this._tangentsInvalid = away.utils.VectorInit.Bool(8, false);
	this._uvsInvalid = away.utils.VectorInit.Bool(8, false);
	this._vertexBuffer = away.utils.VectorInit.AnyClass(8);
	this._vertexTangentBufferContext = away.utils.VectorInit.AnyClass(8);
	this._uvBufferContext = away.utils.VectorInit.AnyClass(8);
	this._vertexNormalBuffer = away.utils.VectorInit.AnyClass(8);
	this._vertexNormals = null;
	this._vertexTangentBuffer = away.utils.VectorInit.AnyClass(8);
	this._secondaryUvBufferContext = away.utils.VectorInit.AnyClass(8);
	this._uvs = null;
	this._vertexBufferContext = away.utils.VectorInit.AnyClass(8);
	this._verticesInvalid = away.utils.VectorInit.Bool(8, false);
	away.core.base.SubGeometryBase.call(this);
};

away.core.base.SubGeometry.prototype.get_numVertices = function() {
	return this._numVertices;
};

away.core.base.SubGeometry.prototype.activateVertexBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (!this._vertexBuffer[contextIndex] || this._vertexBufferContext[contextIndex] != context) {
		this._vertexBuffer[contextIndex] = context.createVertexBuffer(this._numVertices, 3);
		this._vertexBufferContext[contextIndex] = context;
		this._verticesInvalid[contextIndex] = true;
	}
	if (this._verticesInvalid[contextIndex]) {
		this._vertexBuffer[contextIndex].uploadFromArray(this._vertexData, 0, this._numVertices);
		this._verticesInvalid[contextIndex] = false;
	}
	context.setVertexBufferAt(index, this._vertexBuffer[contextIndex], 0, away.core.display3D.Context3DVertexBufferFormat.FLOAT_3);
};

away.core.base.SubGeometry.prototype.activateUVBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (this._autoGenerateUVs && this._uvsDirty) {
		this._uvs = this.pUpdateDummyUVs(this._uvs);
	}
	if (!this._uvBuffer[contextIndex] || this._uvBufferContext[contextIndex] != context) {
		this._uvBuffer[contextIndex] = context.createVertexBuffer(this._numVertices, 2);
		this._uvBufferContext[contextIndex] = context;
		this._uvsInvalid[contextIndex] = true;
	}
	if (this._uvsInvalid[contextIndex]) {
		this._uvBuffer[contextIndex].uploadFromArray(this._uvs, 0, this._numVertices);
		this._uvsInvalid[contextIndex] = false;
	}
	context.setVertexBufferAt(index, this._uvBuffer[contextIndex], 0, away.core.display3D.Context3DVertexBufferFormat.FLOAT_2);
};

away.core.base.SubGeometry.prototype.activateSecondaryUVBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (!this._secondaryUvBuffer[contextIndex] || this._secondaryUvBufferContext[contextIndex] != context) {
		this._secondaryUvBuffer[contextIndex] = context.createVertexBuffer(this._numVertices, 2);
		this._secondaryUvBufferContext[contextIndex] = context;
		this._secondaryUvsInvalid[contextIndex] = true;
	}
	if (this._secondaryUvsInvalid[contextIndex]) {
		this._secondaryUvBuffer[contextIndex].uploadFromArray(this._secondaryUvs, 0, this._numVertices);
		this._secondaryUvsInvalid[contextIndex] = false;
	}
	context.setVertexBufferAt(index, this._secondaryUvBuffer[contextIndex], 0, away.core.display3D.Context3DVertexBufferFormat.FLOAT_2);
};

away.core.base.SubGeometry.prototype.activateVertexNormalBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (this._autoDeriveVertexNormals && this._vertexNormalsDirty) {
		this._vertexNormals = this.pUpdateVertexNormals(this._vertexNormals);
	}
	if (!this._vertexNormalBuffer[contextIndex] || this._vertexNormalBufferContext[contextIndex] != context) {
		this._vertexNormalBuffer[contextIndex] = context.createVertexBuffer(this._numVertices, 3);
		this._vertexNormalBufferContext[contextIndex] = context;
		this._normalsInvalid[contextIndex] = true;
	}
	if (this._normalsInvalid[contextIndex]) {
		this._vertexNormalBuffer[contextIndex].uploadFromArray(this._vertexNormals, 0, this._numVertices);
		this._normalsInvalid[contextIndex] = false;
	}
	context.setVertexBufferAt(index, this._vertexNormalBuffer[contextIndex], 0, away.core.display3D.Context3DVertexBufferFormat.FLOAT_3);
};

away.core.base.SubGeometry.prototype.activateVertexTangentBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (this._vertexTangentsDirty) {
		this._vertexTangents = this.pUpdateVertexTangents(this._vertexTangents);
	}
	if (!this._vertexTangentBuffer[contextIndex] || this._vertexTangentBufferContext[contextIndex] != context) {
		this._vertexTangentBuffer[contextIndex] = context.createVertexBuffer(this._numVertices, 3);
		this._vertexTangentBufferContext[contextIndex] = context;
		this._tangentsInvalid[contextIndex] = true;
	}
	if (this._tangentsInvalid[contextIndex]) {
		this._vertexTangentBuffer[contextIndex].uploadFromArray(this._vertexTangents, 0, this._numVertices);
		this._tangentsInvalid[contextIndex] = false;
	}
	context.setVertexBufferAt(index, this._vertexTangentBuffer[contextIndex], 0, away.core.display3D.Context3DVertexBufferFormat.FLOAT_3);
};

away.core.base.SubGeometry.prototype.applyTransformation = function(transform) {
	away.core.base.SubGeometryBase.prototype.applyTransformation.call(this,transform);
	this.pInvalidateBuffers(this._verticesInvalid);
	this.pInvalidateBuffers(this._normalsInvalid);
	this.pInvalidateBuffers(this._tangentsInvalid);
};

away.core.base.SubGeometry.prototype.clone = function() {
	var clone = new away.core.base.SubGeometry();
	clone.updateVertexData(this._vertexData.concat());
	clone.updateUVData(this._uvs.concat());
	clone.updateIndexData(this._indices.concat());
	if (this._secondaryUvs) {
		clone.updateSecondaryUVData(this._secondaryUvs.concat());
	}
	if (!this._autoDeriveVertexNormals) {
		clone.updateVertexNormalData(this._vertexNormals.concat());
	}
	if (!this._autoDeriveVertexTangents) {
		clone.updateVertexTangentData(this._vertexTangents.concat());
	}
	return clone;
};

away.core.base.SubGeometry.prototype.scale = function(scale) {
	away.core.base.SubGeometryBase.prototype.scale.call(this,scale);
	this.pInvalidateBuffers(this._verticesInvalid);
};

away.core.base.SubGeometry.prototype.scaleUV = function(scaleU, scaleV) {
	scaleU = scaleU || 1;
	scaleV = scaleV || 1;
	away.core.base.SubGeometryBase.prototype.scaleUV.call(this,scaleU, scaleV);
	this.pInvalidateBuffers(this._uvsInvalid);
};

away.core.base.SubGeometry.prototype.dispose = function() {
	away.core.base.SubGeometryBase.prototype.dispose.call(this);
	this.pDisposeAllVertexBuffers();
	this._vertexBuffer = null;
	this._vertexNormalBuffer = null;
	this._uvBuffer = null;
	this._secondaryUvBuffer = null;
	this._vertexTangentBuffer = null;
	this._indexBuffer = null;
	this._uvs = null;
	this._secondaryUvs = null;
	this._vertexNormals = null;
	this._vertexTangents = null;
	this._vertexBufferContext = null;
	this._uvBufferContext = null;
	this._secondaryUvBufferContext = null;
	this._vertexNormalBufferContext = null;
	this._vertexTangentBufferContext = null;
};

away.core.base.SubGeometry.prototype.pDisposeAllVertexBuffers = function() {
	this.pDisposeVertexBuffers(this._vertexBuffer);
	this.pDisposeVertexBuffers(this._vertexNormalBuffer);
	this.pDisposeVertexBuffers(this._uvBuffer);
	this.pDisposeVertexBuffers(this._secondaryUvBuffer);
	this.pDisposeVertexBuffers(this._vertexTangentBuffer);
};

away.core.base.SubGeometry.prototype.get_vertexData = function() {
	return this._vertexData;
};

away.core.base.SubGeometry.prototype.get_vertexPositionData = function() {
	return this._vertexData;
};

away.core.base.SubGeometry.prototype.updateVertexData = function(vertices) {
	if (this._autoDeriveVertexNormals) {
		this._vertexNormalsDirty = true;
	}
	if (this._autoDeriveVertexTangents) {
		this._vertexTangentsDirty = true;
	}
	this._faceNormalsDirty = true;
	this._vertexData = vertices;
	var numVertices = vertices.length / 3;
	if (numVertices != this._numVertices) {
		this.pDisposeAllVertexBuffers();
	}
	this._numVertices = numVertices;
	this.pInvalidateBuffers(this._verticesInvalid);
	this.pInvalidateBounds();
};

away.core.base.SubGeometry.prototype.get_UVData = function() {
	if (this._uvsDirty && this._autoGenerateUVs) {
		this._uvs = this.pUpdateDummyUVs(this._uvs);
	}
	return this._uvs;
};

away.core.base.SubGeometry.prototype.get_secondaryUVData = function() {
	return this._secondaryUvs;
};

away.core.base.SubGeometry.prototype.updateUVData = function(uvs) {
	if (this._autoDeriveVertexTangents) {
		this._vertexTangentsDirty = true;
	}
	this._faceTangentsDirty = true;
	this._uvs = uvs;
	this.pInvalidateBuffers(this._uvsInvalid);
};

away.core.base.SubGeometry.prototype.updateSecondaryUVData = function(uvs) {
	this._secondaryUvs = uvs;
	this.pInvalidateBuffers(this._secondaryUvsInvalid);
};

away.core.base.SubGeometry.prototype.get_vertexNormalData = function() {
	if (this._autoDeriveVertexNormals && this._vertexNormalsDirty) {
		this._vertexNormals = this.pUpdateVertexNormals(this._vertexNormals);
	}
	return this._vertexNormals;
};

away.core.base.SubGeometry.prototype.updateVertexNormalData = function(vertexNormals) {
	this._vertexNormalsDirty = false;
	this._autoDeriveVertexNormals = (vertexNormals == null);
	this._vertexNormals = vertexNormals;
	this.pInvalidateBuffers(this._normalsInvalid);
};

away.core.base.SubGeometry.prototype.get_vertexTangentData = function() {
	if (this._autoDeriveVertexTangents && this._vertexTangentsDirty) {
		this._vertexTangents = this.pUpdateVertexTangents(this._vertexTangents);
	}
	return this._vertexTangents;
};

away.core.base.SubGeometry.prototype.updateVertexTangentData = function(vertexTangents) {
	this._vertexTangentsDirty = false;
	this._autoDeriveVertexTangents = (vertexTangents == null);
	this._vertexTangents = vertexTangents;
	this.pInvalidateBuffers(this._tangentsInvalid);
};

away.core.base.SubGeometry.prototype.fromVectors = function(vertices, uvs, normals, tangents) {
	this.updateVertexData(vertices);
	this.updateUVData(uvs);
	this.updateVertexNormalData(normals);
	this.updateVertexTangentData(tangents);
};

away.core.base.SubGeometry.prototype.pUpdateVertexNormals = function(target) {
	this.pInvalidateBuffers(this._normalsInvalid);
	return away.core.base.SubGeometryBase.prototype.pUpdateVertexNormals.call(this,target);
};

away.core.base.SubGeometry.prototype.pUpdateVertexTangents = function(target) {
	if (this._vertexNormalsDirty) {
		this._vertexNormals = this.pUpdateVertexNormals(this._vertexNormals);
	}
	this.pInvalidateBuffers(this._tangentsInvalid);
	return away.core.base.SubGeometryBase.prototype.pUpdateVertexTangents.call(this,target);
};

away.core.base.SubGeometry.prototype.pUpdateDummyUVs = function(target) {
	this.pInvalidateBuffers(this._uvsInvalid);
	return away.core.base.SubGeometryBase.prototype.pUpdateDummyUVs.call(this,target);
};

away.core.base.SubGeometry.prototype.pDisposeForStage3D = function(stage3DProxy) {
	var index = stage3DProxy._iStage3DIndex;
	if (this._vertexBuffer[index]) {
		this._vertexBuffer[index].dispose();
		this._vertexBuffer[index] = null;
	}
	if (this._uvBuffer[index]) {
		this._uvBuffer[index].dispose();
		this._uvBuffer[index] = null;
	}
	if (this._secondaryUvBuffer[index]) {
		this._secondaryUvBuffer[index].dispose();
		this._secondaryUvBuffer[index] = null;
	}
	if (this._vertexNormalBuffer[index]) {
		this._vertexNormalBuffer[index].dispose();
		this._vertexNormalBuffer[index] = null;
	}
	if (this._vertexTangentBuffer[index]) {
		this._vertexTangentBuffer[index].dispose();
		this._vertexTangentBuffer[index] = null;
	}
	if (this._indexBuffer[index]) {
		this._indexBuffer[index].dispose();
		this._indexBuffer[index] = null;
	}
};

away.core.base.SubGeometry.prototype.get_vertexStride = function() {
	return 3;
};

away.core.base.SubGeometry.prototype.get_vertexTangentStride = function() {
	return 3;
};

away.core.base.SubGeometry.prototype.get_vertexNormalStride = function() {
	return 3;
};

away.core.base.SubGeometry.prototype.get_UVStride = function() {
	return 2;
};

away.core.base.SubGeometry.prototype.get_secondaryUVStride = function() {
	return 2;
};

away.core.base.SubGeometry.prototype.get_vertexOffset = function() {
	return 0;
};

away.core.base.SubGeometry.prototype.get_vertexNormalOffset = function() {
	return 0;
};

away.core.base.SubGeometry.prototype.get_vertexTangentOffset = function() {
	return 0;
};

away.core.base.SubGeometry.prototype.get_UVOffset = function() {
	return 0;
};

away.core.base.SubGeometry.prototype.get_secondaryUVOffset = function() {
	return 0;
};

away.core.base.SubGeometry.prototype.cloneWithSeperateBuffers = function() {
	var obj = this.clone();
	return obj;
};

$inherit(away.core.base.SubGeometry, away.core.base.SubGeometryBase);

away.core.base.SubGeometry.className = "away.core.base.SubGeometry";

away.core.base.SubGeometry.getRuntimeDependencies = function(t) {
	var p;
	p = [];
	p.push('away.core.display3D.Context3DVertexBufferFormat');
	return p;
};

away.core.base.SubGeometry.getStaticDependencies = function(t) {
	var p;
	p = [];
	p.push('away.utils.VectorInit');
	return p;
};

away.core.base.SubGeometry.injectionPoints = function(t) {
	var p;
	switch (t) {
		case 1:
			p = away.core.base.SubGeometryBase.injectionPoints(t);
			break;
		case 2:
			p = away.core.base.SubGeometryBase.injectionPoints(t);
			break;
		case 3:
			p = away.core.base.SubGeometryBase.injectionPoints(t);
			break;
		default:
			p = [];
			break;
	}
	return p;
};


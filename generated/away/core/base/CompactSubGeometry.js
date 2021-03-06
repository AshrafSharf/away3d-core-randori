/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:00 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.core == "undefined")
	away.core = {};
if (typeof away.core.base == "undefined")
	away.core.base = {};

away.core.base.CompactSubGeometry = function() {
	this._pActiveBuffer = null;
	this._pVertexDataInvalid = away.utils.VectorInit.Bool(8, false);
	this._activeContext = null;
	this._pActiveDataInvalid = false;
	this._bufferContext = away.utils.VectorInit.AnyClass(8);
	this._vertexBuffer = away.utils.VectorInit.AnyClass(8);
	this._contextIndex = 0;
	this._isolatedVertexPositionData = null;
	this._pNumVertices = 0;
	this._isolatedVertexPositionDataDirty = false;
	away.core.base.SubGeometryBase.call(this);
	this._autoDeriveVertexNormals = false;
	this._autoDeriveVertexTangents = false;
};

away.core.base.CompactSubGeometry.prototype.get_numVertices = function() {
	return this._pNumVertices;
};

away.core.base.CompactSubGeometry.prototype.updateData = function(data) {
	if (this._autoDeriveVertexNormals) {
		this._vertexNormalsDirty = true;
	}
	if (this._autoDeriveVertexTangents) {
		this._vertexTangentsDirty = true;
	}
	this._faceNormalsDirty = true;
	this._faceTangentsDirty = true;
	this._isolatedVertexPositionDataDirty = true;
	this._vertexData = data;
	var numVertices = this._vertexData.length / 13;
	if (numVertices != this._pNumVertices) {
		this.pDisposeVertexBuffers(this._vertexBuffer);
	}
	this._pNumVertices = numVertices;
	if (this._pNumVertices == 0) {
		throw new Error("Bad data: geometry can\'t have zero triangles", 0);
	}
	this.pInvalidateBuffers(this._pVertexDataInvalid);
	this.pInvalidateBounds();
};

away.core.base.CompactSubGeometry.prototype.activateVertexBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (contextIndex != this._contextIndex) {
		this.pUpdateActiveBuffer(contextIndex);
	}
	if (!this._pActiveBuffer || this._activeContext != context) {
		this.pCreateBuffer(contextIndex, context);
	}
	if (this._pActiveDataInvalid) {
		this.pUploadData(contextIndex);
	}
	context.setVertexBufferAt(index, this._pActiveBuffer, 0, away.core.display3D.Context3DVertexBufferFormat.FLOAT_3);
};

away.core.base.CompactSubGeometry.prototype.activateUVBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (this._uvsDirty && this._autoGenerateUVs) {
		this._vertexData = this.pUpdateDummyUVs(this._vertexData);
		this.pInvalidateBuffers(this._pVertexDataInvalid);
	}
	if (contextIndex != this._contextIndex) {
		this.pUpdateActiveBuffer(contextIndex);
	}
	if (!this._pActiveBuffer || this._activeContext != context) {
		this.pCreateBuffer(contextIndex, context);
	}
	if (this._pActiveDataInvalid) {
		this.pUploadData(contextIndex);
	}
	context.setVertexBufferAt(index, this._pActiveBuffer, 9, away.core.display3D.Context3DVertexBufferFormat.FLOAT_2);
};

away.core.base.CompactSubGeometry.prototype.activateSecondaryUVBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (contextIndex != this._contextIndex) {
		this.pUpdateActiveBuffer(contextIndex);
	}
	if (!this._pActiveBuffer || this._activeContext != context) {
		this.pCreateBuffer(contextIndex, context);
	}
	if (this._pActiveDataInvalid) {
		this.pUploadData(contextIndex);
	}
	context.setVertexBufferAt(index, this._pActiveBuffer, 11, away.core.display3D.Context3DVertexBufferFormat.FLOAT_2);
};

away.core.base.CompactSubGeometry.prototype.pUploadData = function(contextIndex) {
	this._pActiveBuffer.uploadFromArray(this._vertexData, 0, this._pNumVertices);
	this._pActiveDataInvalid = false;
	this._pVertexDataInvalid[contextIndex] = this._pActiveDataInvalid;
};

away.core.base.CompactSubGeometry.prototype.activateVertexNormalBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (contextIndex != this._contextIndex) {
		this.pUpdateActiveBuffer(contextIndex);
	}
	if (!this._pActiveBuffer || this._activeContext != context) {
		this.pCreateBuffer(contextIndex, context);
	}
	if (this._pActiveDataInvalid) {
		this.pUploadData(contextIndex);
	}
	context.setVertexBufferAt(index, this._pActiveBuffer, 3, away.core.display3D.Context3DVertexBufferFormat.FLOAT_3);
};

away.core.base.CompactSubGeometry.prototype.activateVertexTangentBuffer = function(index, stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (contextIndex != this._contextIndex) {
		this.pUpdateActiveBuffer(contextIndex);
	}
	if (!this._pActiveBuffer || this._activeContext != context) {
		this.pCreateBuffer(contextIndex, context);
	}
	if (this._pActiveDataInvalid) {
		this.pUploadData(contextIndex);
	}
	context.setVertexBufferAt(index, this._pActiveBuffer, 6, away.core.display3D.Context3DVertexBufferFormat.FLOAT_3);
};

away.core.base.CompactSubGeometry.prototype.pCreateBuffer = function(contextIndex, context) {
	this._pActiveBuffer = context.createVertexBuffer(this._pNumVertices, 13);
	this._vertexBuffer[contextIndex] = this._pActiveBuffer;
	this._activeContext = context;
	this._bufferContext[contextIndex] = this._activeContext;
	this._pActiveDataInvalid = true;
	this._pVertexDataInvalid[contextIndex] = this._pActiveDataInvalid;
};

away.core.base.CompactSubGeometry.prototype.pUpdateActiveBuffer = function(contextIndex) {
	this._contextIndex = contextIndex;
	this._pActiveDataInvalid = this._pVertexDataInvalid[contextIndex];
	this._pActiveBuffer = this._vertexBuffer[contextIndex];
	this._activeContext = this._bufferContext[contextIndex];
};

away.core.base.CompactSubGeometry.prototype.get_vertexData = function() {
	if (this._autoDeriveVertexNormals && this._vertexNormalsDirty) {
		this._vertexData = this.pUpdateVertexNormals(this._vertexData);
	}
	if (this._autoDeriveVertexTangents && this._vertexTangentsDirty) {
		this._vertexData = this.pUpdateVertexTangents(this._vertexData);
	}
	if (this._uvsDirty && this._autoGenerateUVs) {
		this._vertexData = this.pUpdateDummyUVs(this._vertexData);
	}
	return this._vertexData;
};

away.core.base.CompactSubGeometry.prototype.pUpdateVertexNormals = function(target) {
	this.pInvalidateBuffers(this._pVertexDataInvalid);
	return away.core.base.SubGeometryBase.prototype.pUpdateVertexNormals.call(this,target);
};

away.core.base.CompactSubGeometry.prototype.pUpdateVertexTangents = function(target) {
	if (this._vertexNormalsDirty) {
		this._vertexData = this.pUpdateVertexNormals(this._vertexData);
	}
	this.pInvalidateBuffers(this._pVertexDataInvalid);
	return away.core.base.SubGeometryBase.prototype.pUpdateVertexTangents.call(this,target);
};

away.core.base.CompactSubGeometry.prototype.get_vertexNormalData = function() {
	if (this._autoDeriveVertexNormals && this._vertexNormalsDirty) {
		this._vertexData = this.pUpdateVertexNormals(this._vertexData);
	}
	return this._vertexData;
};

away.core.base.CompactSubGeometry.prototype.get_vertexTangentData = function() {
	if (this._autoDeriveVertexTangents && this._vertexTangentsDirty) {
		this._vertexData = this.pUpdateVertexTangents(this._vertexData);
	}
	return this._vertexData;
};

away.core.base.CompactSubGeometry.prototype.get_UVData = function() {
	if (this._uvsDirty && this._autoGenerateUVs) {
		this._vertexData = this.pUpdateDummyUVs(this._vertexData);
		this.pInvalidateBuffers(this._pVertexDataInvalid);
	}
	return this._vertexData;
};

away.core.base.CompactSubGeometry.prototype.applyTransformation = function(transform) {
	away.core.base.SubGeometryBase.prototype.applyTransformation.call(this,transform);
	this.pInvalidateBuffers(this._pVertexDataInvalid);
};

away.core.base.CompactSubGeometry.prototype.scale = function(scale) {
	away.core.base.SubGeometryBase.prototype.scale.call(this,scale);
	this.pInvalidateBuffers(this._pVertexDataInvalid);
};

away.core.base.CompactSubGeometry.prototype.clone = function() {
	var clone = new away.core.base.CompactSubGeometry();
	clone._autoDeriveVertexNormals = this._autoDeriveVertexNormals;
	clone._autoDeriveVertexTangents = this._autoDeriveVertexTangents;
	clone.updateData(this._vertexData.concat());
	clone.updateIndexData(this._indices.concat());
	return clone;
};

away.core.base.CompactSubGeometry.prototype.scaleUV = function(scaleU, scaleV) {
	scaleU = scaleU || 1;
	scaleV = scaleV || 1;
	away.core.base.SubGeometryBase.prototype.scaleUV.call(this,scaleU, scaleV);
	this.pInvalidateBuffers(this._pVertexDataInvalid);
};

away.core.base.CompactSubGeometry.prototype.get_vertexStride = function() {
	return 13;
};

away.core.base.CompactSubGeometry.prototype.get_vertexNormalStride = function() {
	return 13;
};

away.core.base.CompactSubGeometry.prototype.get_vertexTangentStride = function() {
	return 13;
};

away.core.base.CompactSubGeometry.prototype.get_UVStride = function() {
	return 13;
};

away.core.base.CompactSubGeometry.prototype.get_secondaryUVStride = function() {
	return 13;
};

away.core.base.CompactSubGeometry.prototype.get_vertexOffset = function() {
	return 0;
};

away.core.base.CompactSubGeometry.prototype.get_vertexNormalOffset = function() {
	return 3;
};

away.core.base.CompactSubGeometry.prototype.get_vertexTangentOffset = function() {
	return 6;
};

away.core.base.CompactSubGeometry.prototype.get_UVOffset = function() {
	return 9;
};

away.core.base.CompactSubGeometry.prototype.get_secondaryUVOffset = function() {
	return 11;
};

away.core.base.CompactSubGeometry.prototype.dispose = function() {
	away.core.base.SubGeometryBase.prototype.dispose.call(this);
	this.pDisposeVertexBuffers(this._vertexBuffer);
	this._vertexBuffer = null;
};

away.core.base.CompactSubGeometry.prototype.pDisposeVertexBuffers = function(buffers) {
	away.core.base.SubGeometryBase.prototype.pDisposeVertexBuffers.call(this,buffers);
	this._pActiveBuffer = null;
};

away.core.base.CompactSubGeometry.prototype.pInvalidateBuffers = function(invalid) {
	away.core.base.SubGeometryBase.prototype.pInvalidateBuffers.call(this,invalid);
	this._pActiveDataInvalid = true;
};

away.core.base.CompactSubGeometry.prototype.cloneWithSeperateBuffers = function() {
	var clone = new away.core.base.SubGeometry();
	clone.updateVertexData(this._isolatedVertexPositionData ? this._isolatedVertexPositionData : this._isolatedVertexPositionData = this.stripBuffer(0, 3));
	clone.set_autoDeriveVertexNormals(this._autoDeriveVertexNormals);
	clone.set_autoDeriveVertexTangents(this._autoDeriveVertexTangents);
	if (!this._autoDeriveVertexNormals) {
		clone.updateVertexNormalData(this.stripBuffer(3, 3));
	}
	if (!this._autoDeriveVertexTangents) {
		clone.updateVertexTangentData(this.stripBuffer(6, 3));
	}
	clone.updateUVData(this.stripBuffer(9, 2));
	clone.updateSecondaryUVData(this.stripBuffer(11, 2));
	clone.updateIndexData(this.get_indexData().concat());
	return clone;
};

away.core.base.CompactSubGeometry.prototype.get_vertexPositionData = function() {
	if (this._isolatedVertexPositionDataDirty || !this._isolatedVertexPositionData) {
		this._isolatedVertexPositionData = this.stripBuffer(0, 3);
		this._isolatedVertexPositionDataDirty = false;
	}
	return this._isolatedVertexPositionData;
};

away.core.base.CompactSubGeometry.prototype.get_strippedUVData = function() {
	return this.stripBuffer(9, 2);
};

away.core.base.CompactSubGeometry.prototype.stripBuffer = function(offset, numEntries) {
	var data = away.utils.VectorInit.Num(this._pNumVertices * numEntries, 0);
	var i = 0;
	var j = offset;
	var skip = 13 - numEntries;
	for (var v = 0; v < this._pNumVertices; ++v) {
		for (var k = 0; k < numEntries; ++k) {
			data[i++] = this._vertexData[j++];
		}
		j += skip;
	}
	return data;
};

away.core.base.CompactSubGeometry.prototype.fromVectors = function(verts, uvs, normals, tangents) {
	var vertLen = verts.length / 3 * 13;
	var index = 0;
	var v = 0;
	var n = 0;
	var t = 0;
	var u = 0;
	var data = away.utils.VectorInit.Num(vertLen, 0);
	while (index < vertLen) {
		data[index++] = verts[v++];
		data[index++] = verts[v++];
		data[index++] = verts[v++];
		if (normals && normals.length) {
			data[index++] = normals[n++];
			data[index++] = normals[n++];
			data[index++] = normals[n++];
		} else {
			data[index++] = 0;
			data[index++] = 0;
			data[index++] = 0;
		}
		if (tangents && tangents.length) {
			data[index++] = tangents[t++];
			data[index++] = tangents[t++];
			data[index++] = tangents[t++];
		} else {
			data[index++] = 0;
			data[index++] = 0;
			data[index++] = 0;
		}
		if (uvs && uvs.length) {
			data[index++] = uvs[u];
			data[index++] = uvs[u + 1];
			data[index++] = uvs[u++];
			data[index++] = uvs[u++];
		} else {
			data[index++] = 0;
			data[index++] = 0;
			data[index++] = 0;
			data[index++] = 0;
		}
	}
	this.set_autoDeriveVertexNormals(!(normals && normals.length));
	this.set_autoDeriveVertexTangents(!(tangents && tangents.length));
	this.set_autoGenerateDummyUVs(!(uvs && uvs.length));
	this.updateData(data);
};

$inherit(away.core.base.CompactSubGeometry, away.core.base.SubGeometryBase);

away.core.base.CompactSubGeometry.className = "away.core.base.CompactSubGeometry";

away.core.base.CompactSubGeometry.getRuntimeDependencies = function(t) {
	var p;
	p = [];
	p.push('away.core.display3D.Context3DVertexBufferFormat');
	p.push('away.core.base.SubGeometry');
	p.push('away.utils.VectorInit');
	return p;
};

away.core.base.CompactSubGeometry.getStaticDependencies = function(t) {
	var p;
	p = [];
	p.push('away.utils.VectorInit');
	return p;
};

away.core.base.CompactSubGeometry.injectionPoints = function(t) {
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


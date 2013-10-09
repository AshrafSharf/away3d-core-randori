/** Compiled by the Randori compiler v0.2.5.2 on Wed Oct 09 20:30:36 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.core == "undefined")
	away.core = {};
if (typeof away.core.base == "undefined")
	away.core.base = {};

away.core.base.SubGeometryBase = function() {
this._vertexData = null;
this._faceNormals = null;
this._faceTangentsDirty = true;
this._uvsDirty = true;
this._vertexTangentsDirty = true;
this._faceNormalsDirty = true;
this._indexBufferContext = away.utils.VectorInit.AnyClass(8);
this._scaleU = 1;
this._indices = null;
this._scaleV = 1;
this._autoDeriveVertexNormals = true;
this._autoGenerateUVs = false;
this._useFaceWeights = false;
this._numTriangles = 0;
this._parentGeometry = null;
this._autoDeriveVertexTangents = true;
this._vertexNormalsDirty = true;
this._faceWeights = null;
this._faceTangents = null;
this._indexBuffer = away.utils.VectorInit.AnyClass(8);
this._indicesInvalid = away.utils.VectorInit.Bool(8, false);
this._numIndices = 0;
};

away.core.base.SubGeometryBase.prototype.get_autoGenerateDummyUVs = function() {
	return this._autoGenerateUVs;
};

away.core.base.SubGeometryBase.prototype.set_autoGenerateDummyUVs = function(value) {
	this._autoGenerateUVs = value;
	this._uvsDirty = value;
};

away.core.base.SubGeometryBase.prototype.get_autoDeriveVertexNormals = function() {
	return this._autoDeriveVertexNormals;
};

away.core.base.SubGeometryBase.prototype.set_autoDeriveVertexNormals = function(value) {
	this._autoDeriveVertexNormals = value;
	this._vertexNormalsDirty = value;
};

away.core.base.SubGeometryBase.prototype.get_useFaceWeights = function() {
	return this._useFaceWeights;
};

away.core.base.SubGeometryBase.prototype.set_useFaceWeights = function(value) {
	this._useFaceWeights = value;
	if (this._autoDeriveVertexNormals) {
		this._vertexNormalsDirty = true;
	}
	if (this._autoDeriveVertexTangents) {
		this._vertexTangentsDirty = true;
	}
	this._faceNormalsDirty = true;
};

away.core.base.SubGeometryBase.prototype.get_numTriangles = function() {
	return this._numTriangles;
};

away.core.base.SubGeometryBase.prototype.getIndexBuffer = function(stage3DProxy) {
	var contextIndex = stage3DProxy._iStage3DIndex;
	var context = stage3DProxy._iContext3D;
	if (!this._indexBuffer[contextIndex] || this._indexBufferContext[contextIndex] != context) {
		this._indexBuffer[contextIndex] = context.createIndexBuffer(this._numIndices);
		this._indexBufferContext[contextIndex] = context;
		this._indicesInvalid[contextIndex] = true;
	}
	if (this._indicesInvalid[contextIndex]) {
		this._indexBuffer[contextIndex].uploadFromArray(this._indices, 0, this._numIndices);
		this._indicesInvalid[contextIndex] = false;
	}
	return this._indexBuffer[contextIndex];
};

away.core.base.SubGeometryBase.prototype.pUpdateFaceTangents = function() {
	var i = 0;
	var index1;
	var index2;
	var index3;
	var len = this._indices.length;
	var ui;
	var vi;
	var v0;
	var dv1;
	var dv2;
	var denom;
	var x0, y0, z0;
	var dx1, dy1, dz1;
	var dx2, dy2, dz2;
	var cx, cy, cz;
	var vertices = this._vertexData;
	var uvs = this.get_UVData();
	var posStride = this.get_vertexStride();
	var posOffset = this.get_vertexOffset();
	var texStride = this.get_UVStride();
	var texOffset = this.get_UVOffset();
	if (this._faceTangents == null) {
		this._faceTangents = away.utils.VectorInit.Num(this._indices.length, 0);
	}
	while (i < len) {
		index1 = this._indices[i];
		index2 = this._indices[i + 1];
		index3 = this._indices[i + 2];
		ui = texOffset + index1 * texStride + 1;
		v0 = uvs[ui];
		ui = texOffset + index2 * texStride + 1;
		dv1 = uvs[ui] - v0;
		ui = texOffset + index3 * texStride + 1;
		dv2 = uvs[ui] - v0;
		vi = posOffset + index1 * posStride;
		x0 = vertices[vi];
		y0 = vertices[(vi + 1)];
		z0 = vertices[(vi + 2)];
		vi = posOffset + index2 * posStride;
		dx1 = vertices[vi] - x0;
		dy1 = vertices[(vi + 1)] - y0;
		dz1 = vertices[(vi + 2)] - z0;
		vi = posOffset + index3 * posStride;
		dx2 = vertices[vi] - x0;
		dy2 = vertices[(vi + 1)] - y0;
		dz2 = vertices[(vi + 2)] - z0;
		cx = dv2 * dx1 - dv1 * dx2;
		cy = dv2 * dy1 - dv1 * dy2;
		cz = dv2 * dz1 - dv1 * dz2;
		denom = 1 / Math.sqrt(cx * cx + cy * cy + cz * cz);
		this._faceTangents[i++] = denom * cx;
		this._faceTangents[i++] = denom * cy;
		this._faceTangents[i++] = denom * cz;
	}
	this._faceTangentsDirty = false;
};

away.core.base.SubGeometryBase.prototype.updateFaceNormals = function() {
	var i = 0;
	var j = 0;
	var k = 0;
	var index;
	var len = this._indices.length;
	var x1, x2, x3;
	var y1, y2, y3;
	var z1, z2, z3;
	var dx1, dy1, dz1;
	var dx2, dy2, dz2;
	var cx, cy, cz;
	var d;
	var vertices = this._vertexData;
	var posStride = this.get_vertexStride();
	var posOffset = this.get_vertexOffset();
	if (this._faceNormals == null) {
		this._faceNormals = away.utils.VectorInit.Num(len, 0);
	}
	if (this._useFaceWeights) {
		if (this._faceWeights == null) {
			this._faceWeights = away.utils.VectorInit.Num(len / 3, 0);
		}
	}
	while (i < len) {
		index = posOffset + this._indices[i++] * posStride;
		x1 = vertices[index];
		y1 = vertices[index + 1];
		z1 = vertices[index + 2];
		index = posOffset + this._indices[i++] * posStride;
		x2 = vertices[index];
		y2 = vertices[index + 1];
		z2 = vertices[index + 2];
		index = posOffset + this._indices[i++] * posStride;
		x3 = vertices[index];
		y3 = vertices[index + 1];
		z3 = vertices[index + 2];
		dx1 = x3 - x1;
		dy1 = y3 - y1;
		dz1 = z3 - z1;
		dx2 = x2 - x1;
		dy2 = y2 - y1;
		dz2 = z2 - z1;
		cx = dz1 * dy2 - dy1 * dz2;
		cy = dx1 * dz2 - dz1 * dx2;
		cz = dy1 * dx2 - dx1 * dy2;
		d = Math.sqrt(cx * cx + cy * cy + cz * cz);
		if (this._useFaceWeights) {
			var w = d * 10000;
			if (w < 1) {
				w = 1;
			}
			this._faceWeights[k++] = w;
		}
		d = 1 / d;
		this._faceNormals[j++] = cx * d;
		this._faceNormals[j++] = cy * d;
		this._faceNormals[j++] = cz * d;
	}
	this._faceNormalsDirty = false;
};

away.core.base.SubGeometryBase.prototype.pUpdateVertexNormals = function(target) {
	if (this._faceNormalsDirty) {
		this.updateFaceNormals();
	}
	var v1;
	var f1 = 0;
	var f2 = 1;
	var f3 = 2;
	var lenV = this._vertexData.length;
	var normalStride = this.get_vertexNormalStride();
	var normalOffset = this.get_vertexNormalOffset();
	if (target == null) {
		target = away.utils.VectorInit.Num(lenV, 0);
	}
	v1 = normalOffset;
	while (v1 < lenV) {
		target[v1] = 0.0;
		target[v1 + 1] = 0.0;
		target[v1 + 2] = 0.0;
		v1 += normalStride;
	}
	var i = 0;
	var k = 0;
	var lenI = this._indices.length;
	var index;
	var weight;
	while (i < lenI) {
		weight = this._useFaceWeights ? this._faceWeights[k++] : 1;
		index = normalOffset + this._indices[i++] * normalStride;
		target[index++] += this._faceNormals[f1] * weight;
		target[index++] += this._faceNormals[f2] * weight;
		target[index] += this._faceNormals[f3] * weight;
		index = normalOffset + this._indices[i++] * normalStride;
		target[index++] += this._faceNormals[f1] * weight;
		target[index++] += this._faceNormals[f2] * weight;
		target[index] += this._faceNormals[f3] * weight;
		index = normalOffset + this._indices[i++] * normalStride;
		target[index++] += this._faceNormals[f1] * weight;
		target[index++] += this._faceNormals[f2] * weight;
		target[index] += this._faceNormals[f3] * weight;
		f1 += 3;
		f2 += 3;
		f3 += 3;
	}
	v1 = normalOffset;
	while (v1 < lenV) {
		var vx = target[v1];
		var vy = target[v1 + 1];
		var vz = target[v1 + 2];
		var d = 1.0 / Math.sqrt(vx * vx + vy * vy + vz * vz);
		target[v1] = vx * d;
		target[v1 + 1] = vy * d;
		target[v1 + 2] = vz * d;
		v1 += normalStride;
	}
	this._vertexNormalsDirty = false;
	return target;
};

away.core.base.SubGeometryBase.prototype.pUpdateVertexTangents = function(target) {
	if (this._faceTangentsDirty) {
		this.pUpdateFaceTangents();
	}
	var i;
	var lenV = this._vertexData.length;
	var tangentStride = this.get_vertexTangentStride();
	var tangentOffset = this.get_vertexTangentOffset();
	if (target == null) {
		target = away.utils.VectorInit.Num(lenV, 0);
	}
	i = tangentOffset;
	while (i < lenV) {
		target[i] = 0.0;
		target[i + 1] = 0.0;
		target[i + 2] = 0.0;
		i += tangentStride;
	}
	var k = 0;
	var lenI = this._indices.length;
	var index;
	var weight;
	var f1 = 0;
	var f2 = 1;
	var f3 = 2;
	i = 0;
	while (i < lenI) {
		weight = this._useFaceWeights ? this._faceWeights[k++] : 1;
		index = tangentOffset + this._indices[i++] * tangentStride;
		target[index++] += this._faceTangents[f1] * weight;
		target[index++] += this._faceTangents[f2] * weight;
		target[index] += this._faceTangents[f3] * weight;
		index = tangentOffset + this._indices[i++] * tangentStride;
		target[index++] += this._faceTangents[f1] * weight;
		target[index++] += this._faceTangents[f2] * weight;
		target[index] += this._faceTangents[f3] * weight;
		index = tangentOffset + this._indices[i++] * tangentStride;
		target[index++] += this._faceTangents[f1] * weight;
		target[index++] += this._faceTangents[f2] * weight;
		target[index] += this._faceTangents[f3] * weight;
		f1 += 3;
		f2 += 3;
		f3 += 3;
	}
	i = tangentOffset;
	while (i < lenV) {
		var vx = target[i];
		var vy = target[i + 1];
		var vz = target[i + 2];
		var d = 1.0 / Math.sqrt(vx * vx + vy * vy + vz * vz);
		target[i] = vx * d;
		target[i + 1] = vy * d;
		target[i + 2] = vz * d;
		i += tangentStride;
	}
	this._vertexTangentsDirty = false;
	return target;
};

away.core.base.SubGeometryBase.prototype.dispose = function() {
	this.pDisposeIndexBuffers(this._indexBuffer);
	this._indices = null;
	this._indexBufferContext = null;
	this._faceNormals = null;
	this._faceWeights = null;
	this._faceTangents = null;
	this._vertexData = null;
};

away.core.base.SubGeometryBase.prototype.get_indexData = function() {
	return this._indices;
};

away.core.base.SubGeometryBase.prototype.updateIndexData = function(indices) {
	this._indices = indices;
	this._numIndices = indices.length;
	var numTriangles = this._numIndices / 3;
	if (this._numTriangles != numTriangles) {
		this.pDisposeIndexBuffers(this._indexBuffer);
	}
	this._numTriangles = numTriangles;
	this.pInvalidateBuffers(this._indicesInvalid);
	this._faceNormalsDirty = true;
	if (this._autoDeriveVertexNormals) {
		this._vertexNormalsDirty = true;
	}
	if (this._autoDeriveVertexTangents) {
		this._vertexTangentsDirty = true;
	}
};

away.core.base.SubGeometryBase.prototype.pDisposeIndexBuffers = function(buffers) {
	for (var i = 0; i < 8; ++i) {
		if (buffers[i]) {
			buffers[i].dispose();
			buffers[i] = null;
		}
	}
};

away.core.base.SubGeometryBase.prototype.pDisposeVertexBuffers = function(buffers) {
	for (var i = 0; i < 8; ++i) {
		if (buffers[i]) {
			buffers[i].dispose();
			buffers[i] = null;
		}
	}
};

away.core.base.SubGeometryBase.prototype.get_autoDeriveVertexTangents = function() {
	return this._autoDeriveVertexTangents;
};

away.core.base.SubGeometryBase.prototype.set_autoDeriveVertexTangents = function(value) {
	this._autoDeriveVertexTangents = value;
	this._vertexTangentsDirty = value;
};

away.core.base.SubGeometryBase.prototype.get_faceNormals = function() {
	if (this._faceNormalsDirty) {
		this.updateFaceNormals();
	}
	return this._faceNormals;
};

away.core.base.SubGeometryBase.prototype.pInvalidateBuffers = function(invalid) {
	for (var i = 0; i < 8; ++i) {
		invalid[i] = true;
	}
};

away.core.base.SubGeometryBase.prototype.get_UVStride = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexData = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexPositionData = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexNormalData = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexTangentData = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_UVData = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexStride = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexNormalStride = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexTangentStride = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexOffset = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexNormalOffset = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_vertexTangentOffset = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.get_UVOffset = function() {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.core.base.SubGeometryBase.prototype.pInvalidateBounds = function() {
	if (this._parentGeometry) {
		var me = this;
		this._parentGeometry.iInvalidateBounds(me);
	}
};

away.core.base.SubGeometryBase.prototype.get_parentGeometry = function() {
	return this._parentGeometry;
};

away.core.base.SubGeometryBase.prototype.set_parentGeometry = function(value) {
	this._parentGeometry = value;
};

away.core.base.SubGeometryBase.prototype.get_scaleU = function() {
	return this._scaleU;
};

away.core.base.SubGeometryBase.prototype.get_scaleV = function() {
	return this._scaleV;
};

away.core.base.SubGeometryBase.prototype.scaleUV = function(scaleU, scaleV) {
	scaleU = scaleU || 1;
	scaleV = scaleV || 1;
	var offset = this.get_UVOffset();
	var stride = this.get_UVStride();
	var uvs = this.get_UVData();
	var len = uvs.length;
	var ratioU = scaleU / this._scaleU;
	var ratioV = scaleV / this._scaleV;
	for (var i = offset; i < len; i += stride) {
		uvs[i] *= ratioU;
		uvs[i + 1] *= ratioV;
	}
	this._scaleU = scaleU;
	this._scaleV = scaleV;
};

away.core.base.SubGeometryBase.prototype.scale = function(scale) {
	var vertices = this.get_UVData();
	var len = vertices.length;
	var offset = this.get_vertexOffset();
	var stride = this.get_vertexStride();
	for (var i = offset; i < len; i += stride) {
		vertices[i] *= scale;
		vertices[i + 1] *= scale;
		vertices[i + 2] *= scale;
	}
};

away.core.base.SubGeometryBase.prototype.applyTransformation = function(transform) {
	var vertices = this._vertexData;
	var normals = this.get_vertexNormalData();
	var tangents = this.get_vertexTangentData();
	var posStride = this.get_vertexStride();
	var normalStride = this.get_vertexNormalStride();
	var tangentStride = this.get_vertexTangentStride();
	var posOffset = this.get_vertexOffset();
	var normalOffset = this.get_vertexNormalOffset();
	var tangentOffset = this.get_vertexTangentOffset();
	var len = vertices.length / posStride;
	var i;
	var i1;
	var i2;
	var vector = new away.core.geom.Vector3D(0, 0, 0, 0);
	var bakeNormals = normals != null;
	var bakeTangents = tangents != null;
	var invTranspose;
	if (bakeNormals || bakeTangents) {
		invTranspose = transform.clone();
		invTranspose.invert();
		invTranspose.transpose();
	}
	var vi0 = posOffset;
	var ni0 = normalOffset;
	var ti0 = tangentOffset;
	for (i = 0; i < len; ++i) {
		i1 = vi0 + 1;
		i2 = vi0 + 2;
		vector.x = vertices[vi0];
		vector.y = vertices[i1];
		vector.z = vertices[i2];
		vector = transform.transformVector(vector);
		vertices[vi0] = vector.x;
		vertices[i1] = vector.y;
		vertices[i2] = vector.z;
		vi0 += posStride;
		if (bakeNormals) {
			i1 = ni0 + 1;
			i2 = ni0 + 2;
			vector.x = normals[ni0];
			vector.y = normals[i1];
			vector.z = normals[i2];
			vector = invTranspose.deltaTransformVector(vector);
			vector.normalize();
			normals[ni0] = vector.x;
			normals[i1] = vector.y;
			normals[i2] = vector.z;
			ni0 += normalStride;
		}
		if (bakeTangents) {
			i1 = ti0 + 1;
			i2 = ti0 + 2;
			vector.x = tangents[ti0];
			vector.y = tangents[i1];
			vector.z = tangents[i2];
			vector = invTranspose.deltaTransformVector(vector);
			vector.normalize();
			tangents[ti0] = vector.x;
			tangents[i1] = vector.y;
			tangents[i2] = vector.z;
			ti0 += tangentStride;
		}
	}
};

away.core.base.SubGeometryBase.prototype.pUpdateDummyUVs = function(target) {
	this._uvsDirty = false;
	var idx;
	var uvIdx;
	var stride = this.get_UVStride();
	var skip = stride - 2;
	var len = this._vertexData.length / this.get_vertexStride() * stride;
	if (!target) {
		target = away.utils.VectorInit.Num(0, 0);
	}
	target.length = len;
	idx = this.get_UVOffset();
	uvIdx = 0;
	while (idx < len) {
		target[idx++] = uvIdx * .5;
		target[idx++] = 1.0 - (uvIdx & 1);
		idx += skip;
		if (++uvIdx == 3) {
			uvIdx = 0;
		}
	}
	return target;
};

away.core.base.SubGeometryBase.className = "away.core.base.SubGeometryBase";

away.core.base.SubGeometryBase.getRuntimeDependencies = function(t) {
	var p;
	p = [];
	p.push('away.core.geom.Vector3D');
	p.push('away.errors.AbstractMethodError');
	p.push('away.utils.VectorInit');
	return p;
};

away.core.base.SubGeometryBase.getStaticDependencies = function(t) {
	var p;
	p = [];
	p.push('away.utils.VectorInit');
	return p;
};

away.core.base.SubGeometryBase.injectionPoints = function(t) {
	return [];
};
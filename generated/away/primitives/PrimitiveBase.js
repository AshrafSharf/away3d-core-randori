/** Compiled by the Randori compiler v0.2.6.2 on Mon Sep 02 23:32:23 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.primitives == "undefined")
	away.primitives = {};

away.primitives.PrimitiveBase = function() {
	this._subGeometry = null;
	this._geomDirty = true;
	this._uvDirty = true;
	away.base.Geometry.call(this);
	this._subGeometry = new away.base.CompactSubGeometry();
	this._subGeometry.set_autoGenerateDummyUVs(false);
	this.addSubGeometry(this._subGeometry);
};

away.primitives.PrimitiveBase.prototype.get_subGeometries = function() {
	if (this._geomDirty) {
		this.updateGeometry();
	}
	if (this._uvDirty) {
		this.updateUVs();
	}
	return away.base.Geometry.prototype.getSubGeometries.call(this);
};

away.primitives.PrimitiveBase.prototype.clone = function() {
	if (this._geomDirty) {
		this.updateGeometry();
	}
	if (this._uvDirty) {
		this.updateUVs();
	}
	return away.base.Geometry.prototype.clone.call(this);
};

away.primitives.PrimitiveBase.prototype.scale = function(scale) {
	if (this._geomDirty) {
		this.updateGeometry();
	}
	away.base.Geometry.prototype.scale.call(this,scale);
};

away.primitives.PrimitiveBase.prototype.scaleUV = function(scaleU, scaleV) {
	if (this._uvDirty) {
		this.updateUVs();
	}
	away.base.Geometry.prototype.scaleUV.call(this,scaleU, scaleV);
};

away.primitives.PrimitiveBase.prototype.applyTransformation = function(transform) {
	if (this._geomDirty) {
		this.updateGeometry();
	}
	away.base.Geometry.prototype.applyTransformation.call(this,transform);
};

away.primitives.PrimitiveBase.prototype.pBuildGeometry = function(target) {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.primitives.PrimitiveBase.prototype.pBuildUVs = function(target) {
	throw new away.errors.AbstractMethodError(null, 0);
};

away.primitives.PrimitiveBase.prototype.pInvalidateGeometry = function() {
	this._geomDirty = true;
};

away.primitives.PrimitiveBase.prototype.pInvalidateUVs = function() {
	this._uvDirty = true;
};

away.primitives.PrimitiveBase.prototype.updateGeometry = function() {
	this.pBuildGeometry(this._subGeometry);
	this._geomDirty = false;
};

away.primitives.PrimitiveBase.prototype.updateUVs = function() {
	this.pBuildUVs(this._subGeometry);
	this._uvDirty = false;
};

away.primitives.PrimitiveBase.prototype.iValidate = function() {
	if (this._geomDirty) {
		this.updateGeometry();
	}
	if (this._uvDirty) {
		this.updateUVs();
	}
};

$inherit(away.primitives.PrimitiveBase, away.base.Geometry);

away.primitives.PrimitiveBase.className = "away.primitives.PrimitiveBase";

away.primitives.PrimitiveBase.getRuntimeDependencies = function(t) {
	var p;
	p = [];
	p.push('away.errors.AbstractMethodError');
	p.push('away.base.CompactSubGeometry');
	return p;
};

away.primitives.PrimitiveBase.getStaticDependencies = function(t) {
	var p;
	return [];
};

away.primitives.PrimitiveBase.injectionPoints = function(t) {
	var p;
	switch (t) {
		case 1:
			p = away.base.Geometry.injectionPoints(t);
			break;
		case 2:
			p = away.base.Geometry.injectionPoints(t);
			break;
		case 3:
			p = away.base.Geometry.injectionPoints(t);
			break;
		default:
			p = [];
			break;
	}
	return p;
};

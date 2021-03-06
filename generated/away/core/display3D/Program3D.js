/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:08 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.core == "undefined")
	away.core = {};
if (typeof away.core.display3D == "undefined")
	away.core.display3D = {};

away.core.display3D.Program3D = function(gl) {
	this._gl = null;
	this._vertexShader = null;
	this._fragmentShader = null;
	this._program = null;
	this._gl = gl;
	this._program = this._gl.createProgram();
};

away.core.display3D.Program3D.prototype.upload = function(vertexProgram, fragmentProgram) {
	this._vertexShader = this._gl.createShader(35633);
	this._fragmentShader = this._gl.createShader(35632);
	this._gl.shaderSource(this._vertexShader, vertexProgram);
	this._gl.compileShader(this._vertexShader);
	if (!this._gl.getShaderParameter(this._vertexShader, 35713)) {
		console.log(this._gl.getShaderInfoLog(this._vertexShader));
		return;
	}
	this._gl.shaderSource(this._fragmentShader, fragmentProgram);
	this._gl.compileShader(this._fragmentShader);
	if (!this._gl.getShaderParameter(this._fragmentShader, 35713)) {
		console.log(this._gl.getShaderInfoLog(this._fragmentShader));
		return;
	}
	this._gl.attachShader(this._program, this._vertexShader);
	this._gl.attachShader(this._program, this._fragmentShader);
	this._gl.linkProgram(this._program);
	if (!this._gl.getProgramParameter(this._program, 35714)) {
		console.log("Could not link the program.");
	}
};

away.core.display3D.Program3D.prototype.dispose = function() {
	this._gl.deleteProgram(this._program);
};

away.core.display3D.Program3D.prototype.focusProgram = function() {
	this._gl.useProgram(this._program);
};

away.core.display3D.Program3D.prototype.get_glProgram = function() {
	return this._program;
};

away.core.display3D.Program3D.className = "away.core.display3D.Program3D";

away.core.display3D.Program3D.getRuntimeDependencies = function(t) {
	var p;
	return [];
};

away.core.display3D.Program3D.getStaticDependencies = function(t) {
	var p;
	return [];
};

away.core.display3D.Program3D.injectionPoints = function(t) {
	var p;
	switch (t) {
		case 0:
			p = [];
			p.push({n:'gl', t:'WebGLRenderingContext'});
			break;
		default:
			p = [];
			break;
	}
	return p;
};


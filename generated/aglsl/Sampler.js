/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:08 EST 2013 */

if (typeof aglsl == "undefined")
	var aglsl = {};

aglsl.Sampler = function() {
this.dim = 0;
this.wrap = 0;
this.readmode = 0;
this.special = 0;
this.lodbias = 0;
this.filter = 0;
this.mipmap = 0;
};

aglsl.Sampler.className = "aglsl.Sampler";

aglsl.Sampler.getRuntimeDependencies = function(t) {
	var p;
	return [];
};

aglsl.Sampler.getStaticDependencies = function(t) {
	var p;
	return [];
};

aglsl.Sampler.injectionPoints = function(t) {
	return [];
};

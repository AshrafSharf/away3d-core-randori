/** Compiled by the Randori compiler v0.2.6.2 on Thu Sep 05 22:19:19 EST 2013 */

if (typeof aglsl == "undefined")
	var aglsl = {};

aglsl.OpLUT = function(s, flags, dest, a, b, matrixwidth, matrixheight, ndwm, scaler, dm, lod) {
	this.scalar = null;
	s = s;
	flags = flags;
	dest = dest;
	a = a;
	b = b;
	matrixwidth = matrixwidth;
	matrixheight = matrixheight;
	ndwm = ndwm;
	this.scalar = scaler;
	dm = dm;
	lod = lod;
};

aglsl.OpLUT.className = "aglsl.OpLUT";

aglsl.OpLUT.getRuntimeDependencies = function(t) {
	var p;
	return [];
};

aglsl.OpLUT.getStaticDependencies = function(t) {
	var p;
	return [];
};

aglsl.OpLUT.injectionPoints = function(t) {
	var p;
	switch (t) {
		case 0:
			p = [];
			p.push({n:'s', t:'String'});
			p.push({n:'flags', t:'Number'});
			p.push({n:'dest', t:'Boolean'});
			p.push({n:'a', t:'Boolean'});
			p.push({n:'b', t:'Boolean'});
			p.push({n:'matrixwidth', t:'Number'});
			p.push({n:'matrixheight', t:'Number'});
			p.push({n:'ndwm', t:'Boolean'});
			p.push({n:'scaler', t:'Boolean'});
			p.push({n:'dm', t:'Boolean'});
			p.push({n:'lod', t:'Boolean'});
			break;
		default:
			p = [];
			break;
	}
	return p;
};


/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:09 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.errors == "undefined")
	away.errors = {};

away.errors.PartialImplementationError = function(dependency, id) {
	dependency = dependency || "";
	id = id || 0;
	away.errors.Error.call(this, "PartialImplementationError - this function is in development. Required Dependency: " + dependency, id, "");
};

$inherit(away.errors.PartialImplementationError, away.errors.Error);

away.errors.PartialImplementationError.className = "away.errors.PartialImplementationError";

away.errors.PartialImplementationError.getRuntimeDependencies = function(t) {
	var p;
	return [];
};

away.errors.PartialImplementationError.getStaticDependencies = function(t) {
	var p;
	return [];
};

away.errors.PartialImplementationError.injectionPoints = function(t) {
	var p;
	switch (t) {
		case 0:
			p = [];
			p.push({n:'dependency', t:'String'});
			p.push({n:'id', t:'Number'});
			break;
		case 1:
			p = away.errors.Error.injectionPoints(t);
			break;
		case 2:
			p = away.errors.Error.injectionPoints(t);
			break;
		case 3:
			p = away.errors.Error.injectionPoints(t);
			break;
		default:
			p = [];
			break;
	}
	return p;
};


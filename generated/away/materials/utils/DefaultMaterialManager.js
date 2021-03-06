/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:06 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.materials == "undefined")
	away.materials = {};
if (typeof away.materials.utils == "undefined")
	away.materials.utils = {};

away.materials.utils.DefaultMaterialManager = function() {
	this._defaultMaterial = null;
	this._defaultTexture = null;
	this._defaultTextureBitmapData = null;
	
};

away.materials.utils.DefaultMaterialManager._defaultTextureBitmapData;

away.materials.utils.DefaultMaterialManager._defaultMaterial;

away.materials.utils.DefaultMaterialManager._defaultTexture;

away.materials.utils.DefaultMaterialManager.getDefaultMaterial = function(renderable) {
	renderable = renderable || null;
	if (!away.materials.utils.DefaultMaterialManager._defaultTexture) {
		away.materials.utils.DefaultMaterialManager.createDefaultTexture();
	}
	if (!away.materials.utils.DefaultMaterialManager._defaultMaterial) {
		away.materials.utils.DefaultMaterialManager.createDefaultMaterial();
	}
	return away.materials.utils.DefaultMaterialManager._defaultMaterial;
};

away.materials.utils.DefaultMaterialManager.getDefaultTexture = function(renderable) {
	renderable = renderable || null;
	if (!away.materials.utils.DefaultMaterialManager._defaultTexture) {
		away.materials.utils.DefaultMaterialManager.createDefaultTexture();
	}
	return away.materials.utils.DefaultMaterialManager._defaultTexture;
};

away.materials.utils.DefaultMaterialManager.createDefaultTexture = function() {
	away.materials.utils.DefaultMaterialManager._defaultTextureBitmapData = away.materials.utils.DefaultMaterialManager.createCheckeredBitmapData();
	away.materials.utils.DefaultMaterialManager._defaultTexture = new away.textures.BitmapTexture(away.materials.utils.DefaultMaterialManager._defaultTextureBitmapData, false);
	away.materials.utils.DefaultMaterialManager._defaultTexture.set_name("defaultTexture");
};

away.materials.utils.DefaultMaterialManager.createCheckeredBitmapData = function() {
	var b = new away.core.display.BitmapData(8, 8, false, 0x000000);
	var i, j;
	for (i = 0; i < 8; i++) {
		for (j = 0; j < 8; j++) {
			if ((j & 1) ^ (i & 1)) {
				b.setPixel(i, j, 0XFFFFFF);
			}
		}
	}
	return b;
};

away.materials.utils.DefaultMaterialManager.createDefaultMaterial = function() {
	away.materials.utils.DefaultMaterialManager._defaultMaterial = new away.materials.TextureMaterial(away.materials.utils.DefaultMaterialManager._defaultTexture, true, false, false);
	away.materials.utils.DefaultMaterialManager._defaultMaterial.set_mipmap(false);
	away.materials.utils.DefaultMaterialManager._defaultMaterial.set_smooth(false);
	away.materials.utils.DefaultMaterialManager._defaultMaterial.set_name("defaultMaterial");
};

away.materials.utils.DefaultMaterialManager.className = "away.materials.utils.DefaultMaterialManager";

away.materials.utils.DefaultMaterialManager.getRuntimeDependencies = function(t) {
	var p;
	p = [];
	p.push('away.textures.BitmapTexture');
	p.push('away.materials.TextureMaterial');
	p.push('away.core.display.BitmapData');
	p.push('away.materials.utils.DefaultMaterialManager');
	return p;
};

away.materials.utils.DefaultMaterialManager.getStaticDependencies = function(t) {
	var p;
	return [];
};

away.materials.utils.DefaultMaterialManager.injectionPoints = function(t) {
	return [];
};

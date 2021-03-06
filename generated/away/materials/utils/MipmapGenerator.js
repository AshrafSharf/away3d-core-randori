/** Compiled by the Randori compiler v0.2.5.2 on Sat Oct 12 02:16:04 EST 2013 */

if (typeof away == "undefined")
	var away = {};
if (typeof away.materials == "undefined")
	away.materials = {};
if (typeof away.materials.utils == "undefined")
	away.materials.utils = {};

away.materials.utils.MipmapGenerator = function() {
	this._matrix = new away.core.geom.Matrix(1, 0, 0, 1, 0, 0);
	this._rect = new away.core.geom.Rectangle(0, 0, 0, 0);
	this._source = null;
	
};

away.materials.utils.MipmapGenerator._matrix = new away.core.geom.Matrix(1, 0, 0, 1, 0, 0);

away.materials.utils.MipmapGenerator._rect = new away.core.geom.Rectangle(0, 0, 0, 0);

away.materials.utils.MipmapGenerator._source;

away.materials.utils.MipmapGenerator.generateHTMLImageElementMipMaps = function(source, target, mipmap, alpha, side) {
	mipmap = mipmap || null;
	side = side || -1;
	away.materials.utils.MipmapGenerator._rect.width = source.width;
	away.materials.utils.MipmapGenerator._rect.height = source.height;
	away.materials.utils.MipmapGenerator._source = new away.core.display.BitmapData(source.width, source.height, alpha, -1);
	away.materials.utils.MipmapGenerator._source.drawImage(source, away.materials.utils.MipmapGenerator._rect, away.materials.utils.MipmapGenerator._rect);
	away.materials.utils.MipmapGenerator.generateMipMaps(away.materials.utils.MipmapGenerator._source, target, mipmap, false, -1);
	away.materials.utils.MipmapGenerator._source.dispose();
	away.materials.utils.MipmapGenerator._source = null;
};

away.materials.utils.MipmapGenerator.generateMipMaps = function(source, target, mipmap, alpha, side) {
	mipmap = mipmap || null;
	side = side || -1;
	var w = source.get_width();
	var h = source.get_height();
	var regen = mipmap != null;
	var i;
	if (!mipmap) {
		mipmap = new away.core.display.BitmapData(w, h, alpha, -1);
	}
	away.materials.utils.MipmapGenerator._rect.width = w;
	away.materials.utils.MipmapGenerator._rect.height = h;
	var tx;
	while (w >= 1 || h >= 1) {
		if (alpha) {
			mipmap.fillRect(away.materials.utils.MipmapGenerator._rect, 0);
		}
		away.materials.utils.MipmapGenerator._matrix.a = away.materials.utils.MipmapGenerator._rect.width / source.get_width();
		away.materials.utils.MipmapGenerator._matrix.d = away.materials.utils.MipmapGenerator._rect.height / source.get_height();
		mipmap.set_width(away.materials.utils.MipmapGenerator._rect.width);
		mipmap.set_height(away.materials.utils.MipmapGenerator._rect.height);
		mipmap.copyPixels(source, source.get_rect(), away.materials.utils.MipmapGenerator._rect);
		if (target instanceof away.core.display3D.Texture) {
			tx = target;
			tx.uploadFromBitmapData(mipmap, i++);
		} else {
			away.utils.Debug.throwPIR("MipMapGenerator", "generateMipMaps", "Dependency: CubeTexture");
		}
		w >>= 1;
		h >>= 1;
		away.materials.utils.MipmapGenerator._rect.width = w > 1 ? w : 1;
		away.materials.utils.MipmapGenerator._rect.height = h > 1 ? h : 1;
	}
	if (!regen) {
		mipmap.dispose();
	}
};

away.materials.utils.MipmapGenerator.className = "away.materials.utils.MipmapGenerator";

away.materials.utils.MipmapGenerator.getRuntimeDependencies = function(t) {
	var p;
	p = [];
	p.push('away.utils.Debug');
	p.push('away.materials.utils.MipmapGenerator');
	p.push('away.core.display3D.Texture');
	p.push('away.core.display.BitmapData');
	return p;
};

away.materials.utils.MipmapGenerator.getStaticDependencies = function(t) {
	var p;
	p = [];
	p.push('away.core.geom.Matrix');
	p.push('away.core.geom.Rectangle');
	return p;
};

away.materials.utils.MipmapGenerator.injectionPoints = function(t) {
	return [];
};

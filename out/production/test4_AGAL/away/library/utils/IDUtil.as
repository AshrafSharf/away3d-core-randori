/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package away.library.utils
{
	
	public class IDUtil
	{
		/**
		private static var ALPHA_CHAR_CODES = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];
		
		/**
		public static function createUID():String
		{
			var uid = new Array(36);
			var index:Number = 0;
			
			var i:Number;
			var j:Number;
			
			for (i = 0; i < 8; i++)
				uid[index++] = IDUtil.ALPHA_CHAR_CODES[Math.floor(Math.random()*16)];
			
			for (i = 0; i < 3; i++) {
				uid[index++] = 45; // charCode for "-"
				
				for (j = 0; j < 4; j++)
					uid[index++] = IDUtil.ALPHA_CHAR_CODES[Math.floor(Math.random()*16)];
			}
			
			uid[index++] = 45; // charCode for "-"
			
			var time:Number = new Date().getTime();
			// Note: time is the number of milliseconds since 1970,
			// which is currently more than one trillion.
			// We use the low 8 hex digits of this number in the UID.
			// Just in case the system clock has been reset to
			// Jan 1-4, 1970 (in which case this number could have only
			// 1-7 hex digits), we pad on the left with 7 zeros
			// before taking the low digits.
			var timeString:String = ("0000000" + time.toString(16).toUpperCase()).substr(-8);
			
			for (i = 0; i < 8; i++)
				uid[index++] = timeString.charCodeAt(i);
			
			for (i = 0; i < 4; i++)
				uid[index++] = IDUtil.ALPHA_CHAR_CODES[Math.floor(Math.random()*16)];
			
			return String.fromCharCode.apply(null, uid);
		}

		/**

	}
}
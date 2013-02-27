package helpers
{
	import flash.utils.ByteArray;

	public class ByteParser
	{
		public function ByteParser()
		{
		}
		
		public static function parseTimestamp(data:ByteArray, offset:int):Object
		{
			var ts:Number = 0;
			var byteParsed:int = 0;
			for (var i:int = 0; i < 6; i++) {
				ts = ts | data[offset] << 8 * (6 - i);
				++offset;
			}
			return {offset:offset, result:ts};
		}
		
		public static function parseShort(data:ByteArray, offset:int):Object
		{
			var short:int = 0;
			for (var i:int = 0; i < 2; i++) {
				short = short | data[offset] << 8 * (1 - i);
				++offset;
			}
			return {offset:offset, result:short};
		}
		
		public static function parseString(data:ByteArray, offset:int):Object
		{
			var l:int = data[offset] << 8 | data[offset + 1];
			offset += 2;
			var s:String = "";
			for (var i:int = 0; i < l; i++) {
				s += String.fromCharCode(data[offset++]);
			}
			return {offset:offset, result:s};
		}
	}
}
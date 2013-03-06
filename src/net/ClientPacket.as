package net
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import header.Consts;
	
	public class ClientPacket {
		private var _data:ByteArray = new ByteArray();
		private var dataBuffer:ByteArray = new ByteArray();
		private var com:int = 0;
		private var isEmpty:Boolean = true;
		
		public function ClientPacket ()
		{
			_data.endian = Endian.LITTLE_ENDIAN;
			dataBuffer.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function empty():Boolean
		{
			return this.isEmpty;
		}
		
		public function data():ByteArray
		{
			return _data;
		}
		
		public function writeCommand(com:int):void
		{
			_data.writeByte(Consts.PROTOCOL_VER);
			_data.position += Consts.LENGTH_HEADER;
			_data.writeByte(com);
			this.com = com;
		}
		
		public function getServerTime(ts:Number):Number
		{
			var d:Date = new Date();
			var t:Number = d.time;
			t = t + ts;
			return t;
		}
		
		public function writeTime(t:Number):void
		{
			var t1:int = t/1000;
			_data.writeInt(t1);
			var t2:int = t - t1*1000;
			_data.writeShort(t2);
		}
		public function writeUTFdata(s:String):void
		{	
			isEmpty = false;
			_data.writeShort(s.length);
			_data.writeUTFBytes(s);
		}
		
		public function writeByte(b:int):void
		{
			_data.writeByte(b);
		}
		
		public function writeShort(b:int):void
		{
			_data.writeShort(b);
		}
		
		public function close():void
		{
			var l:int = _data.length-1-Consts.LENGTH_HEADER;
			_data.position = 1;
			_data.writeShort(l);
			_data.position = 0;
		}
	}
}
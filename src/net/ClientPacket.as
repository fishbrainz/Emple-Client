package net
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import header.Consts;
	
	public class ClientPacket {
		private var _data:ByteArray = new ByteArray();
		private var dataBuffer:ByteArray = new ByteArray();
		private var com:int = 0;
		private var isEmpty:Boolean = true;
		
		public function ClientPacket ()
		{
			
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
			dataBuffer = new ByteArray();
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
			for (var i:int = 4; i > 0; i--) { 
				dataBuffer.writeByte(((t1 >>> 8*(i-1)) & 255));
			}
			var t2:int = t - t1*1000;
			for (i = 2; i > 0; i--) { 
				dataBuffer.writeByte(((t2 >>> 8*(i-1)) & 255));
			}
		}
		public function writeUTFdata(s:String):void
		{	
			isEmpty = false;
			for (var i:int = 2; i > 0; i--) {		
				dataBuffer.writeByte(((s.length >> 8*(i-1)) & 255)) ;
			}
			dataBuffer.writeUTFBytes(s);
		}
		
		public function writeByte(b:int):void
		{
			dataBuffer.writeByte(b);
		}
		
		public function writeShort(b:int):void
		{
			for (var i:int = 2; i > 0; i--) {		
				dataBuffer.writeByte(((b >> 8*(i-1)) & 255)) ;
			}
		}
		
		public function writeData(data:int):void
		{
			isEmpty = false;
			var v:Vector.<int> = new Vector.<int>();
			while (data > 0) {
				v.push(data & 255);
				data = data >> 8;
			}
			for (var i:int = v.length - 1; i > -1; i--) {
				dataBuffer.writeByte(v[i]);
			}
		}
		
		public function close():void
		{
			var l:int = dataBuffer.length + 1;
			var bytes:int = Consts.LENGTH_HEADER;
			while (bytes > 0) {
				bytes--;
				_data.writeByte((l >> (8*bytes)) & 255);
			}
			_data.writeByte(this.com);
			_data.writeBytes(dataBuffer);
		}
	}
}
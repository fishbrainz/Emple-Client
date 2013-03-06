package net
{
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import header.Consts;
	
	public class StreamParser
	{
		private var _data:ByteArray = new ByteArray();
		private var data_offset:int = 0;
		private var bytes_to_read:int = 0;
		private var connection:Connection;
		private var data_callback:Function;
		private var packetLength:int;
		
		public function StreamParser(connection:Connection, f:Function)
		{
			_data.endian = Endian.LITTLE_ENDIAN;
			this.connection = connection;
			this.data_callback = f;
			waitForHeader();
		}
		
		private function accept(s:Socket, length:int, f:Function, after_cb:Function = null):void
		{
			if (length <= 0) {
				return;
			}
			bytes_to_read = s.bytesAvailable;
			if (bytes_to_read > length - data_offset) {
				bytes_to_read = length - data_offset;
			}
			s.readBytes(_data, data_offset, bytes_to_read);
			data_offset += bytes_to_read;
			if (data_offset >= length) {
				data_offset = 0;
				f(_data, packetLength);
				if (after_cb) {
					after_cb();
				}
				return;
			}
		}
		
		private function waitForHeader():void
		{
			connection.setDataHandler(handleHeader);
		}
		
		
		private function handleHeader(e:ProgressEvent):void
		{
			accept((e.target as Socket), Consts.HEADER_SIZE, parseHeader);
		}
		
		private function parseHeader(data:ByteArray, f:int):void
		{
			if (data[0] != Consts.PROTOCOL_VER) {
				
			}
			packetLength = data[1] << 8 | data[2];
			accept(connection.getSocket(), packetLength, data_callback, waitForHeader);
			connection.setDataHandler(handlePacket);
		}
		
		
		private function handlePacket(e:ProgressEvent):void
		{
			accept((e.target as Socket), packetLength, data_callback, waitForHeader);
		}
	}
}
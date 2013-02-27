package net
{
	import flash.events.*;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class Connection
	{
		private var socket:Socket;
		private var data_callback:Function;
		private var error_callback:Function;
		private var host:String;
		private var port:int;
		
		public function Connection(host:String, port:int)
		{
			socket = new Socket();
			socket.addEventListener(Event.CONNECT, handleConnect);
			this.host = host;
			this.port = port;
		}
		
		
		public function close():void
		{
			socket.close();
		}
		
		
		public function connect(error_handler:Function):void
		{
			socket.connect(host, port);
			socket.addEventListener(IOErrorEvent.IO_ERROR, error_handler);
		}
		
		
		public function setErrorHandler(handler:Function):void
		{
			error_callback = handler;
		}
		
		
		public function setDataHandler(handler:Function):void
		{
			if (data_callback) {
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, data_callback);
				data_callback = null;
			}
			data_callback = handler;
			socket.addEventListener(ProgressEvent.SOCKET_DATA, data_callback);
		}
		
		
		private function handleConnect(event:Event):void
		{
			
		}
		
		
		public function sendPacket(p:ClientPacket):void
		{
			socket.writeBytes(p.data());
		}
		
		
		public function getSocket():Socket
		{
			return socket;
		}
	}
}
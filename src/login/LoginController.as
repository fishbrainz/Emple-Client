package login
{
	import flash.events.*;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	
	import header.Consts;
	import header.OPcodes;
	
	import helpers.ByteParser;
	
	import net.ClientPacket;
	import net.Connection;
	import net.ConnectionManager;
	import net.StreamParser;
	
	public class LoginController
	{
		private static var streamParser:StreamParser;
		private static var con:Connection;
		private static var bytesOffset:int = 0;
		private static var errorHandler:Function;
		private static var email:String = "deniraxxx@mail.ru";
		private static var passwd:String = "deniraxxx@mail.ru";
		
		public function LoginController()
		{
		}
		
		public static function loginUser(email:String, passwd:String, errorHandler:Function):void
		{
			LoginController.email = email;
			LoginController.passwd = passwd;
			con = ConnectionManager.getConnection(Consts.LOGIN_SERVER_HOST, Consts.LOGIN_SERVER_PORT, "LoginConnection");
			streamParser = new StreamParser(con, handleLoginStream); 
			LoginController.errorHandler = errorHandler;
			con.connect(sendLoginInformation, LoginController.errorHandler);
		}
		
		private static function sendLoginInformation(event:Event):void
		{
			trace("sendLoginInformation");
			var packet:ClientPacket = new ClientPacket();
			packet.writeCommand(OPcodes.LOGIN);
			packet.writeUTFdata(LoginController.email);
			packet.writeUTFdata(LoginController.passwd);
			packet.close();
			con.sendPacket(packet);
		}
		
		private static function handleLoginStream(data:ByteArray, packetLength:int):void
		{
			data.position = 0;
			var com:int;
			while (data.position < packetLength-1) {
				com = data.readByte();
				trace("command", com);
				switch (com) {
					case OPcodes.HERO_LIST:
						handleHeroList(data);
						break;
					case OPcodes.SERVER_LIST:
						handleServerList(data);
						break;
					case OPcodes.RESPONSE_CODE:
						handleResponseCode(data);
						break;
				}
			}
		}
		
		private static function handleHeroList(data:ByteArray):void
		{
			var total = data.readShort();
			var heroList:Vector.<Object> = new Vector.<Object>();
			var i:int = 0;
			var hero:Object = {};
			while (i < total) {
				++i;
				hero.hero_name = data.readUTF();
				hero.hero_class = data.readByte();
				hero.level = data.readByte();
				trace(hero);
				heroList.push(hero);
			}
		}
		
		private static function handleResponseCode(data:ByteArray):void
		{
			trace(data.readByte());
		}
		
		private static function handleServerList(data:ByteArray):void
		{
			trace("handleServerList");
			var serverList:Vector.<Object> = new Vector.<Object>();
			var result:Object = ByteParser.parseShort(data, bytesOffset);
			var total:int = data.readShort();
			var server:Object = {};
			for (var i:int = 0; i < total; ++i) {
				server["name"] = data.readUTF();
				server["ip"] = data.readUTF();
				server["port"] = data.readShort();
				serverList.push(server);
			}
			bytesOffset = result.offset;
			ConnectionManager.deleteConnection("LoginConnection");
			con = ConnectionManager.getConnection(serverList[0].ip, serverList[0].port, "LoginConnection");
			streamParser = new StreamParser(con, handleLoginStream); 
			con.connect(sendLoginInformation, LoginController.errorHandler);
		}
	}
}
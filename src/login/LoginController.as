package login
{
	import flash.utils.ByteArray;
	
	import net.Connection;
	import net.ConnectionManager;
	import net.StreamParser;
	import header.OPcodes;
	import header.Consts;
	import helpers.ByteParser;
	import net.ClientPacket;
	
	public class LoginController
	{
		private static var streamParser:StreamParser;
		private static var con:Connection;
		private static var bytesOffset:int = 0;
		
		public function LoginController()
		{
		}
		
		public static function loginUser(email:String, passwd:String):void
		{
			con = ConnectionManager.getConnection(Consts.LOGIN_SERVER_HOST, Consts.LOGIN_SERVER_PORT, "LoginConnection");
			streamParser = new StreamParser(con, handleLoginStream); 
			con.connect(errorHandler);
		}
		
		private static function handleLoginStream(data:ByteArray, packetLength:int):void
		{
			var com:int = data[bytesOffset++];
			while (bytesOffset < packetLength) {
				switch (com) {
					case OPcodes.HERO_LIST:
						//handleHeroList(data);
						break;
					case OPcodes.SERVER_LIST:
						handleServerList(data);
						break;
					case OPcodes.RESPONSE_CODE:
						//handleResponseCode(data);
						break;
				}
			}
			bytesOffset = 0;
		}
		
		private static function handleServerList(data:ByteArray):void
		{
			var serverList:Vector.<Object> = new Vector.<Object>();
			var result:Object = ByteParser.parseShort(data, bytesOffset);
			var total:int = result.result;
			var server:Object = {};
			for (var i:int = 0; i < total; ++i) {
				result = ByteParser.parseString(data, result.offset);
				server["name"] = result.result;
				result = ByteParser.parseString(data, result.offset);
				server["ip"] = result.result;
				result = ByteParser.parseString(data, result.offset);
				server["port"] = result.result;
				serverList.push(server);
			}
			con.close();
			con = ConnectionManager.getConnection(serverList[0].ip, serverList[0].port, "LoginConnection");
			streamParser = new StreamParser(con, handleLoginStream); 
			
			var packet:ClientPacket = new ClientPacket();
			packet.writeCommand(OPcodes.LOGIN);
			packet.writeUTFdata("deniraxxx@mail.ru");
			packet.writeUTFdata("password");
			packet.close();
			
			con.sendPacket(packet);
		}
		
		
		private static function errorHandler(e:ProgressEvent):void
		{
			
		}
	}
}
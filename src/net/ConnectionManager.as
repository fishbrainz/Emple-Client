package net
{
	import net.Connection;
	
	public class ConnectionManager
	{
		private static var connections:Object = {};
		
		public function ConnectionManager()
		{
		}
		
		
		public static function getConnection(url:String, port:int, id:String):Connection
		{
			if (!connections[id]) {
				connections[id] = new Connection(url, port);
			}
			return connections[id];
		}
		
		
		public static function deleteConnection(id:String):void
		{
			if (connections[id]) {
				connections[id].close();
				delete connections[id];
			}
		}
	}
}
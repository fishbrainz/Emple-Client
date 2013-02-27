package scene
{
	import com.saia.starlingPunk.SPWorld;
	import scene.LoginScene;
	
	public class SceneController
	{
		private static var scenes:Vector.<SPWorld> = new <SPWorld>[new LoginScene()];
		
		
		public static function getLoginScene():SPWorld
		{
			return scenes[0];
		}
	}
}
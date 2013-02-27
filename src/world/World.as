package world
{
	import com.saia.starlingPunk.SP;
	import com.saia.starlingPunk.SPEngine;
	import scene.SceneController;
	import gui.GuiController;

	public class World extends SPEngine
	{
		public function World()
		{
			super();
		}
		
		
		override public function init():void 
		{
			super.init();
			GuiController.init(stage);
			SP.world = SceneController.getLoginScene();
		}
	}
}
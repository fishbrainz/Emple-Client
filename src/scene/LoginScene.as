package scene
{
	import com.saia.starlingPunk.SPWorld;
	import gui.GuiController;
	import com.saia.starlingPunk.SPEntity;
	
	public class LoginScene extends SPWorld
	{
		public function LoginScene()
		{
			super();
		}
		
		
		override public function begin():void 
		{
			super.begin();
			GuiController.switchGuiLayer("LoginGuiLayer");
		}
		
		
		override public function end():void 
		{
			super.end();
			removeAll();
			removeChildren(0, -1, true);
		}
		
		
		override public function update():void 
		{
			super.update();
		}
	}
}
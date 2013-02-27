package gui
{
	import gui.CommonGUI;
	
	import starling.display.Stage;
	
	public class GuiController
	{
		private static var layers:Vector.<CommonGUI> = new Vector.<CommonGUI>();
		
		public function GuiController()
		{
		}
		
		
		public static function init(stage:Stage):void
		{
			layers.push(new LoginGuiLayer(stage));
		}
		
		
		public static function getGuiLayer(l:String):CommonGUI
		{
			if (l == "LoginGuiLayer") {
				return layers[0];
			}
			
			return layers[0];
		}
		
		
		public static function switchGuiLayer(l:String):void
		{
			if (l == "LoginGuiLayer") {
				layers[0].show();
			}
		}
	}
}
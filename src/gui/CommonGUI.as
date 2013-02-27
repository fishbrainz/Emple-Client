package gui
{
	import com.saia.starlingPunk.SP;
	import com.saia.starlingPunk.graphics.*;
	import com.saia.starlingPunk.utils.Key;
	import com.saia.starlingPunk.utils.SPInput;
	
	import starling.display.DisplayObject;
	import starling.display.Stage;
	
	public class CommonGUI
	{
		protected var components:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		protected var stage:Stage;
		
		public function CommonGUI(stage:Stage)
		{
			this.stage = stage;
		}
		
		
		public function show():void
		{
			SP.world.removeChildren(0, -1, true);
			for (var i:int = 0; i < components.length; ++i) {
				SP.world.addChild(components[i]);
			}
		}
		
		protected function onShow():void
		{
			
		}
	}
}
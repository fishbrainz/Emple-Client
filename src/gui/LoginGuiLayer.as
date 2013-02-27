package gui
{
	import com.saia.starlingPunk.SP;
	import com.saia.starlingPunk.utils.Key;
	import com.saia.starlingPunk.utils.SPInput;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.themes.AeonDesktopTheme;
	
	import gui.CommonGUI;
	
	import login.LoginController;
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class LoginGuiLayer extends CommonGUI
	{
		private var theme:AeonDesktopTheme;
		private var login_input:TextInput;
		private var password:TextInput;
		private var p_label:Label;
		private var l_label:Label;
		private var button:Button;
		
		private function customCalloutFactory():Callout
		{
			var callout:Callout = new Callout();
			callout.nameList.add( "my-custom-callout" );
			return callout;
		};
		
		public function LoginGuiLayer(stage:Stage)
		{
			super(stage);
			theme = new AeonDesktopTheme(this.stage);

			login_input = new TextInput();
			login_input.text = "";
			login_input.width = 200;
			login_input.height = 25;
			login_input.x = (stage.stageWidth - login_input.width) / 2;
			login_input.y = (stage.stageHeight - login_input.height) / 2 - 75;
			components.push(login_input);
			
			l_label = new Label();
			l_label.text = "E-mail";
			l_label.x = login_input.x - 40;
			l_label.y = login_input.y;
			components.push(l_label);
			
			password = new TextInput();
			password.textEditorProperties
			password.width = 200;
			password.height = 25;
			password.x = (stage.stageWidth - password.width) / 2;
			password.y = (stage.stageHeight - password.height) / 2 - 50;
			password.text = "";
			components.push(password);
			
			p_label = new Label();
			p_label.text = "Password";
			p_label.x = password.x - 63;
			p_label.y = password.y;
			components.push(p_label);
			
			button = new Button();
			button.label = "Login";
			button.validate();
			button.x = (stage.stageWidth - button.width) / 2;
			button.y = (stage.stageHeight - button.height) / 2 - 25;
			button.addEventListener(Event.TRIGGERED, handleClick);
			components.push(button);
		}
		
		
		private function handleClick(event:Event):void
		{
			LoginController.loginUser(login_input.text, password.text);
		}
	}
}
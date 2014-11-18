package  utils.console
{
	import com.junkbyte.console.Cc;
	
	import flash.display.DisplayObject;

	public function initConsole(root:DisplayObject):void
	{
		CONFIG::IMPOLDER
		{
			Cc.startOnStage(root, "`");
			Cc.commandLine = true;
			Cc.remoting = true;
			Cc.config.alwaysOnTop = true;
			Cc.config.commandLineAllowed = true;
			Cc.visible = true;
			Cc.width = 400;
			Cc.height = 300;
			Cc.y = 25;
		}
	}
}
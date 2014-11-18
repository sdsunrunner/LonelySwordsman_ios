package
{
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	import frame.facade.AppFacade;
	
	import game.command.startApp.StartAppAnsyCommand;
	import game.command.startApp.StartAppMacroCommand;
	import game.interactionType.CommandInteracType;
	import game.manager.uiManager.UIManager;
	
	import lzm.starling.STLMainClass;
	
	import starling.events.Event;
	
	/**
	 * 游戏入口 
	 * @author songdu.greg
	 * 
	 */	
	public class Game extends STLMainClass
	{
		private var _commandFacade:AppFacade = null;
		
		public function Game()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initialize);
			UIManager.instance.registerStage();
			this.initApp();
			
			this.alpha = 0.999;
		}
		
		private function initApp():void
		{
			_commandFacade = AppFacade.instance;
			_commandFacade.addCommand(CommandInteracType.STARTAPP_COMMAND,StartAppMacroCommand);
			_commandFacade.addCommand(CommandInteracType.STARTAPP_ASYNC_COMMAND,StartAppAnsyCommand);
			
			this.notify(CommandInteracType.STARTAPP_COMMAND);
			this.notify(CommandInteracType.STARTAPP_ASYNC_COMMAND);
		}
		
		private function notify(type:String, data:* = null):void
		{
			var notificaion:INotification = new BaseNotification();
			notificaion.data = data;
			
			var note:AppNotification = new AppNotification(type,notificaion);
			note.dispatch();
		}
	}
}
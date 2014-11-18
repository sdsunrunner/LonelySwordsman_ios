package game.view.gameInnerGui
{
	import game.basewidget.ScenceBaseSensor;
	import game.command.share.ShareTypeEnum;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.event.MainScenceEvent;
	
	import starling.events.Event;
	
	/**
	 * 游戏关卡内菜单 
	 * @author admin
	 * 
	 */	
	public class GameInnerMenu extends ScenceBaseSensor
	{
		private var _view:GameInnerMenuView = null;
		
		public function GameInnerMenu(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_view = new GameInnerMenuView();
					params.view = _view;
				}
			}
			super(name, params);
			this.addListeners();
			this.touchable = true;
		}
		
		private function addListeners():void
		{
			_view.addEventListener(MainScenceEvent.SHOW_MAIN_MENU,showMainMenuhnadler);
			_view.addEventListener(MainScenceEvent.REST_GAME_LEV,resetGameLevHandler);
			_view.addEventListener(MainScenceEvent.SHARE_GAME_LEV,shareGameLevHandler);
		}
		
		private function showMainMenuhnadler(evt:Event):void
		{
			this.touchable = false;
			this.sendNotification(CommandViewType.SHOW_MAIN_MENU_SCENCE);
		}
		
		private function resetGameLevHandler(evt:Event):void
		{
			this.touchable = false;
			this.sendNotification(CommandViewType.GAME_LEVEL_RESET);
		}
		
		private function shareGameLevHandler(evt:Event):void
		{
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIXIN,ShareTypeEnum.SHARE_GAME_LEV);
		}
	}
}
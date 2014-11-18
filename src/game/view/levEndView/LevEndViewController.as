package game.view.levEndView
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.command.share.ShareTypeEnum;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.event.MainScenceEvent;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * 关卡结束视图控制器 
	 * @author admin
	 * 
	 */	
	public class LevEndViewController extends BaseViewerController
	{
		private var _view:LevEndView = null;
		public function LevEndViewController()
		{
			super();
			initView();
			addListeners();
		}
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function dispose():void
		{
			_view.dispose();
			_view = null;
		}
		
		private function initView():void
		{
			_view = new LevEndView();
		}
		
		private function addListeners():void
		{
			_view.addEventListener(MainScenceEvent.GAME_LEV_CONTINUE, gameLevContinueHandler);
			_view.addEventListener(MainScenceEvent.SHOW_MAIN_MENU, showMainMenuhandler);
			_view.addEventListener(MainScenceEvent.GOTO_GIVE_SCORE, giveScoreHandler);
			_view.addEventListener(MainScenceEvent.SHARE_TO_WEIXIN, shareToWeiXinHandler);
			_view.addEventListener(MainScenceEvent.SHARE_TO_WEIBO, shareToWeiBoHandler);
		}
		
		private function shareToWeiBoHandler():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIBO,ShareTypeEnum.SHARE_GAME);
		}
		
		private function showMainMenuhandler():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandViewType.CLOSE_GAME_LEV_END_VIEW);
			this.sendNotification(CommandViewType.SHOW_MAIN_MENU_SCENCE);
			
			
//			PlayerBehaviorAnalyseManager.instance.umeng.dispatchEvent("backToWelcomeScence");
		}
		
		private function gameLevContinueHandler(evt:Event):void
		{
//			PlayerBehaviorAnalyseManager.instance.umeng.dispatchEvent("gameLevContinue");
			// TODO Auto Generated method stub
			this.sendNotification(CommandViewType.CLOSE_GAME_LEV_END_VIEW);
			this.sendNotification(CommandViewType.GAME_LEVEL_VIEW);
//			this.sendNotification(CommandViewType.LEV_REPORT_VIEW);
		}
		
		private function giveScoreHandler():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandInteracType.GIVE_SCORE,"levEnd");
		}
		private function shareToWeiXinHandler():void
		{
			var playerInfo:ObjPlayerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			var killCount:Number = playerInfo.killCount
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIXIN,"击杀总数"+killCount.toString());
		}
	}
}
package game.command.startApp
{
	import frame.command.SuperCommand;
	import frame.command.cmdInterface.INotification;
	import frame.facade.AppFacade;
	
	import game.command.CallMeCommand;
	import game.command.GameEndHandlerCommand;
	import game.command.GiveScoreCommand;
	import game.command.closeView.CloseGameLevEndReportViewCommand;
	import game.command.closeView.CloseGameLevEndViewCommand;
	import game.command.closeView.CloseScenceSwitchViewCommand;
	import game.command.closeView.CloseStoreViewCommand;
	import game.command.closeView.CloseWelcomeViewCommand;
	import game.command.effect.ZoomCameraCommand;
	import game.command.gameLev.GameLevResetCommand;
	import game.command.gameLev.GameLevSwitchCommand;
	import game.command.gameLev.GameLevelHandlerCommand;
	import game.command.gameLev.ShowGameLevViewCommand;
	import game.command.gameLev.ShowGameMainMenuScenceCommand;
	import game.command.gameLev.StartNewGameCgEndCommand;
	import game.command.gameLev.StartNewGameCommand;
	import game.command.gameMenu.GameEndHeroRebornCommand;
	import game.command.gameMenu.GameEndShowMainMenuScenceCommand;
	import game.command.initApplication.GameWelcomeScenceInitCommand;
	import game.command.initGameLev.InitGameAnsyCommand;
	import game.command.initGameLev.ShowGameLevCommand;
	import game.command.initGameLev.WelcomeScenceClearCommand;
	import game.command.share.ShareToWeiBoCommand;
	import game.command.share.ShareToWeiXinImageCommand;
	import game.command.showView.ShowAlertViewCommand;
	import game.command.showView.ShowBgMountainViewCommand;
	import game.command.showView.ShowBgPillarViewCommand;
	import game.command.showView.ShowControlleViewCommand;
	import game.command.showView.ShowEmptyViewCommand;
	import game.command.showView.ShowGameEndMenuCommand;
	import game.command.showView.ShowGameLevEndViewCommand;
	import game.command.showView.ShowGuiViewCommand;
	import game.command.showView.ShowLevReportViewCommand;
	import game.command.showView.ShowScenceSwitchViewCommand;
	import game.command.showView.ShowStartCgViewCommand;
	import game.command.showView.ShowStoreViewCommand;
	import game.command.showView.ShowWelcomeViewCommand;
	import game.command.sound.BuildRoleSoundCommand;
	import game.command.store.BuyProductCommand;
	import game.command.store.GameLevPauseShowStoreViewCoommand;
	import game.command.store.buySuccess.BuyBossSuccessCommand;
	import game.command.store.buySuccess.BuyHeroPhSuccessCommand;
	import game.command.store.buySuccess.BuyProtoSuccessCommand;
	import game.command.storyCg.ShowStoryCgCommand;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	
	/**
	 * 启动命令，注册对command的映射 
	 * @author songdu.greg
	 * 
	 */	
	public class StartApplicationCommand extends SuperCommand
	{
		private var _facade:AppFacade = AppFacade.instance;
		
//==============================================================================
// Public Functions
//==============================================================================
		
		override public function excute(note:INotification):void
		{
			this.addCommandForSys();
			this.addCommandForShowView();
			this.addCommandForCloseView();
			this.addCommandForInitGame();
			this.addCommandForGameLevHandle();
			this.addCommandForGameLevSensor();
			this.addCommandForGameEnd();
			this.addCommandForShowCg();
			this.addCommandForStore();
			this.addCommandForEffect();
			this.addCommandForSns();
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		
		private function addCommandForSys():void
		{
			_facade.addCommand(CommandInteracType.SCENCE_WELCOME_INIT, GameWelcomeScenceInitCommand);
			_facade.addCommand(CommandInteracType.START_NEW_GAME, StartNewGameCommand);
			_facade.addCommand(CommandInteracType.GAME_PAUSE_SHOW_STORE, GameLevPauseShowStoreViewCoommand);			
			_facade.addCommand(CommandInteracType.START_NEW_GAME_CG_END, StartNewGameCgEndCommand);
			_facade.addCommand(CommandInteracType.GIVE_SCORE, GiveScoreCommand);
			_facade.addCommand(CommandInteracType.CALL_ME, CallMeCommand);
			
		}
		
		/**
		 * 注册显示视图命令 
		 * 
		 */		
		private function addCommandForShowView():void
		{
			
			_facade.addCommand(CommandViewType.BG_MOUNTAIN_VIEW, ShowBgMountainViewCommand);
			_facade.addCommand(CommandViewType.WELCOME_SCENCE, ShowWelcomeViewCommand);
			_facade.addCommand(CommandViewType.CONTROLLE_VIEW, ShowControlleViewCommand);
			_facade.addCommand(CommandViewType.GAME_GUI_VIEW, ShowGuiViewCommand);
			_facade.addCommand(CommandViewType.BG_PILLAR_VIEW, ShowBgPillarViewCommand);
			_facade.addCommand(CommandViewType.EMPTY_BG, ShowEmptyViewCommand);
			_facade.addCommand(CommandViewType.SCENCE_SWITCH, ShowScenceSwitchViewCommand);
			
			_facade.addCommand(CommandViewType.GAMEEND_MENU, ShowGameEndMenuCommand);
			_facade.addCommand(CommandViewType.GAME_STORY_START_CG, ShowStartCgViewCommand);
			_facade.addCommand(CommandViewType.PRODUCT_STORE_VIEW, ShowStoreViewCommand);
			
			_facade.addCommand(CommandViewType.INFO_ALERT_VIEW, ShowAlertViewCommand);
			_facade.addCommand(CommandViewType.GAME_LEV_END_VIEW, ShowGameLevEndViewCommand);
			_facade.addCommand(CommandViewType.LEV_REPORT_VIEW, ShowLevReportViewCommand);
		}
		
		/**
		 * 注册关闭视图命令 
		 * 
		 */		
		private function addCommandForCloseView():void
		{
			_facade.addCommand(CommandViewType.CLOSE_WELCOME_SCENCE, CloseWelcomeViewCommand);
			_facade.addCommand(CommandViewType.CLOSE_SCENCE_MASK, CloseScenceSwitchViewCommand);
			_facade.addCommand(CommandViewType.CLOSE_STORE_VIEW, CloseStoreViewCommand);
			_facade.addCommand(CommandViewType.CLOSE_GAME_LEV_END_VIEW, CloseGameLevEndViewCommand);
			_facade.addCommand(CommandViewType.CLOSE_GAME_LEV_END_REPORT_VIEW, CloseGameLevEndReportViewCommand);
			
		}
		
		private function addCommandForInitGame():void
		{
			_facade.addCommand(CommandInteracType.CLEAR_WELCOME_SCENCE, WelcomeScenceClearCommand);
			_facade.addCommand(CommandInteracType.INIT_GAME_ANSY, InitGameAnsyCommand);
			_facade.addCommand(CommandInteracType.PRE_BUILD_SOUND, BuildRoleSoundCommand);
		}
		/**
		 * 注册关卡的处理命令 
		 * 
		 */		
		private function addCommandForGameLevHandle():void
		{
			_facade.addCommand(CommandViewType.SHOW_GAME_LEVEL_VIEW, ShowGameLevViewCommand);
			_facade.addCommand(CommandViewType.GAME_LEVEL_RESET, GameLevResetCommand);
			_facade.addCommand(CommandViewType.GAME_LEVEL_VIEW, GameLevelHandlerCommand);
			_facade.addCommand(CommandViewType.SHOW_MAIN_MENU_SCENCE, ShowGameMainMenuScenceCommand);	
			_facade.addCommand(CommandViewType.SHOW_GAME_LEVEL_VIEW_SCENCE, ShowGameLevCommand);
		}
		
		
		/**
		 * 关卡探测器 
		 * 
		 */		
		private function addCommandForGameLevSensor():void
		{
			_facade.addCommand(CommandInteracType.GAME_LEV_END_SENSOR_ACTIVE, GameLevSwitchCommand);
		}
		
		private function addCommandForGameEnd():void
		{
			_facade.addCommand(CommandInteracType.GAME_END_HERO_REBORN, GameEndHeroRebornCommand);
			_facade.addCommand(CommandInteracType.GAME_END_SHOW_MAIN_MENU_SCENCE, GameEndShowMainMenuScenceCommand);
			_facade.addCommand(CommandInteracType.GAME_END_HANDLER, GameEndHandlerCommand);
			
		}
		
		private function addCommandForShowCg():void
		{
			_facade.addCommand(CommandInteracType.SHOW_STORY_CG, ShowStoryCgCommand);
		}
		
		private function addCommandForStore():void
		{
			_facade.addCommand(CommandInteracType.BUY_HERO_PH_SUCCESS, BuyHeroPhSuccessCommand);
			_facade.addCommand(CommandInteracType.BUY_BOSS_SUCCESS, BuyBossSuccessCommand);
			_facade.addCommand(CommandInteracType.BUY_PROTO_SUCCESS, BuyProtoSuccessCommand);
			
			_facade.addCommand(CommandInteracType.BUY_GOODS_REQ, BuyProductCommand);			
		}
		
		private function addCommandForEffect():void
		{
			_facade.addCommand(CommandInteracType.CAMERA_ZOOM_EFFECT, ZoomCameraCommand);
		}
		
		private function addCommandForSns():void
		{
			_facade.addCommand(CommandInteracType.SHARE_IMAGE_TO_WEIXIN, ShareToWeiXinImageCommand);
			_facade.addCommand(CommandInteracType.SHARE_IMAGE_TO_WEIBO, ShareToWeiBoCommand);
		}
	}
}
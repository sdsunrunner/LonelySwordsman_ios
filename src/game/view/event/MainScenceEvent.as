package game.view.event
{
	/**
	 * 欢迎场景事件 
	 * @author songdu.greg
	 * 
	 */	
	public class MainScenceEvent 
	{
		/**
		 * 视图 动画完成
		 */		
		public static const NOTE_VIEW_READY:String = "NOTE_VIEW_READY";
		
		/**
		 * 开始游戏 关卡
		 */		
		public static const START_GAME_LEV:String = "START_GAME_LEV";
		public static const START_NEW_GAME:String = "START_NEW_GAME";		
		
		/**
		 * 视图准备销毁 
		 */		
		public static const HIDE_VIEW_READY:String = "HIDE_VIEW_READY";
		
		/**
		 * 生存模式按钮点击 
		 */		
		public static const SURVIVAL_MODEL_BTN_CLICK:String = "SURVIVAL_MODEL_BTN_CLICK";
		
		public static const SHOW_STORE:String = "SHOW_STORE";
		
		public static const CALL_ME:String = "CALL_ME";
		
		/**
		 * 决斗模式按钮点击 
		 */		
		public static const BATTLE_MODEL_BTN_CLICK:String = "BATTLE_MODEL_BTN_CLICK";
		
		public static const BATTLE_MODEL_CLOSE_BTN_CLICK:String = "BATTLE_MODEL_CLOSE_BTN_CLICK";
		public static const STORE_CLOSE_BTN_CLICK:String = "STORE_CLOSE_BTN_CLICK";
		public static const BATTLE_MODEL_START:String = "BATTLE_MODEL_START";
		
		/**
		 * 重玩关卡 
		 */		
		public static const REST_GAME_LEV:String = "REST_GAME_LEV";
		
		public static const SHARE_GAME_LEV:String = "SHARE_GAME_LEV";
		
		/**
		 * 显示主菜单 
		 */		
		public static const SHOW_MAIN_MENU:String = "SHOW_MAIN_MENU";
		
		/**
		 * 显示游戏结束菜单 
		 */		
		public static const SHOW_GAME_END_VIEW:String = "SHOW_GAME_END_VIEW";
		
		/**
		 * 游戏结束重玩关卡 
		 */		
		public static const GAME_END_REST_GAME_LEV:String = "GAME_END_REST_GAME_LEV";
		
		/**
		 * 游戏结束显示主菜单
		 */		
		public static const GAME_END_SHOW_MAIN_MENU_SCENCE:String = "GAME_END_SHOW_MAIN_MENU_SCENCE";
		
		/**
		 * 游戏结束显示更多游戏
		 */		
		public static const GAME_END_SHOW_MORE_GAME:String = "GAME_END_SHOW_MORE_GAME";
		
		public static const CG_SCENCE_END:String = "CG_SCENCE_END";
		
		public static const GAME_END:String = "GAME_END";
		
		public static const GAME_START_CG_END:String = "GAME_START_CG_END";
		
		public static const SHARE_TO_WEIXIN:String = "SHARE_TO_WEIXIN";
		public static const SHARE_TO_WEIBO:String = "SHARE_TO_WEIBO";
		
	
		public static const GAME_LEV_CONTINUE:String = "GAME_LEV_CONTINUE";
		
		public static const GOTO_GIVE_SCORE:String = "GOTO_GIVE_SCORE";
		
		public static const CLOSE_BATTLE_END_RESULR_VIEW:String = "CLOSE_BATTLE_END_RESULR_VIEW";
	}
}
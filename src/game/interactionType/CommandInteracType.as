package game.interactionType
{
	/**
	 * 交互类别 
	 * @author admin
	 * 
	 */	
	public class CommandInteracType
	{
//==============================================================================
// 系统级交互
//==============================================================================
		public static const STARTAPP_COMMAND:String = "STARTAPP_COMMAND";
		
		public static const STARTAPP_ASYNC_COMMAND:String = "STARTAPP_ASYNC_COMMAND";
		
		public static const SCENCE_WELCOME_INIT:String = "SCENCE_WELCOME_INIT";
		
		public static const CLEAR_WELCOME_SCENCE:String = "CLEAR_WELCOME_SCENCE";
		
		public static const INIT_GAME_ANSY:String = "INIT_GAME_ANSY";
		public static const PRE_BUILD_SOUND:String = "PRE_BUILD_SOUND";
		
		public static const START_NEW_GAME:String = "START_NEW_GAME";
		
		public static const GAME_PAUSE_SHOW_STORE:String = "GAME_PAUSE_SHOW_STORE";
		
		public static const START_NEW_GAME_CG_END:String = "START_NEW_GAME_CG_END";
		public static const GIVE_SCORE:String = "GIVE_SCORE";
		public static const CALL_ME:String = "CALL_ME";
//==============================================================================
// 场景探测器交互
//==============================================================================
		/**
		 * 关卡结束探测器 
		 */		
		public static const GAME_LEV_END_SENSOR_ACTIVE:String = "SCENCE_END_SENSOR_ACTIVE";
		
		/**
		 * 游戏结束处理 
		 */		
		public static const GAME_END_HANDLER:String = "GAME_END_HANDLER";
//==============================================================================
// 游戏结束
//==============================================================================
		public static const GAME_END_HERO_REBORN:String = "GAME_END_HERO_REBORN";
		public static const GAME_END_SHOW_MAIN_MENU_SCENCE:String = "GAME_END_SHOW_MAIN_MENU_SCENCE";
		public static const SHOW_STORY_CG:String = "SHOW_STORY_CG";
		
		public static const BUY_HERO_PH_SUCCESS:String = "BUY_HERO_PH_SUCCESS";
		
		public static const BUY_BOSS_SUCCESS:String = "BUY_BOSS_SUCCESS";
		
		public static const BUY_PROTO_SUCCESS:String = "BUY_PROTO_SUCCESS";
		
		public static const BUY_GOODS_REQ:String = "BUY_GOODS_REQ";
		
		public static const CAMERA_ZOOM_EFFECT:String = "CAMERA_ZOOM_EFFECT";
		
		public static const SHARE_IMAGE_TO_WEIXIN:String = "STARE_IMAGE_TO_WEIXIN";
		
		public static const SHARE_IMAGE_TO_WEIBO:String = "STARE_IMAGE_TO_WEIBO";
	}
}
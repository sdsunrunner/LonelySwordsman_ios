package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import starling.core.Starling;

	public class Const
	{
		
		//是否支持分享到sina微博
		public static const SHARE_TO_SINA_WEIBO:Boolean = false;
//==============================================================================
// ANE	
//==============================================================================
		//微信分享
		public static const WEI_XIN_APP_ID:String = "wxd91ce2df8b832590";
		
		//微博
		public static const WEI_BO_APP_KEY:String = "2840808434";
		public static const WEI_BO_APP_SECRET:String = "c77bbc6e9c8831879a47dc1dd4680390";
		
		public static const APP_URL:String = "itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id726049617?mt=8";		
		
		public static const CALL_ME:String = "http://bbs.9ria.com/thread-282323-1-1.html";
		
		public static const APP_PINGFEN_URL:String = "http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=726049617&type=Purple+Software"
			
		public static const QQ_WEI_BO_APP_KEY:String = "801487726";
		public static const QQ_WEI_BO_APP_SECRET:String = "1ad93c3f193b6f89f2031205c52f016e";
		
		public static const UMENG_KEY:String = "531935f556240bf98200e6be";
		
//==============================================================================
// base	
//==============================================================================		
		public static const GAME_ANIMA_FRAMERATE:Number = 60;
		public static const FRAME_DELAY:Number = 60;
		public static var starlingInstance:Starling = null;
		public static var gameInitEd:Boolean = false;	
		
		public static const GAME_CG_ANIMA_FRAMERATE:Number = 30;
		
		
		public static const HP_PROTO_INIT_COUNT:Number = 10;
		public static const MP_PROTO_INIT_COUNT:Number = 5;
		
		public static const BASE_CAMERA_ZOOM:Number = 1.5;
		
//==============================================================================
// value	
//==============================================================================
		/**
		 * 爬梯子上升速度 
		 */		
		public static const LADDER_UP_SPEED:Number = 25;
		
		/**
		 * 小落石伤害 
		 */		
		public static const SMALL_ROCK_HIT_VALUE:Number = 3;
		
		/**
		 * 落石持续时间 
		 */		
		public static const FALL_ROCK_TIME_SPACE:Number = 5000;
		
		public static const HERO_HEAVY_ATTACK_COST_MP:Number = 30;
		
		/**
		 * 可以格挡的伤害上限 
		 */		
		public static const HERO_BLOCK_BUFFER:Number = 100;
//==============================================================================
// dis	
//==============================================================================	
		/**
		 * 显示最远的敌人的信息 
		 */		
		public static const SHOW_ENEMY_INFO_DIS:Number = 600;
//==============================================================================
// move	
//==============================================================================
		public static const GAME_SCENCE_CLOSESHOT_MOVE_RATIO:Number = 5;
		public static const GAME_SCENCE_MAP_MOVE_RATIO:Number = 1.0001;
//==============================================================================
// URL	
//==============================================================================
		/**
		 * 关卡配置路径 
		 */		
		public static const GAME_LEVEL_CONFIG_URL:String = "config/game_level_config.xml";
		
		/**
		 * 关卡场景交互 
		 */		
		public static const GAME_SCENCE_INTERAC_CONFIG_URL:String = "config/scene_interaction_config.xml";
		
		/**
		 * 角色属性配置管理器 
		 */		
		public static const ROLE_CONFIG_URL:String = "config/roles_config.xml";
		
		/**
		 * 角色属攻击招式 配置信息
		 */		
		public static const ROLE_ATTACK_MOVE_CONFIG_URL:String = "config/moves_config.xml";
		
		/**
		 * 声音文件配置 
		 */		
		public static const SOUND_FILE_URL:String = "config/sound_config.xml";
		
		/**
		 * 动画--音效配置 
		 */		
		public static const ANIMA_SOUND_CONFIG_URL:String = "config/anima_sound_config.xml";
		
		/**
		 * 最终bossai矩阵配置 
		 */		
		public static const FIANL_BOSS_AI:String = "config/final_boss_move_ai.xml";
		
		
		/**
		 * 关卡场景地图 
		 */		 
		public static const GAME_LEV_MAP_URL:String = "map/";
		
		/**
		 * 关卡资源前缀 
		 */		
		public static const GAME_LEV_TEXTURE_RES_URL:String = "texture/";
//==============================================================================
// support
//==============================================================================		
		public static var collideLayer:Sprite = null;
		public static var phyLayer:Sprite = null;

//==============================================================================
// stage info		
//==============================================================================	
		public static var STAGE_WIDTH:Number = 1136;
		public static var STAGE_HEIGHT:Number = 640;
		public static var SCENCE_BOTTOM:Number = 560;
		
		public static var CONTROL_MASK_POS_Y:Number = 630;
		public static var CONTROL_MASK_HEIGHT:Number = STAGE_HEIGHT - CONTROL_MASK_POS_Y;
		
		public static var appStage:Stage = null;
//==============================================================================
// pos info		
//==============================================================================
		/**
		 * 背景山脉位置 
		 */		
		public static var MOUNTAIN_VIEW_POX_Y:Number = 300;
		
		/**
		 * 欢迎场景移动速度
		 */
		public static const WELCOME_SCENCE_MOVE_SPEED:Number = -5;
		/**
		 * 远景山的移动系数
		 */		
		public static const VISTA_MOVE_OFFSET_VALUE:Number = 0.4;
		
		/**
		 * 中景山移动系数 
		 */		
		public static const MEDIUM_MOVE_OFFSET_VALUE:Number = 0.7;
		
		/**
		 * 中景 移动系数 
		 */		
		public static const MEDIUM_SCENCE_MOVE_OFFSET_VALUE:Number = 0.7;
		
		/**
		 * 近景 移动系数 
		 */		
		public static const CLOSE_SHOT_SCENCE_MOVE_OFFSET_VALUE:Number = 1;
		
//==============================================================================
// keys
//==============================================================================
		public static const WEL_COME_SCENCE_BG_SOUND:String = "WEL_COME_SCENCE_BG_SOUND";
		public static const START_CG_BG_SOUND:String = "START_CG_BG_SOUND";
		public static const BOSS_DIA_CG_BG_SOUND:String = "BOSS_DIA_CG_BG_SOUND";
		public static const BOSS_DIA_CG_BG_EXP_SOUND:String = "BOSS_DIA_CG_BG_EXP_SOUND";
	}
}
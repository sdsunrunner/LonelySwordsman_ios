package enum
{
	/**
	 * 消息类型美剧  
	 * @author admin
	 * 
	 */	
	public class MsgTypeEnum
	{
		/**
		 * 逐帧消息 
		 */		
		public static const ENTER_FRAME:String = "ENTER_FRAME";
		
		/**
		 * 英雄坐标改变 
		 */		
		public static const HERO_POS_UPDATE:String = "HERO_POS_UPDATE";
		
		/**
		 * 英雄被追击
		 */		
		public static const HERO_TRAIL_UPDATE:String = "HERO_TRAIL_UPDATE";
		
		/**
		 * 敌人攻击检测 
		 */		
		public static const HERO_ENEMY_ATTACK_HIT:String = "HERO_ENEMY_ATTACK_HIT";
		
		/**
		 * 刷新英雄hp显示
		 */		
		public static const HERO_HP_UPDATE:String = "HERO_HP_UPDATE";
		
		public static const HERO_HP_ADD_UPDATE:String = "HERO_HP_ADD_UPDATE";
		public static const HERO_LIFE_COUNT_UPDATE:String = "HERO_LIFE_COUNT_UPDATE";
		
		/**
		 * mp数据更新 
		 */		
		public static const HERO_MP_UPDATE:String = "HERO_MP_UPDATE";
		
		/**
		 * 英雄攻击
		 */		
		public static const HERO_ATTACK:String = "HERO_ATTACK";
		
		/**
		 * 英雄移动 
		 */		
		public static const HERO_MOVE:String = "HERO_MOVE";
		
		
		/**
		 * 梯子平台移动
		 */		
		public static const LADDER_PLAT_MOVE:String = "LADDER_PLAT_MOVE";
		
		/**
		 * 英雄碰到梯子 
		 */		
		public static const HERO_TOUCH_LADDER:String = "HERO_TOUCH_LADDER";
		
		/**
		 * 最终boss攻击 
		 */		
		public static const BOSS_ATTACK:String = "BOSS_ATTACK";
		
		/**
		 * 躲避英雄攻击 
		 */		
		public static const AVOID_HERO_ATTACK:String = "AVOID_HERO_ATTACK";
		
		/**
		 * 英雄攻击范围 
		 */		
		public static const HERO_ATTACKRANGE_UPDATE:String = "HERO_ATTACKRANGE_UPDATE";
		
		/**
		 * 英雄是否在做爬梯子的动作 
		 */		
		public static const HERO_IS_CLIMB:String = "HERO_IS_CLIMB";
		
		/**
		 * 震动 
		 */		
		public static const SHAK_WORLD:String = "SHAK_WORLD";
		
		/**
		 * 英雄攻击范围传感器 
		 */		
		public static const HERO_ATTACK_RANGE_SCENSOR:String = "HERO_ATTACK_RANGE_SCENSOR";
		
		/**
		 * 环境伤害 
		 */		
		public static const ENVI_HIT:String = "ENVI_HIT";
		
		public static const ENEMY_INFO_UPDATE:String = "ENEMY_INFO_UPDATE";
		
		/**
		 * 落石探测器激活 
		 */		
		public static const FALLROCK_SECSOR_ACTIVE:String = "FALLROCK_SECSOR_ACTIVE";
		
		public static const TRAP_SECSOR_ACTIVE:String = "TRAP_SECSOR_ACTIVE";
		
		/**
		 * 删除rock 
		 */		
		public static const REMOVE_FALL_ROCK:String = "REMOVE_FALL_ROCK";
		
		public static const ROCK_FALL_END:String = "ROCK_FALL_END";
		
		public static const REMOVE_EUR_MODEL_ENEMY:String = "REMOVE_EUR_MODEL_ENEMY";
		
		public static const SURVER_MODE_SCORE_UPDATE:String = "SURVER_MODE_SCORE_UPDATE";
		
		public static const BOSS_HP_RECOVER:String = "BOSS_HP_RECOVER";
		
		public static const BOSS_MP_RECOVER:String = "BOSS_MP_RECOVER";
		
		public static const ENEMY_RECOVER:String = "ENEMY_RECOVER";
		
		public static const NOTE_LADDER_POSX:String = "NOTE_LADDER_POSX";
	}
		
}
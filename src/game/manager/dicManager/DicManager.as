package  game.manager.dicManager
{
	import utils.configs.DicAnimaSoundConfigUtil;
	import utils.configs.DicFinalBossAiConfigUtil;
	import utils.configs.DicGameLevelConfigUtil;
	import utils.configs.DicGameRoleConfigUtil;
	import utils.configs.DicGameScenceInterConfigUtil;
	import utils.configs.DicRoleAttackConfigUtil;
	import utils.configs.DicSoundConfigUtil;
	
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.configInfo.ObjAnimaSoundConfig;
	import vo.configInfo.ObjGameLevelConfigInfo;
	import vo.configInfo.ObjScenceInteracConfigInfo;
	import vo.configInfo.ObjSoundFileConfig;
	import vo.configInfo.ObjfinalBossAiConfig;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;

	/**
	 * 字典表管理器 
	 * @author songdu.greg
	 * 
	 */	
	public class DicManager
	{
		private static var _instance:DicManager = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function DicManager(code:$)
		{
			
		}
		public static function get instance():DicManager
		{
			return _instance ||= new DicManager(new $);
		}
		
		/**
		 * 由关卡id获取场景配置信息  
		 * @param scenceId
		 * @return 
		 * 
		 */		
		public function getGameLevConfigInfoById(scenceId:String):ObjGameLevelConfigInfo
		{
			return DicGameLevelConfigUtil.getGameLevConfigById(scenceId);
		}
		
		/**
		 * 由场景id获取场景配置信息 
		 * @param scenceId
		 * @return 
		 * 
		 */		
		public function getScenceInteracConfigInfoById(scenceId:String):ObjScenceInteracConfigInfo
		{
			return DicGameScenceInterConfigUtil.getGameLevConfigById(scenceId);
		}
		
		/**
		 * 由id获取英雄配置信息 
		 * @param configId
		 * @return 
		 * 
		 */		
		public function getRoleConfigInfoById(configId:Number):ObjRoleConfigInfo
		{
			return DicGameRoleConfigUtil.getRoleConfigById(configId);
		}
		
		/**
		 * 获取受伤移动距离  
		 * @param configId
		 * @param frame
		 * @return 
		 * 
		 */		
		public function getRoleHurtMoveById(configId:Number, frame:Number):Number
		{
			return DicGameRoleConfigUtil.getRoleHurtPos(configId,frame);
		}
		
		/**
		 * 由id获取攻击招式配置信息 
		 * @param moveId
		 * @return 
		 * 
		 */		
		public function getAttackMoveConfigInfoById(moveId:Number):ObjAttackMoveConfig
		{
			return DicRoleAttackConfigUtil.getAttackMoveConfigById(moveId);
		}
		
		/**
		 * 由动画名获取动画音效配置信息
		 * @param animaName
		 * @return 
		 * 
		 */		
		public function getAnimaSoundConfigByAnimaName(animaName:String,frame:Number):ObjAnimaSoundConfig
		{
			return DicAnimaSoundConfigUtil.getConfigByAnimaName(animaName,frame);
		}
		
		/**
		 * 获取欢迎场景的音效配置 
		 * @return 
		 * 
		 */
		public function getWelcomeBgSoundConfig():ObjSoundFileConfig
		{
			return DicSoundConfigUtil.getWelcomeBgSoundConfig();
		}
		
		public function getStratCgSoundConfig():ObjSoundFileConfig
		{
			return DicSoundConfigUtil.geStartSoundConfig();
		}
		
		
		public function getBossDiaCgSoundConfig():ObjSoundFileConfig
		{
			return DicSoundConfigUtil.geBossDiaSoundConfig();
		}
		
		public function getBossDiaCgExpSoundConfig():ObjSoundFileConfig
		{
			return DicSoundConfigUtil.geBossDiaExpSoundConfig();
		}
		
		/**
		 * 获取场景音效文件配置  
		 * @param soundId
		 * @return 
		 * 
		 */		
		public function getScenceSoundInfoById(soundId:Number):ObjSoundFileConfig
		{
			return DicSoundConfigUtil.getScenceBgSoundConfigInfoById(soundId);
		}
		
		/**
		 * 获取最终bossai配置 
		 * @param bossMp
		 * @param bossHp
		 * @param heroHp
		 * @return 
		 * 
		 */		
		public function getfinalBossAiConfigInfo(bossMp:String, bossHp:String, heroHp:String):ObjfinalBossAiConfig
		{
			return DicFinalBossAiConfigUtil.getConfigByAnimaName(bossMp,bossHp,heroHp);
		}
		
		/**
		 * 获取预加载音效 配置  
		 * @return 
		 * 
		 */		
		public function getPreLoadSoundConfigInfo():Vector.<ObjSoundFileConfig>
		{
			return DicSoundConfigUtil.getPreLoadFile();
		}
		
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	}
}
class ${}
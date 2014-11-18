package game.manager.gameLevelManager
{
	import game.manager.dicManager.DicManager;
	
	import vo.configInfo.ObjGameLevelConfigInfo;
	import vo.configInfo.ObjScenceInteracConfigInfo;
	

	/**
	 * 关卡管理器 
	 * @author songdu.greg
	 * 
	 */	
	public class GameLevelManager
	{
		
		private var _currentGameModel:String = GameModeEnum.TYPE_STORY_MODEL;
		private static var _instance:GameLevelManager = null;
		private var _isStartNewGame:Boolean = false
		
		/**
		 * 游戏关卡名称 
		 */		
		private static const GAME_LEV:Array = ["101","102","103","104","105","106","107","108","109","110","111","113","114","115","116","117","118"];
		
		/**
		 * 生存模式 
		 */		
		private static const GAME_SURVIVAL_MODEL:String = "1000";
		
		/**
		 * 对决模式vs BOSS 
		 */		
		private static const BATTLE_VS_BOSS:String = "2000";
		
		/**
		 * 对决模式vs 怪物  
		 */		
		private static const BATTLE_VS_MONSTER:String = "2001";
		
		private var _gameLevIndex:Number = -1;
		
		private var _isCgLev:Boolean = false;
		
		/**
		 * 解锁怪物对决 
		 */		
		private static const MONSTER_UN_LOCK_LEV:String = "110";
		
		/**
		 * 解锁boss对决  
		 */		
		private static const BOSS_UN_LOCK_LEV:String = "117";
		
		public function GameLevelManager(code:$)
		{
			
		}
		
		public function get isStartNewGame():Boolean
		{
			return _isStartNewGame;
		}

		/**
		 * 是否怪物解锁关卡 
		 * @return 
		 * 
		 */		
		public function get isMonsterLevUnlock():Boolean
		{
			return GAME_LEV[_gameLevIndex] == MONSTER_UN_LOCK_LEV;
		}
		
		public function get isBossLevUnlock():Boolean
		{
			return GAME_LEV[_gameLevIndex] == BOSS_UN_LOCK_LEV;
		}
		
		public function set isStartNewGame(value:Boolean):void
		{
			_isStartNewGame = value;
		}

		public function get gameLevIndex():Number
		{
			return _gameLevIndex;
		}

		public function set gameLevIndex(value:Number):void
		{
			_gameLevIndex = value;
		}

		public function get isCgLev():Boolean
		{
			return _isCgLev;
		}

		public function set isCgLev(value:Boolean):void
		{
			_isCgLev = value;
		}

		public function get currentGameModel():String
		{
			return _currentGameModel;
		}

		public function set currentGameModel(value:String):void
		{
			_currentGameModel = value;
		}

		public function isStoryMode():Boolean
		{
			return this._currentGameModel == GameModeEnum.TYPE_STORY_MODEL;
		}
		/**
		 * 获取关卡配置信息 
		 * @param gameLev
		 * @return 
		 * 
		 */		
		public function getLevConfigInfo():ObjGameLevelConfigInfo 
		{
			var gameLev:String = getCurrentLevName();
			return DicManager.instance.getGameLevConfigInfoById(gameLev);
		}
		
		public function getScenceInteracConfigInfo():ObjScenceInteracConfigInfo 
		{
			var gameLev:String = getCurrentLevName();
			return DicManager.instance.getScenceInteracConfigInfoById(gameLev);
		}
		
		public static function get instance():GameLevelManager
		{
			return _instance ||= new GameLevelManager(new $);
		}
		
		public function isNewGame():Boolean
		{
			return _gameLevIndex == -1;
		}
		/**
		 * 关卡重置 
		 * 
		 */		
		public function resetGameLev():void
		{
			_gameLevIndex = 0;
		}
		
		/**
		 * 关卡递进 
		 * 
		 */		
		public function gameLevNext():void
		{
			if(_gameLevIndex < GAME_LEV.length-1)
				_gameLevIndex++;
		}
		
		/**
		 * 获取当前关卡名称 
		 * @return 
		 * 
		 */		
		public function getCurrentLevName():String
		{
			if(currentGameModel == GameModeEnum.TYPE_STORY_MODEL)
				return GAME_LEV[_gameLevIndex];
			if(currentGameModel == GameModeEnum.TYPE_SURVIVAL_MODEL)
			{
//				PlayerBehaviorAnalyseManager.instance.umeng.dispatchEvent("playSurverMode")
				return GAME_SURVIVAL_MODEL;
			}
				
			if(currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS)
			{
//				PlayerBehaviorAnalyseManager.instance.umeng.dispatchEventWithParams("playbattleMode","type=vsboss" )
				return BATTLE_VS_BOSS;
			}
			
			if(currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER)
			{
//				PlayerBehaviorAnalyseManager.instance.umeng.dispatchEventWithParams("playbattleMode","type=vsmonster" )
				return BATTLE_VS_MONSTER;
			}
			
			return "";
		}		
	}
}

class ${}
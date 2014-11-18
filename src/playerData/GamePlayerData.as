package playerData
{	
	import enum.GameRoleEnum;
	
	import game.manager.dicManager.DicManager;
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	import game.view.models.HeroStatusModel;
	import game.view.survivalMode.SurvivalModeDataModel;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;

	/**
	 * 玩家数据
	 * @author admin
	 * 
	 */	
	public class GamePlayerData
	{
		private static var _instance:GamePlayerData = null;		
		
		//玩家数据初始xml数据
		private var _gamePlayerLevXml:String = PlayerInitData.PLAYER_LEV_INIT;
		
		//玩家信息
		private var _playerInfo:ObjPlayerInfo = null;
		
		public function GamePlayerData(code:$)
		{
		}
		
		public function get playerInfo():ObjPlayerInfo
		{
			if(null == _playerInfo)
				this.parseGamePlayerInfo();
			return _playerInfo;
		}

		public static function get instance():GamePlayerData
		{
			return _instance ||= new GamePlayerData(new $);
		}
		
		public function get gamePlayerLevXml():String
		{
			return _gamePlayerLevXml;
		}
		
		public function set gamePlayerLevXml(value:String):void
		{	
			_gamePlayerLevXml = value;	
			this.parseGamePlayerInfo();
		}
		
		/**
		 * 游戏重置 
		 * @return 
		 * 
		 */		
		public function getResetLevXml():String
		{
			var isBossUnLock:Number = 1;
			var isMonsterUnLock:Number = 1;
			var resetDataXml:String = 
				'<?xml version="1.0" encoding="UTF-8"?>'+
				'	<data>'+
				'	<hero life_count="'+_playerInfo.storyModeHeroLifeCount+'" hero_hp="300" hero_mp="300" hp_proto="'
				+_playerInfo.storyModeHeroHpProto
				
				+'" mp_proto="'+_playerInfo.storyModeHeroMpProto+'"/>		'+
				
				'	<game_lev game_lev_id="-1"/>'+
				'	<ballte_mode hero_is_un_lock="'+isBossUnLock+'" monster_is_un_lock="'+isMonsterUnLock+'"/>'+
				
				'	<surver_best  surver_best="'+_playerInfo.surverModeBestScore+'"/>	'+
				'	<kill_count  kill_count="'+_playerInfo.killCount+'"/>	'+
				'	</data>';
			
			return resetDataXml;
		}
		
		/**
		 * 保存关卡数据 
		 * @param gameLevId
		 * @param heroHp
		 * @param heroMp
		 * @param hpProto
		 * @param mpProto
		 * 
		 */		
		public function saveGameLevInfo(gameLevId:Number,
										heroHp:Number,
										heroMp:Number,
										hpProto:Number,
										mpProto:Number,
										rebornCount:Number):void
		{
			_playerInfo.storyModeGameLevId = gameLevId;
			_playerInfo.storyModeHeroHp = heroHp;
			_playerInfo.storyModeHeroMp = heroMp;
			_playerInfo.storyModeHeroHpProto = hpProto;
			_playerInfo.storyModeHeroMpProto = mpProto;
			_playerInfo.storyModeHeroLifeCount = rebornCount;
			_playerInfo.battleModeBossIsUnLock = GamePlayerDataProxy.instance.getPlayerInfo().battleModeBossIsUnLock;
			_playerInfo.battleModeMonsterIsUnLock = GamePlayerDataProxy.instance.getPlayerInfo().battleModeMonsterIsUnLock;
			var surverModeBest:Number = SurvivalModeDataModel.instance.score;
			if(surverModeBest > _playerInfo.surverModeBestScore)
				_playerInfo.surverModeBestScore = surverModeBest;
		}
		
		/**
		 * 购买，保存hp道具 
		 * @param buyCount
		 * 
		 */		
		public function saveBuyHpProto(buyCount:Number):void
		{
			_playerInfo.storyModeHeroHpProto += buyCount;			
		}
		
		/**
		 * 购买，保存mp道具 
		 * @param buyCount
		 * 
		 */		
		public function saveBuyMpProto(buyCount:Number):void
		{
			_playerInfo.storyModeHeroMpProto += buyCount;			
		}
		
		/**
		 * 使用hp道具 
		 * 
		 */		
		public function costHpProto():void
		{
			_playerInfo.storyModeHeroHpProto -= 1;
			if(_playerInfo.storyModeHeroHpProto<0)
				_playerInfo.storyModeHeroHpProto = 0;
		}
		
		/**
		 * 使用mp道具 
		 * 
		 */		
		public function costMpProto():void
		{
			_playerInfo.storyModeHeroMpProto -= 1;
			if(_playerInfo.storyModeHeroMpProto<0)
				_playerInfo.storyModeHeroMpProto = 0;
		}
		
		
		/**
		 * 购买，保存解锁boss 
		 * 
		 */		
		public function saveBuyBattleBoss():void
		{
//			_playerInfo.battleModeBossIsUnLock = true;			
		}
		
		
		/**
		 * 获取玩家等级数据xml 
		 * @return 
		 * 
		 */		
		public function getGamePlayerLevXml():XML
		{
			return new XML(_gamePlayerLevXml);
		}
		
		/**
		 * 修改玩家等级数据 
		 * @param levId
		 * @param rankValue
		 * 
		 */		
		public function updatePlayerLevInfo(levId:Number,rankValue:Number):void
		{
			
		}
		
		/**
		 * 保存玩家数据 
		 * 
		 */		
		public function getPlayerLevInfoStr():String
		{
			var isBossUnLock:Number = _playerInfo.battleModeBossIsUnLock?1:0;
			var isMonsterUnLock:Number = _playerInfo.battleModeMonsterIsUnLock?1:0;
			
			var playerLevDataStr:String = '<?xml version="1.0" encoding="UTF-8"?>'+
				'	<data>'+
				'	<hero life_count="'+_playerInfo.storyModeHeroLifeCount+'" hero_hp="'+_playerInfo.storyModeHeroHp 
				+'" hero_mp="'+_playerInfo.storyModeHeroMp
				+'" hp_proto="'+_playerInfo.storyModeHeroHpProto
				+'" mp_proto="'+_playerInfo.storyModeHeroMpProto+'"/>'+
				'	<game_lev game_lev_id="'+_playerInfo.storyModeGameLevId+'"/>'+
				'	<ballte_mode hero_is_un_lock="'+isBossUnLock+'" monster_is_un_lock="'+isMonsterUnLock+'"/>	'+
				'	<surver_best  surver_best="'+_playerInfo.surverModeBestScore+'"/>	'+
				'	<kill_count  kill_count="'+_playerInfo.killCount+'"/>	'+
				'	</data>';
			
			playerLevDataStr += "\n";		
		
			return playerLevDataStr;
		}
		
		/**
		 * 解析玩家数据 
		 * 
		 */		
		private function parseGamePlayerInfo():void
		{		
			var dataXml:XML = this.getGamePlayerLevXml();
			
			_playerInfo = new ObjPlayerInfo();
			
			//英雄
			var nodeHeroInfo:XMLList = dataXml.hero;
			for each(var nodeHero:XML in nodeHeroInfo)
			{
				_playerInfo.storyModeHeroLifeCount = int(nodeHero.@life_count);
				_playerInfo.storyModeHeroHp = int(nodeHero.@hero_hp);
				_playerInfo.storyModeHeroMp = int(nodeHero.@hero_mp);
				_playerInfo.storyModeHeroHpProto = int(nodeHero.@hp_proto);
				_playerInfo.storyModeHeroMpProto = int(nodeHero.@mp_proto);
			}
			
			//关卡
			var nodeLevInfo:XMLList = dataXml.game_lev;
			for each(var levInfo:XML in nodeLevInfo)
			{
				_playerInfo.storyModeGameLevId = int(nodeLevInfo.@game_lev_id);
			}
			//对决模式
			var nodeStoreInfo:XMLList = dataXml.ballte_mode;
			for each(var storeInfo:XML in nodeStoreInfo)
			{
				_playerInfo.battleModeBossIsUnLock = int(storeInfo.@hero_is_un_lock) == 1;
				_playerInfo.battleModeMonsterIsUnLock = int(storeInfo.@monster_is_un_lock) == 1;
			}
			
			//生存模式最好得分
			var topScore:XMLList = dataXml.surver_best;
			for each(var topScoreXml:XML in topScore)
			{
				_playerInfo.surverModeBestScore = int(topScoreXml.@surver_best);
			}
			
			//击杀数
			var killCount:XMLList = dataXml.kill_count;
			for each(var killCountXml:XML in killCount)
			{
				_playerInfo.killCount = int(killCountXml.@kill_count);
			}
			
			var heroStatus:HeroStatusModel = HeroStatusModel.instance;
			var protoData:ProtoDataInfoModel = ProtoDataInfoModel.instance;
					
			protoData.hpProtoCount = _playerInfo.storyModeHeroHpProto;
			protoData.mpProtoCount = _playerInfo.storyModeHeroMpProto;
			
			var heroConfigInfo:ObjRoleConfigInfo = this.getBaseHeroConfigInfo();
			
			heroStatus.setHeroMaxHp(heroConfigInfo.maxHp);
			heroStatus.setHeroMaxMp(heroConfigInfo.maxMp);
			
			heroStatus.heroCurrentHp = _playerInfo.storyModeHeroHp;
			heroStatus.heroCurrentMp= _playerInfo.storyModeHeroMp;
			heroStatus.heroLifeCount= _playerInfo.storyModeHeroLifeCount;
		}
		
		
		private function getBaseHeroConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.BASE_HERO_CONFIG_ID);
		}
	}
}

class ${}
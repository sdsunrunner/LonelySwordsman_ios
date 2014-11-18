package playerData
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import frame.view.IObserver;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	import game.view.models.ControlleBarStatusModel;
	import game.view.models.HeroStatusModel;

	/**
	 * 玩家数据代理 
	 * @author admin
	 * 
	 */	
	public class GamePlayerDataProxy implements IObserver
	{
		private static var _instance:GamePlayerDataProxy = null;
		private var _playerLevData:GamePlayerData = null;
		
		private static const DATA_FILE_NAME:String = "swordsman_data_v1.2.0.xml";
		
		private var _controlleBarStatusModel:ControlleBarStatusModel = null;
		public function GamePlayerDataProxy(code:$)
		{
			_playerLevData = GamePlayerData.instance;
			readPlayerLevInfo();
		}
		
		public function newGameReadData():void
		{
			this.resetPlayerData();
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{

		}
		
		
		/**
		 * 保存关卡数据 
		 * 
		 */		
		public function saveGamelLevInfo():void
		{
			var heroStatus:HeroStatusModel = HeroStatusModel.instance;
			var protoData:ProtoDataInfoModel = ProtoDataInfoModel.instance;
			
			var currnetLev:Number = GameLevelManager.instance.gameLevIndex;
			if(heroStatus.heroCurrentHp<0)
				heroStatus.heroCurrentHp = 0;
			if(heroStatus.heroCurrentMp<0)
				heroStatus.heroCurrentMp = 0;
			var currentHeroHp:Number = Math.ceil(heroStatus.heroCurrentHp);
			var currentHeroMp:Number = Math.ceil(heroStatus.heroCurrentMp);
			var currentHeroHpProto:Number = protoData.hpProtoCount;
			var currentHeroMpProto:Number = protoData.mpProtoCount;
			var currentHeroRebornCount:Number = heroStatus.heroLifeCount;
		
			GamePlayerDataProxy.instance.saveGameLevInfo(currnetLev,
				currentHeroHp,
				currentHeroMp,
				currentHeroHpProto,
				currentHeroMpProto,
				currentHeroRebornCount
				);
		}
		
		public function dispose():void
		{
			
		}
		
		private function saveGameLevInfo(gameLevId:Number,
										 heroHp:Number,
										 heroMp:Number,
										 hpProto:Number,
										 mpProto:Number,
										 rebornCount:Number):void
		{
			_playerLevData.saveGameLevInfo(gameLevId,heroHp,heroMp,hpProto,mpProto,rebornCount);
			this.savePlayerLevInfo();
		}
		
		public static function get instance():GamePlayerDataProxy
		{
			return _instance ||= new GamePlayerDataProxy(new $);
		}		
		
		public function getPlayerInfo():ObjPlayerInfo
		{
			return _playerLevData.playerInfo;
		}		
		
		/**
		 * 重置玩家数据
		 * 
		 */		
		private function resetPlayerData():void
		{			
			_playerLevData.gamePlayerLevXml = _playerLevData.getResetLevXml();			
			this.savePlayerLevInfo();
		}
		
		/**
		 * 保存 玩家等级数据  
		 * 
		 */		
		public function savePlayerLevInfo():void
		{
			var newPlayerLevDataStr:String = 
				_playerLevData.getPlayerLevInfoStr();
			
			var dataXml:XML = new XML(newPlayerLevDataStr);
			var file:File = File.documentsDirectory.resolvePath(DATA_FILE_NAME);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			var outputString:String = dataXml.toXMLString();
			fileStream.writeUTFBytes(outputString);
			fileStream.close(); 
		}
		
		/**
		 * 读取玩家关卡信息 
		 * 
		 */		
		private function readPlayerLevInfo():void
		{
			var gameDataXML:XML;
			var file:File = checkHasDataRecord();
			if(file)
			{
				var fileStream:FileStream = new FileStream() ;
				if(file.exists)
				{
					fileStream.open (file,FileMode.READ) ;
					gameDataXML = XML (fileStream.readUTFBytes (fileStream.bytesAvailable)) ;
					fileStream.close() ; 
					_playerLevData.gamePlayerLevXml = gameDataXML.toString();
				}
				else
				{
					var playerInitLevDataStr:String = 
						_playerLevData.gamePlayerLevXml;
					var initDataXml:XML = new XML(playerInitLevDataStr);
					var initFile:File = File.documentsDirectory.resolvePath(DATA_FILE_NAME);
					var initFileStream:FileStream = new FileStream();
					initFileStream.open(initFile, FileMode.WRITE);
					var initOutputString:String = initDataXml.toXMLString();
					initFileStream.writeUTFBytes(initOutputString);
					initFileStream.close(); 
				}
			}
		}
		
		
		/**
		 * 检查记录文件是否 存在
		 * @return 
		 * 
		 */		
		private function checkHasDataRecord():File
		{
			if( File.documentsDirectory.exists)
				var file:File = File.documentsDirectory.resolvePath (DATA_FILE_NAME) ;
			if(file)
				return file;
			
			return null;
		}
		
		private function initModel():void
		{
			_controlleBarStatusModel = ControlleBarStatusModel.instance;
			_controlleBarStatusModel.register(this);
		}
	}
}
class ${}
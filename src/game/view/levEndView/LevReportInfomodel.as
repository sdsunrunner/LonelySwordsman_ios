package game.view.levEndView
{
	import frame.view.viewModel.MessageCenter;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	/**
	 * 战斗统计视图模型 
	 * @author admin
	 * 
	 */	
	public class LevReportInfomodel extends MessageCenter
	{
		private static var _instance:LevReportInfomodel = null;
		
		private var _killDog:Number = 0;
		private var _killBaseSoldier:Number = 0;
		private var _killTallSoldier:Number = 0;
		private var _killTwoKinfeSoldier:Number = 0;
		private var _playerInfo:ObjPlayerInfo = null;
		public function LevReportInfomodel(code:InnerClass)
		{
			super();
		}
		
		public function get killTwoKinfeSoldier():Number
		{
			return _killTwoKinfeSoldier;
		}

		public function get killTallSoldier():Number
		{
			return _killTallSoldier;
		}

		public function get killBaseSoldier():Number
		{
			return _killBaseSoldier;
		}

		public function get killDog():Number
		{
			return _killDog;
		}
		
		public function killReport(enemyType:String):void
		{
			switch(enemyType)
			{
				case EnemyTypeEnum.TYPE_DOG:
					_killDog++;
					break;
				
				case EnemyTypeEnum.TYPE_BASE_SOLDIER:
					_killBaseSoldier++;
					break;
				
				case EnemyTypeEnum.TYPE_TALL_SOLDIER:
					_killTallSoldier++;
					break;
				
				case EnemyTypeEnum.TYPE_TWO_KNIFE_SOLDIER:
					_killTwoKinfeSoldier++;
					break;
			}
			if(!_playerInfo)
				_playerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			var preCount:Number = _playerInfo.killCount;
			preCount++;
			_playerInfo.killCount = preCount;
		}
		
		public function resetData():void
		{
			_killDog = 0;
			_killBaseSoldier = 0;
			_killTallSoldier = 0;
			_killTwoKinfeSoldier = 0;
		}
		
		public static function get instance():LevReportInfomodel
		{
			return _instance ||= new LevReportInfomodel(new InnerClass);
		}
	}
}

class InnerClass{}
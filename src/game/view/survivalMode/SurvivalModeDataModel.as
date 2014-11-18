package game.view.survivalMode
{
	import flash.utils.Dictionary;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	import game.view.enemySoldiers.BaseEnemy;
	import game.view.enemySoldiers.animals.AnimalSoldierEnemy;
	import game.view.enemySoldiers.basis.BaseSoldierEnemy;

	/**
	 * 生存模式数据模型 
	 * @author admin
	 * 
	 */	
	public class SurvivalModeDataModel extends MessageCenter
	{
		private static var _instance:SurvivalModeDataModel = null;
		private var _enemyDic:Dictionary = null;
		private var _enemyCounter:Number = 0;
		
		private var _score:Number = 0;
		
		public function SurvivalModeDataModel(code:$)
		{
			
		}

		public function get score():Number
		{
			return _score;
		}

		public function resetData():void
		{
			_score = 0;
			_enemyCounter = 0;
			if(_enemyDic)
			{
				for (var key:* in _enemyDic)
				{
					delete _enemyDic[key];
				}
				_enemyDic = null;
			}
		}
		public function get enemyDic():Dictionary
		{
			return _enemyDic;
		}

		public function get enemyCounter():Number
		{
			return _enemyCounter;
		}

		public static function get instance():SurvivalModeDataModel
		{
			return _instance ||= new SurvivalModeDataModel(new $);
		}
		
		/**
		 * 添加敌人 
		 * @param enemyName
		 * @param enemy
		 * 
		 */		
		public function addEnemy(enemyName:String , enemy:BaseEnemy):void
		{
			if(null == _enemyDic)
				_enemyDic = new Dictionary();
		
			_enemyDic[enemyName] = enemy;
			_enemyCounter++;
		}
		
		/**
		 * 删除敌人 
		 * @param enemyName
		 * 
		 */		
		public function removeEnemy(enemyName:String):void
		{
			var killedEnemy:BaseEnemy = _enemyDic[enemyName];
			if(killedEnemy is BaseSoldierEnemy || AnimalSoldierEnemy)
				_score++;
			else
				_score+=2;			
			this.noteScoreUpdate();
			
			
			this.msgName = MsgTypeEnum.REMOVE_EUR_MODEL_ENEMY;		
			this.msg = killedEnemy;
			this.notify();		
			delete _enemyDic[enemyName];
			_enemyCounter--;
		}
		
		private function noteScoreUpdate():void
		{
			this.msgName = MsgTypeEnum.SURVER_MODE_SCORE_UPDATE;		
			this.msg = _score;
			this.notify();		
		}
		/**
		 * 获取现存敌人数量 
		 * @return 
		 * 
		 */		
		public function getEnemyCount():Number
		{
			return _enemyCounter;
		}
	}
}

class ${}
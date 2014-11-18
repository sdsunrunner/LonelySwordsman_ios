package game.view.survivalMode
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import citrus.core.CitrusObject;
	import citrus.physics.nape.Nape;
	
	import enum.MsgTypeEnum;
	
	import frame.commonInterface.IDispose;
	import frame.view.IObserver;
	
	import game.manager.objManager.InstanceManager;
	import game.view.enemySoldiers.BaseEnemy;
	import game.view.enemySoldiers.animals.AnimalSoldierEnemy;
	import game.view.enemySoldiers.basis.BaseSoldierEnemy;
	import game.view.enemySoldiers.tall.TallSoldierEnemy;
	import game.view.models.HeroStatusModel;
	
	/**
	 * 生存模式敌人产生器 
	 * @author admin
	 * 
	 */	
	public class SurvivalModeEnemyCreater extends CitrusObject implements IDispose, IObserver
	{
		public var width:Number = 30;
		public var height:Number = 30;
		public var x:Number = 30;
		public var y:Number = 30;
		public var rotation:Number = 0;
		
		private var _instanceManager:InstanceManager = null;	
		private var _enemyCount:Number = 0;
		private var _dataModel:SurvivalModeDataModel = null;
		private var _heroStatus:HeroStatusModel = null;
		private static const ENEMY_MAX_COUNT_1:Number = 3;		
		private static const ENEMY_MAX_COUNT_2:Number = 4;	
		private static const ENEMY_MAX_COUNT_3:Number = 5;
		private var _timer:Timer = null;
		private var _heroPos:Point = null;
		private static const  ENEMY_BORN_POS_MAX:Number = 2250;
		private static const  ENEMY_BORN_POS_MIN:Number = 550;
		
		private var _timerCounter:Number = 0;
		private var _randomNum:Number = 0; 
		private var _posxArr:Array = null;
		private var _nape:Nape = null;
		
		public function SurvivalModeEnemyCreater(name:String, params:Object=null)
		{
			super(name, params);
			this.initModel();
			this.initTimer();
		}
		
		public function dispose():void
		{		
			_timerCounter = 0;
			if(_dataModel)
				_dataModel.unRegister(this);
			_dataModel = null;
		
			if(_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, checkEnemy);
				_timer = null;
			}
			if(_heroStatus)
				_heroStatus.unRegister(this);
			_heroStatus =  null;
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.REMOVE_EUR_MODEL_ENEMY)
			{
				var delEnemy:BaseEnemy = data as BaseEnemy;		
				delEnemy.dispose();
				delEnemy.destroy();				
			}
			
			if(msgName == MsgTypeEnum.HERO_POS_UPDATE)
			{
				_heroPos =  data as Point;				
			}
		}
		
		private function initModel():void
		{
			_dataModel = SurvivalModeDataModel.instance;			
			_instanceManager = InstanceManager.instance;
			_heroStatus = HeroStatusModel.instance;
			_heroStatus.register(this);
			
		}
		
		private function initTimer():void
		{
			this._timer = new Timer(2000);
			this._timer.addEventListener(TimerEvent.TIMER, checkEnemy);
			this._timer.start();
		}
		
		public function checkEnemy(evt:TimerEvent):void
		{
			this.checkEnemyPos();
			_timerCounter++;
			var count:Number = _dataModel.getEnemyCount();			
			if(_timerCounter < 10)
			{
				if(count<ENEMY_MAX_COUNT_1)
				{
					createBaseEnemy();
//					createAnimEnemy();
				}
			}
			else if(_timerCounter < 20)
			{
				if(count<ENEMY_MAX_COUNT_2)
				{
					_randomNum = Math.random();
					if(_randomNum>0.7)
						createBaseEnemy();
					else if(_randomNum>0.5)
						createTallEnemy();
					else
						createAnimEnemy();
				}
			}
				
			else if(_timerCounter < 40)
			{
				if(count<ENEMY_MAX_COUNT_2)
				{
					_randomNum = Math.random();
					if(_randomNum>0.8)
						createBaseEnemy();
					else if(_randomNum>0.5)
						createTallEnemy();
					else
						createAnimEnemy();
				}
			}
			else
			{
				if(count<ENEMY_MAX_COUNT_3)
				{
					_randomNum = Math.random();
					if(_randomNum>0.8)
						createBaseEnemy();
					else if(_randomNum>0.5)
						createTallEnemy();
					else
						createAnimEnemy();
				}
			}
		}
		
		/**
		 * 检查已经存在的敌人x 
		 * 
		 */		
		private function checkEnemyPos():void
		{
			_posxArr = [];
			var enemyDic:Dictionary = _dataModel.enemyDic;
			
			for (var key:* in enemyDic)
			{
				var enemy:BaseEnemy = enemyDic[key];
				_posxArr.push(enemy.x);
			}
		}
		
		/**
		 * 偏移横坐标 
		 * @param enemyPosX
		 * 
		 */		
		private function offsetPosx(enemyPosX:Number):Number
		{
			var value:Number = 0;
			
			
			for(var i:Number = 0; i < _posxArr.length; i++)
			{
				var posX:Number = _posxArr[i];
				if(Math.abs(enemyPosX - posX) < 300)
				{
					if(enemyPosX < posX)
						return enemyPosX-300;
					else
						return enemyPosX+300;
				}
			}
			
			return enemyPosX;
		}
		
		
		/**
		 * 创建基础士兵 
		 * 
		 */		
		private function createBaseEnemy():void
		{
			
			var enemyParam:Object = new Object();
			enemyParam.height = 74;
			enemyParam.width = 19;
			enemyParam.leftBound = ENEMY_BORN_POS_MIN;
			enemyParam.rightBound = ENEMY_BORN_POS_MAX;
			enemyParam.rotation = 0;			
			var value:Number = Math.random()>0.5?1:-1;
			enemyParam.x = _heroPos.x + value*100;
			enemyParam.x = this.offsetPosx(enemyParam.x);
			
			if(enemyParam.x <= ENEMY_BORN_POS_MIN)
				enemyParam.x = ENEMY_BORN_POS_MIN;
			
			if(enemyParam.x >= ENEMY_BORN_POS_MAX)
				enemyParam.x = ENEMY_BORN_POS_MAX;
			
			enemyParam.y = 0;
			var enemyName:String = "baseEnemy" + _timerCounter;
//			var enemy:BaseEnemy = _instanceManager.getBaseSoldierEnemy();
			var enemy:BaseEnemy = new BaseSoldierEnemy(enemyName,enemyParam);
			
			
			_nape = _ce.state.getFirstObjectByType(Nape) as Nape;
			if(_nape)
			{
				_dataModel.addEnemy(enemyName,enemy);
				_ce.state.add(enemy);
			}
		}
		
		/**
		 * 创建高大士兵 
		 * 
		 */		
		private function createTallEnemy():void
		{
			var enemyParam:Object = new Object();
			enemyParam.height = 75;
			enemyParam.width = 68;
			enemyParam.leftBound = ENEMY_BORN_POS_MIN;
			enemyParam.rightBound = ENEMY_BORN_POS_MAX;
			enemyParam.rotation = 0;
			
			var value:Number = Math.random()>0.5?1:-1;
			enemyParam.x = _heroPos.x + value*80;
			enemyParam.x = this.offsetPosx(enemyParam.x);
			if(enemyParam.x <= ENEMY_BORN_POS_MIN)
				enemyParam.x = ENEMY_BORN_POS_MIN;
			
			if(enemyParam.x >= ENEMY_BORN_POS_MAX)
				enemyParam.x = ENEMY_BORN_POS_MAX;
			
			enemyParam.y = 0;
			var enemyName:String = "tallEnemy" + _timerCounter;
			
			var enemy:BaseEnemy = new TallSoldierEnemy(enemyName,enemyParam);
			
			_nape = _ce.state.getFirstObjectByType(Nape) as Nape;
			if(_nape)
			{
				_dataModel.addEnemy(enemyName,enemy);
				_ce.state.add(enemy);
			}
				
		}
		
		/**
		 * 创建动物士兵 
		 * 
		 */		
		private function createAnimEnemy():void
		{
			var enemyParam:Object = new Object();
			enemyParam.height = 25;
			enemyParam.width = 68;
			enemyParam.leftBound = ENEMY_BORN_POS_MIN;
			enemyParam.rightBound = ENEMY_BORN_POS_MAX;
			enemyParam.rotation = 0;
			
			var value:Number = Math.random()>0.5?1:-1;
			enemyParam.x = _heroPos.x + value*100;
			enemyParam.x = this.offsetPosx(enemyParam.x);
			if(enemyParam.x <= ENEMY_BORN_POS_MIN)
				enemyParam.x = ENEMY_BORN_POS_MIN;
			
			if(enemyParam.x >= ENEMY_BORN_POS_MAX)
				enemyParam.x = ENEMY_BORN_POS_MAX;
			
			enemyParam.y = 0;
			var enemyName:String = "AnimEnemy" + _timerCounter;
			var enemy:BaseEnemy = new AnimalSoldierEnemy(enemyName,enemyParam);
		
			enemy.name = enemyName;
			
			
			_nape = _ce.state.getFirstObjectByType(Nape) as Nape;
			if(_nape)
			{
				_dataModel.addEnemy(enemyName,enemy);
				_ce.state.add(enemy);
			}
				
		}
	}
}
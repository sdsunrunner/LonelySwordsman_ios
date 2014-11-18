package game.dataProxy
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	import game.view.boss.finalBoss.logicModel.BossDataModel;
	import game.view.models.HeroStatusModel;
	
	/**
	 * 自动恢复 
	 * @author admin
	 * 
	 */	
	public class AutoRecoverCenter extends MessageCenter
	{
		private static var _instance:AutoRecoverCenter = null;
		
		private var _recoverTimer:Timer = null;
		
		private var _heroStatus:HeroStatusModel = null;
		private var _bossData:BossDataModel = null;
		private var _isPause:Boolean = false;
		public function AutoRecoverCenter(code:$)
		{
			super();
			this.initRecoverTimer();
		}
		
		public static function get instance():AutoRecoverCenter
		{
			return _instance ||= new AutoRecoverCenter(new $);
		}				
		
		public function autoRecoverPause(ispause:Boolean):void
		{
			_isPause = ispause;
		}
		
		private function initRecoverTimer():void
		{
			_recoverTimer = new Timer(100);
			_recoverTimer.addEventListener(TimerEvent.TIMER, recoverHandler);
			_recoverTimer.start();
		}
		
		private function recoverHandler(evt:TimerEvent):void
		{
			if(!_heroStatus)
				_heroStatus = HeroStatusModel.instance;
			if(!_heroStatus.isDead)
			{
				if(_isPause)
				{
					_heroStatus.addHp(0.0);
					_heroStatus.addMp(0.0);
				}
				else
				{
					_heroStatus.addHp(0.1);
					_heroStatus.addMp(0.1);
				}
			}		
			
			if(null == _bossData)
				_bossData = BossDataModel.instance;
			_bossData.addHp(0.1);
			_bossData.addMp(0.1);			
			
			this.msgName = MsgTypeEnum.ENEMY_RECOVER;
			this.notify();
		}
	}
}

class ${}
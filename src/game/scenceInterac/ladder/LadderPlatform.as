package game.scenceInterac.ladder
{
	import citrus.objects.platformer.nape.MovingPlatform;
	
	import enum.MsgTypeEnum;
	
	import frame.view.IObserver;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.scenceInterac.ladder.datamodel.LadderDataModel;
	import game.view.models.HeroStatusModel;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	import vo.configInfo.ObjScenceInteracConfigInfo;
	
	/**
	 * 梯子 平台
	 * @author admin
	 * 
	 */	
	public class LadderPlatform extends MovingPlatform implements IObserver
	{	
		private var _ladderData:LadderDataModel = null;		
		private var _heroStatusModel:HeroStatusModel = null;
		
		private var _platform:Body = new Body(BodyType.KINEMATIC);
		private var _scenceConfig:ObjScenceInteracConfigInfo = null;
		private var _basicPosY:Number = 0;
	
		public function LadderPlatform(name:String, params:Object=null)
		{
			super(name, params);
			super.enabled = false;
			_scenceConfig = GameLevelManager.instance.getScenceInteracConfigInfo();
			
			this.initModel();
			this.speed = Const.LADDER_UP_SPEED;
		}
		
		public function dispose():void
		{		
			_ladderData.unRegister(this);	
			_heroStatusModel.unRegister(this);
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;			
			_start.x = value;
			this.endX = value;
		}
		
		override public function set y(value:Number):void
		{
			_basicPosY = value;
			super.y = value;			
			_start.y = value;
			this.endY = value - _scenceConfig.ladderMoveRange;
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.LADDER_PLAT_MOVE)
			{
				var isActive:Boolean = data as Boolean;
				super.enabled = isActive;	
				_ladderData.noteLadderPosX(this.x)
			}
			
			if(msgName == MsgTypeEnum.HERO_IS_CLIMB)
			{
				var value:Boolean = data as Boolean;
				if(!value)
					this.resetLadderPlatForm();
			}
		}
		
		public function initModel():void
		{
			_ladderData = LadderDataModel.instance;
			_ladderData.register(this);
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
		}
		
		/**
		 * 重置梯子位置 
		 * 
		 */		
		private function resetLadderPlatForm():void
		{
			this.y = _basicPosY;
		}
	}
}
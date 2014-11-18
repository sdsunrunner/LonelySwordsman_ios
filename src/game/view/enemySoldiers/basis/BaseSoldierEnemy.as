package game.view.enemySoldiers.basis
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	
	import frame.view.IObserver;
	
	import game.manager.dicManager.DicManager;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.enemySoldiers.BaseEnemy;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.event.RoleHurtEvent;
	import game.view.levEndView.EnemyTypeEnum;
	import game.view.levEndView.LevReportInfomodel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	import game.view.survivalMode.SurvivalModeDataModel;
	
	import nape.geom.Vec2;
	
	import starling.events.Event;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 基础士兵 
	 * @author admin
	 * 
	 */	
	public class BaseSoldierEnemy extends BaseEnemy implements IObserver
	{
		private var _animaView:BaseSoldierAnimaView = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _thisPos:Point = new Point();
		private var _heroPose:Point = null;
		private var _configInfo:ObjRoleConfigInfo = null;
	
		private var  _heroTrail:Bitmap = null;
		private var _survivalModeDataModel:SurvivalModeDataModel = null;
		
		public function BaseSoldierEnemy(name:String="BaseSoldierEnemy", params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_animaView = new BaseSoldierAnimaView();				
					params.view = _animaView;
				}
			}

			super(name, params);			
			this.addListeners();
			this.initAttributes();
			this.initModel();
		}		
		
		override public function hurt():void
		{
			
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			switch(msgName)
			{
				case MsgTypeEnum.HERO_POS_UPDATE:
					_heroPose = data as Point;
					this.checkHeroDis(_heroPose);
					break;
				
				case MsgTypeEnum.HERO_TRAIL_UPDATE:
					_heroTrail = data as Bitmap;
					this.checkHeroTrail(_heroTrail);
					break;
			}
		}
		
		override public function dispose():void
		{
			super.destroy();
			_ce.state.remove(this);
			if(_animaView)
				_animaView.dispose();
			if(_heroStatusModel)
				_heroStatusModel.unRegister(this);
			_heroStatusModel = null;
			
			if(_survivalModeDataModel)
				_survivalModeDataModel = null;
			
			_thisPos = null;
			_heroPose = null;
			_thisPos = null;			
			_animaView = null;
		}
		
		override public function update(timeDelta:Number):void
		{
			if(!isPause)
			{
				super.update(timeDelta);
				
				if(_animaView)
				{
					_animaView.track(null ,"");
					
					var position:Vec2 = _body.position;
					//Turn around when they pass their left/right bounds
					if ((_inverted && position.x < leftBound) || (!_inverted && position.x > rightBound))
						turnAround();
					
					var velocity:Vec2 = _body.velocity;
					
					if (!_hurt)
						velocity.x = _inverted ? -speed : speed;
					else
						velocity.x = 0;
					
					if(!_animaView.walking)
						this.speed = 0;
					else
						this.speed = _configInfo.maxVelocity;
					
					_animaView.faceForward = _inverted;				
				}
			}			
		}
		
		override protected function updateAnimation():void 
		{
			
		}
		
		public function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_SURVIVAL_MODEL)
				_survivalModeDataModel = SurvivalModeDataModel.instance;			
		}
		
		private function initAttributes():void
		{
			_configInfo = getConfigInfo();
			
			this.speed = _configInfo.maxVelocity;		
			if(_animaView)
				_animaView.setConfigInfo(_configInfo,this.name);
		}
		
		private function addListeners():void
		{
			if(_animaView)
			{
				_animaView.addEventListener(EnemyEvent.REMOVE_ENMY_NOTE,removeEnemyHandler);
				_animaView.addEventListener(RoleHurtEvent.ROLE_HURT, roleHurthandler);
				_animaView.addEventListener(EnemyEvent.ENMY_DEATH_NOTE, roleDeathhandler);
			}
		}
		
		private function roleDeathhandler():void
		{
			// TODO Auto Generated method stub
			
//			this.sendNotification(CommandInteracType.CAMERA_ZOOM_EFFECT,CameraEffectTypeEnum.ENEMY_DEATH_CAMERA_ZOOM);
		}
		
		private function checkHeroDis(heroPose:Point):void
		{
			_thisPos.x = this.x;
			_thisPos.y = this.y;
			if(_animaView)
			{
				_animaView.updateCurrentPos(this.x,_thisPos.y);
				if(_thisPos && heroPose)
				{
					if(Point.distance(_thisPos,heroPose)<50)
						_animaView.doAttack();
					else
						_animaView.doWalk();
				}
			}
		}
		
		private function checkHeroTrail(heroTrail:Bitmap):void
		{
			if(_animaView)
			{
				var activeType:String = _animaView.checkHeroTrail(heroTrail);
				
				switch(activeType)
				{
					case SensorEnum.AUDITION:
						this.turnAround();
						break;
					case SensorEnum.SOLDIER_SIGHT:
						this.leftBound -= 1000;
						this.rightBound += 1000;
						if(_animaView.walking)
							this.speed = _configInfo.maxVelocity*1.2;
						break;
				}
			}
			
		}
		
		private function getConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.BASE_ENEMY_SOLDIER_CONFIG_ID);
		}
		
		private function removeEnemyHandler(evt:Event):void
		{
			if(_survivalModeDataModel)
				_survivalModeDataModel.removeEnemy(this.name);		
			this.dispose();	
			LevReportInfomodel.instance.killReport(EnemyTypeEnum.TYPE_BASE_SOLDIER);
		}
		
		private function roleHurthandler(evt:RoleHurtEvent):void
		{	
			this.x += evt.disX;
			this.y -= evt.disY;
 		}
	}
}
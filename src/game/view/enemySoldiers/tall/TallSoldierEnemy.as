package game.view.enemySoldiers.tall
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
	 * 高大士兵 
	 * @author admin
	 * 
	 */	
	public class TallSoldierEnemy extends BaseEnemy implements IObserver
	{
		private var _animaView:TallSoldierAnimaView = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _thisPos:Point = null;
		private var _configInfo:ObjRoleConfigInfo = null;
		private var _survivalModeDataModel:SurvivalModeDataModel = null;
		public function TallSoldierEnemy(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_animaView = new TallSoldierAnimaView();
					params.view = _animaView;
				}
			}
			
			super(name, params);
			this.initModel();
			this.addListeners();
			this.initAttributes();
		}
		
		override public function hurt():void
		{
			
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			switch(msgName)
			{
				case MsgTypeEnum.HERO_POS_UPDATE:
					var heroPose:Point = data as Point;
					this.checkHeroDis(heroPose);
					break;
				
				case MsgTypeEnum.HERO_TRAIL_UPDATE:
					var heroTrail:Bitmap = data as Bitmap;
					this.checkHeroTrail(heroTrail);
					break;
				
			}
		}
		
		override public function dispose():void
		{
			if(_animaView)
				_animaView.dispose();
			super.destroy();
			_heroStatusModel.unRegister(this);		
			_animaView = null;
			_ce.state.remove(this);
			_survivalModeDataModel = null;			
		}
		
		override public function update(timeDelta:Number):void
		{
			if(!isPause)
			{
				if(_animaView)
				{
					_animaView.track(null ,"");
					super.update(timeDelta);
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
		
			_animaView.setConfigInfo(_configInfo,this.name);
		}
		
		private function addListeners():void
		{
			_animaView.addEventListener(EnemyEvent.REMOVE_ENMY_NOTE,removeEnemyHandler);
			_animaView.addEventListener(RoleHurtEvent.ROLE_HURT, roleHurthandler);
			_animaView.addEventListener(EnemyEvent.ENMY_DEATH_NOTE, roleDeathhandler);			
		}
		
		private function roleDeathhandler():void
		{
			// TODO Auto Generated method stub			
//			this.sendNotification(CommandInteracType.CAMERA_ZOOM_EFFECT,CameraEffectTypeEnum.ENEMY_DEATH_CAMERA_ZOOM);
		}
		
		private function checkHeroDis(heroPose:Point):void
		{
			if(null == _thisPos)
				_thisPos = new Point();
			_thisPos.x = this.x;
			_thisPos.y = this.y;
			_animaView.updateCurrentPos(this.x,_thisPos.y);
			if(Point.distance(_thisPos,heroPose)<70)
			{
				_animaView.doAttack();
			}
			else
				_animaView.doWalk();			
		}
		
		private function checkHeroTrail(heroTrail:Bitmap):void
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
				default:
					this.speed = _configInfo.maxVelocity;
			}
		}
		
		private function getConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.TALL_ENEMY_SOLDIER_CONFIG_ID);
		}
		
		private function removeEnemyHandler(evt:Event):void
		{
			if(_survivalModeDataModel)
				_survivalModeDataModel.removeEnemy(this.name);		
			this.dispose();
			
			LevReportInfomodel.instance.killReport(EnemyTypeEnum.TYPE_TALL_SOLDIER);
		}
		
		private function roleHurthandler(evt:RoleHurtEvent):void
		{	
			this.x += evt.disX;
			this.y -= evt.disY;
		}
	}
}
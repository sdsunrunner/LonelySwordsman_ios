package game.view.boss.monster
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	import frame.view.IObserver;
	
	import game.interactionType.CommandViewType;
	import game.manager.dicManager.DicManager;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.boss.BaseEnemyHero;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	
	import nape.geom.Vec2;
	
	import starling.events.Event;
	
	import utils.MaterialUtils;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 怪物 
	 * @author admin
	 * 
	 */	
	public class Monster extends BaseEnemyHero implements IObserver
	{
		private var _animaView:MonsterAnimaView = null;
		private var _scensorResult:String = "";
		private var _heroStatusModel:HeroStatusModel = null;
		private var _count:Number = 0;
		private var _thisPos:Point = null;
		private var _configInfo:ObjRoleConfigInfo = null;
		
		public function Monster(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_animaView = new MonsterAnimaView();
					params.view = _animaView;
				}
			}
			canDuck = false;
			hurtVelocityX = 0;
			hurtVelocityY = 0;	
			super(name, params);
			this.initAttributes();
			this.initModel();
			this.addListeners();
			this.touchable = false;
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			switch(msgName)
			{
				case MsgTypeEnum.HERO_TRAIL_UPDATE:
					var heroTrail:Bitmap = data as Bitmap;
					this.checkHeroTrail(heroTrail);
					break;
				
				case MsgTypeEnum.HERO_POS_UPDATE:
					var heroPose:Point = data as Point;
					this.checkHeroDis(heroPose);
					break;
			}
		}
		
		public function dispose():void
		{
			if(_heroStatusModel)
			{
				_heroStatusModel.unRegister(this);
				_heroStatusModel = null;
			}
			
			if(_animaView)
			{
				_animaView.dispose();
				_animaView = null;
			}
			
			_ce.state.remove(this);
		}
		
		override protected function createMaterial():void 
		{			
			_material = MaterialUtils.createEnemyMaterial();
		}
			
		override public function update(timeDelta:Number):void
		{
			if(_animaView && !_animaView.isDead)
			{
				_animaView.track(null,"");
				// we get a reference to the actual velocity vector			
				var velocity:Vec2 = _body.velocity;
				
				var faceForward:Boolean = _animaView.faceForward;
				var value:Number = faceForward?1:-1;
				
				if (_scensorResult == SensorEnum.IN_MONSER_SIGHT && _animaView.isMoving)
				{
					_count -= 5;
				}		
				else
				{
					_count = 0;
				}
				
				velocity.x = _count;
				//Cap velocities
				if (velocity.x > (maxVelocity))
					velocity.x = maxVelocity;
				else if (velocity.x < (-maxVelocity))
					velocity.x = -maxVelocity;
				_body.velocity = velocity;
				updateAnimation();
			}
		}
		
		override protected function updateAnimation():void
		{
			
		}
		
		private function checkHeroDis(heroPose:Point):void
		{
			if(null == _thisPos)
				_thisPos = new Point();
			_thisPos.x = this.x;
			_thisPos.y = this.y;
			_animaView.updateCurrentPos(this.x,_thisPos.y);			
		}
		
		private function initAttributes():void
		{
			this._configInfo = this.getConfigInfo();
			_animaView.setConfigInfo(_configInfo,this.name);
			this._onGround = true;
			this.maxVelocity = _configInfo.maxVelocity;		
		}
		
		private function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
		}
		
		private function addListeners():void
		{
			_animaView.addEventListener(EnemyEvent.REMOVE_ENMY_NOTE,removeEnemyHandler);
			_animaView.addEventListener(EnemyEvent.ENMY_DEATH_NOTE, roleDeathhandler);			
		}
		
		private function roleDeathhandler():void
		{
			// TODO Auto Generated method stub			
//			this.sendNotification(CommandInteracType.CAMERA_ZOOM_EFFECT,CameraEffectTypeEnum.ENEMY_DEATH_CAMERA_ZOOM);
		}
		
		private function checkHeroTrail(heroTrail:Bitmap):void
		{
			var activeType:String = _animaView.checkHeroTrail(heroTrail);
			_scensorResult = activeType;
			switch(activeType)
			{
				case SensorEnum.IN_MONSER_SIGHT:
					_animaView.monsterMove();
					break;
				
				case SensorEnum.IN_MONSTER_ATTACK_RANGE:	
					_animaView.monsterAttack();
					break;
			}
		}
		
		private function getConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.MONSTER_CONFIG_ID);
		}
		
		private function removeEnemyHandler(evt:Event):void
		{
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER)
				this.notify(CommandViewType.GAMEEND_MENU,true);
			this.dispose();
			super.destroy();
		}
		
		private function notify(type:String, data:* = null):void
		{
			var notification:INotification = new BaseNotification();
			notification.data = data;
			var note:AppNotification = new AppNotification(type, notification);
			
			note.dispatch();
		}
	}
}
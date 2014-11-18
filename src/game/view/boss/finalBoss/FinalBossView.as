package game.view.boss.finalBoss
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	import frame.view.IObserver;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.dicManager.DicManager;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.boss.BaseEnemyHero;
	import game.view.boss.finalBoss.bossEvent.BossEvent;
	import game.view.boss.finalBoss.logicModel.BossDataModel;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	
	import nape.geom.Vec2;
	
	import starling.events.Event;
	
	import utils.MaterialUtils;
	import utils.console.infoCh;
	
	import vo.ObjBossrunAway;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 最终boss 
	 * @author admin
	 * 
	 */	
	public class FinalBossView extends BaseEnemyHero implements  IObserver
	{
		private var _animaView:FianlbossAnimaView = null;
		private var _herostatus:HeroStatusModel = null;
		private var _scensorResult:String = "";
		private var _bossdataModel:BossDataModel = null;
		
		private static const  BOSS_POS_MIN_X:Number = 200;
		private static const  BOSS_POS_MAX_X:Number = 1400;
		
		private static const  BOSS_POS_UPDAT_MIN_X:Number = 150;
		private static const  BOSS_POS_UPDAT_MOVE_MIN_X:Number = 200;
		private static const  BOSS_POS_UPDAT_PLUS_X:Number = 100;
		private var _thisPos:Point = null;
		public function FinalBossView(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_animaView = new FianlbossAnimaView();
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
		override protected function createMaterial():void 
		{
			_material = MaterialUtils.createFianlBossMaterial();
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
		
		private function checkHeroDis(heroPose:Point):void
		{
			if(null == _thisPos)
				_thisPos = new Point();
			_thisPos.x = this.x;
			_thisPos.y = this.y;
			if(_animaView)
			{
				_animaView.updateCurrentPos(this.x,_thisPos.y);	
				if(heroPose.x>_thisPos.x)
					_animaView.faceForward = true;
				else
					_animaView.faceForward = false;
			}
		}
		
		public function dispose():void
		{
			super.destroy();
			if(_animaView)
				_animaView.dispose();
			_animaView = null;
		}		
		
		override public function update(timeDelta:Number):void
		{
			var velocity:Vec2 = _body.velocity;
			if(_animaView&&!_animaView.isGameEnd)
			{
				_animaView.track(null,"");
				// we get a reference to the actual velocity vector			
				
				var faceForward:Boolean = _animaView.faceForward;
				var value:Number = faceForward?1:-1;
				
				if (_scensorResult == SensorEnum.BOSS_WALKER_RANGE && _animaView.isMoving)
				{
					velocity.x += value*13;
				}
				
				if (_scensorResult == SensorEnum.BOSS_RUN_RANGE && _animaView.isMoving)
				{
					velocity.x += value*19;
				}
				
				//Cap velocities
				if (velocity.x > (maxVelocity))
					velocity.x = maxVelocity;
				else if (velocity.x < (-maxVelocity))
					velocity.x = -maxVelocity;
				
				updateAnimation();
			}
			else
			{
				velocity.x = 0;
			}
			
		}
		
		override protected function updateAnimation():void
		{
			
		}
		
		private function initAttributes():void
		{
			var configInfo:ObjRoleConfigInfo = this.getConfigInfo();
//			this.maxVelocity = configInfo.maxVelocity;
			_animaView.setConfigInfo(configInfo, this.name);
			this._onGround = true;
		}
		
		private function initModel():void
		{
			_herostatus= HeroStatusModel.instance;
			_herostatus.register(this);
			_bossdataModel = BossDataModel.instance;			
		}		
			
		private function getConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.FIANL_BOSS_CONFIG_ID);
		}
		
		private function checkAttackResult(attackRange:Bitmap, attackInfo:ObjAttackMoveConfig):void
		{
			_bossdataModel.bossAttack(attackRange,attackInfo,_animaView.faceForward);
		}
		private function addListeners():void
		{
			_animaView.addEventListener(BossEvent.BOSS_FLASH_RUN_AWAY, bossFlashRunAwayhandler);	
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
			if(_animaView&&!_animaView.isGameEnd)
			{
				var activeType:String = _animaView.checkHeroTrail(heroTrail);
				
				_scensorResult = activeType;
				switch(activeType)
				{
					case  SensorEnum.AUDITION:
						this.turnAround();
						break;
					
					case  SensorEnum.BOSS_WALKER_RANGE:
						_animaView.startWalk();
						break;
					
					case  SensorEnum.BOSS_RUN_RANGE:
						_animaView.startRun();
						break;
					case SensorEnum.BOSS_NORMAL_ATTACK_RANGE:					
						_animaView.startAttack();
						break;
					
					default:
						_animaView.idelStatus();
				}
			}
		}
		
		private function bossFlashRunAwayhandler(evt:Event):void
		{
			var bossrunAwayInfo:ObjBossrunAway = evt.data as ObjBossrunAway;
			var heroPos:Point = bossrunAwayInfo.heroPos;
			
			var randomNum:Number = Math.random();
			
			var flashPoint:Number = NaN;
			if(bossrunAwayInfo.runAwayMoveType == "finalBossport")
				flashPoint = (BOSS_POS_UPDAT_MIN_X + BOSS_POS_UPDAT_PLUS_X*randomNum);
			else if(bossrunAwayInfo.runAwayMoveType == "finalBossFlashStep")
				flashPoint = (BOSS_POS_UPDAT_MIN_X +BOSS_POS_UPDAT_MOVE_MIN_X+ BOSS_POS_UPDAT_PLUS_X*randomNum);
				
			var halfPoxX:Number = (BOSS_POS_MIN_X+BOSS_POS_MAX_X)>>1;
			if(heroPos.x > halfPoxX)
			{
				if(randomNum > 0.1)
					this.x = heroPos.x - flashPoint;
				else
					this.x = heroPos.x + flashPoint;
			}
			else
			{
				if(randomNum > 0.1)
					this.x = heroPos.x +  flashPoint
				else
					this.x = heroPos.x - flashPoint;
			}
			
			if(this.x > BOSS_POS_MAX_X)
				this.x = BOSS_POS_MAX_X - 80;
			if(this.x < BOSS_POS_MIN_X)
				this.x = BOSS_POS_MIN_X + 80;
		}
		
		private function turnAround():void
		{
			this._animaView.turnAround();
		}
		
		private function removeEnemyHandler(evt:Event):void
		{
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS)
			{	
				if(evt.data<1)
					this.notify(CommandViewType.GAMEEND_MENU,true);
			}				
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_STORY_MODEL)
			{
				infoCh("note switch lev","FinalBossView");
				this.notify(CommandInteracType.GAME_LEV_END_SENSOR_ACTIVE);
				this.notify(CommandViewType.GAME_LEVEL_VIEW);
			}
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
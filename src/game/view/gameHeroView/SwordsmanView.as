package game.view.gameHeroView
{
	import com.greensock.TweenMax;
	
	import citrus.objects.platformer.nape.Hero;
	
	import enum.CameraEffectTypeEnum;
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
	import game.scenceInterac.ladder.datamodel.LadderDataModel;
	import game.view.event.MainScenceEvent;
	import game.view.event.RoleHurtEvent;
	import game.view.models.HeroStatusModel;
	
	import nape.geom.Vec2;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	import starling.events.Event;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 剑客视图 
	 * @author songdu
	 * 
	 */	
	public class SwordsmanView extends Hero implements   IObserver
	{
		private var _heroAnimaView:HeroAnimaView = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _ladderDataModel:LadderDataModel = null;
	
		private var _isTouchLadder:Boolean = false;
		private var _isAttackRangeActive:Boolean = false;
		private var _ladderPox:Number = 0;
		public function SwordsmanView(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_heroAnimaView = new HeroAnimaView();
					params.view = _heroAnimaView;
				}
			}
			canDuck = false;
			hurtVelocityX = 0;
			hurtVelocityY = 0;	
			super(name, params);
			this.initModel();
			this.initAttributes();	
			this.addListeners();
			acceleration = 30;
			this.touchable = false;
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_TOUCH_LADDER)
				_isTouchLadder = data as Boolean;	
			
			if(msgName == MsgTypeEnum.HERO_ATTACK_RANGE_SCENSOR)
				_isAttackRangeActive = data as Boolean;	
			
			if(msgName == MsgTypeEnum.NOTE_LADDER_POSX)
				_ladderPox = data as Number;
		}
		
		public function dispose():void
		{			
			if(_ladderDataModel)
				_ladderDataModel.unRegister(this);
			_ladderDataModel = null;
			_heroStatusModel = null;  
			this.kill = true;
			this.destroy();
			if(_heroAnimaView)
				_heroAnimaView.dispose();
			_heroAnimaView = null;
			
			_ce.state.remove(this);
		}
		
		override public function update(timeDelta:Number):void
		{
			if(!_heroStatusModel.isDead&&!this.kill)				
			{
				if(_heroAnimaView)
				{
					_heroAnimaView.track(null,"");
					if(_heroAnimaView)
						_heroAnimaView.setHeroPos(this.x);
				
					if(_heroStatusModel)
						_heroStatusModel.noteHeroPosUpdate(this.x, this.y);
					// we get a reference to the actual velocity vector
					var velocity:Vec2 = _body.velocity;

					
					if (controlsEnabled &&_heroAnimaView)
					{
						var moveKeyPressed:Boolean = false;
						
						
							if (_ce.input.isDoing("right", inputChannel) &&!_heroAnimaView.isDoingAction)
							{
								if(!_isAttackRangeActive)
								{
									velocity.x += acceleration;
									moveKeyPressed = true;
								}
							}
							
							if (_ce.input.isDoing("left", inputChannel)&&!_heroAnimaView.isDoingAction)
							{
								if(!_isAttackRangeActive)
								{
									velocity.x -= acceleration;
									moveKeyPressed = true;
								}
							}
						}
						
						
						if (_ce.input.isDoing("up", inputChannel) &&_heroAnimaView)
						{
							if(_isTouchLadder)
							{		
								if(_ladderPox>0)
									this.x = _ladderPox+8;
								_heroAnimaView.climbStairs();
							}
							else
							{
								_heroAnimaView.updateladderPlatPos(false);
							}
						}
						
						//If player just started moving the hero this tick.
						if (moveKeyPressed && !_playerMovingHero)
						{
							_playerMovingHero = true;
							_material.dynamicFriction = 0; //Take away friction so he can accelerate.
							_material.staticFriction = 0;
						}
							//Player just stopped moving the hero this tick.
						else if (!moveKeyPressed && _playerMovingHero)
						{
							_playerMovingHero = false;
							_material.dynamicFriction = _dynamicFriction; //Add friction so that he stops running
							_material.staticFriction = _staticFriction;
						}
						
						//Cap velocities
						if (velocity.x > (maxVelocity))
							velocity.x = maxVelocity;
						else if (velocity.x < (-maxVelocity))
							velocity.x = -maxVelocity;
						
						if(_heroAnimaView)
							_heroAnimaView.faceForward = !_inverted;
						
						if(_ce.input.hasDone("right", inputChannel) || _ce.input.hasDone("left", inputChannel) &&!_heroAnimaView.isDoingAction)
						{
							if(_heroAnimaView)
								_heroAnimaView.runEnd();
						}
						
						if(_heroAnimaView)
							updateAnimation();
					}
				
				
			}
			else
			{
				_heroAnimaView.doHeroDead();
			}
			
			
		}
		
		override protected function updateAnimation():void
		{
			if(_heroAnimaView.isDoingAction)
				this.maxVelocity = 0;
			else
				this.maxVelocity = 150;
			
			var prevAnimation:String = _animation;
			
			//var walkingSpeed:Number = getWalkingSpeed();
			var walkingSpeed:Number = _body.velocity.x; // this won't work long term!

//			trace("walkingSpeed:" + walkingSpeed);
			
			if(!_heroAnimaView.isDoingAction)
			{
				if (walkingSpeed < -acceleration) 
				{
					_inverted = true;
					_heroAnimaView.runStart();
				} 
				else if (walkingSpeed > acceleration) 
				{
					_inverted = false;
					_heroAnimaView.runStart();
				}
			}			
			
			if (prevAnimation != _animation)
				onAnimationChange.dispatch();
		}		
		
		private function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_ladderDataModel = LadderDataModel.instance;
			_ladderDataModel.register(this);
		}
		private function addListeners():void
		{
			this._heroAnimaView.addEventListener(RoleHurtEvent.ROLE_HURT, heroHurthandler);
			this._heroAnimaView.addEventListener(RoleHurtEvent.ROLE_DEATH, roleDeathhandler);
			this._heroAnimaView.addEventListener(MainScenceEvent.SHOW_GAME_END_VIEW, showGameEndMenuHandler);
		}
		
		private function roleDeathhandler():void
		{
			// TODO Auto Generated method stub			
			this.sendNotification(CommandInteracType.CAMERA_ZOOM_EFFECT,CameraEffectTypeEnum.HERO_DEATH_CAMERA_ZOOM);
		}
		/**
		 * 发送通知 
		 * @param commandType
		 * @param data
		 * 
		 */		
		public function sendNotification(commandType:String, data:Object = null):void
		{
			var notification:INotification = new BaseNotification();
			notification.data = data;
			
			var note:AppNotification = new AppNotification(commandType, notification);
			note.dispatch();
		}
		private function initAttributes():void
		{
			var heroConfigInfo:ObjRoleConfigInfo = this.getBaseHeroConfigInfo();
			this.maxVelocity = heroConfigInfo.maxVelocity;
			_heroStatusModel.setHeroMaxHp(heroConfigInfo.maxHp);
			_heroStatusModel.setHeroMaxMp(heroConfigInfo.maxMp);
			this._onGround = true;
			
			this.initHeroCurrentstatus();
		}
		
		private function getBaseHeroConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.BASE_HERO_CONFIG_ID);
		}
		
		private function heroHurthandler(evt:RoleHurtEvent):void
		{
//			this.x += evt.dis;
			TweenMax.to(this,.2,{x:x+=evt.disX, onComplete:resetTween});
		}
		private function resetTween():void
		{
			TweenMax.killAll();
		}		
		
		private function showGameEndMenuHandler(evt:Event):void
		{
			battleModeEndHandler();
		}
		
		private function battleModeEndHandler():void
		{
			// TODO Auto Generated method stub
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS
			||GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER)
			{
				this.notify(CommandViewType.GAMEEND_MENU,false);
			}	
			else
				this.notify(CommandViewType.GAMEEND_MENU,false);			
		}
		
		private function notify(type:String, data:* = null):void
		{
			var notification:INotification = new BaseNotification();
			notification.data = data;
			var note:AppNotification = new AppNotification(type, notification);
			
			note.dispatch();
		}
		
		private function initHeroCurrentstatus():void
		{
			if(GameLevelManager.instance.isStoryMode())
			{
				var playerInfo:ObjPlayerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
				_heroStatusModel.heroCurrentHp = playerInfo.storyModeHeroHp;
				_heroStatusModel.heroCurrentMp = playerInfo.storyModeHeroMp;
				_heroStatusModel.heroLifeCount = playerInfo.storyModeHeroLifeCount;
			}
		}
	}
}
package game.view.gameHeroView
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.dataProxy.HeroInfoProxy;
	import game.manager.dicManager.DicManager;
	import game.scenceInterac.ladder.datamodel.LadderDataModel;
	import game.view.event.MainScenceEvent;
	import game.view.event.RoleHurtEvent;
	import game.view.models.ControlleBarStatusModel;
	import game.view.models.EnviItemsInfoModel;
	import game.view.models.HeroMoveStepModel;
	import game.view.models.HeroStatusModel;
	
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;
	
	import utils.HitTest;
	
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjEnviHitInfo;
	import vo.attackInfo.ObjHitInfo;
	
	/**
	 * 英雄动画视图 
	 * @author songdu
	 * 
	 */	
	public class HeroAnimaView extends BaseViewer
	{
		private var _manAnima:AnimationSequence = null;
	
		private var _movesDatamodel:ControlleBarStatusModel = null;
		private var _heroStatusModel:HeroStatusModel = null;

		private var _moveDataModel:HeroMoveStepModel = null;
		private var _enviDataModel:EnviItemsInfoModel = null;
		
		private var _isDoingAction:Boolean = false;
		private var _isMoving:Boolean = false;
		private var _isPlayRunEnd:Boolean = false;
		private var _isBloking:Boolean = false;
		
		private var _bodyBounds:Shape = null;
		
		private var _hurtBitmap:Bitmap = null;		
		private var _landAttackRangeBitmap:Bitmap = null;
		private var _upAttackRangeBitmap:Bitmap = null;
		private var _chopAttackRangeBitmap:Bitmap = null;
		private var _turnRoundAttackRangeRangeBitmap:Bitmap = null;
		private var _heavyAttackRangeBitmap:Bitmap = null;
//		private var _heroAttackRange:Bitmap = null;
		private var _parryRange:Bitmap = null;
		
		private var _heroHp:Number = NaN;
		private var _enemyHitInfo:ObjHitInfo = null;
		private var _enviHitInfo:ObjEnviHitInfo = null;
		private var _faceForward:Boolean = true;
		
		private var _gloabPoint:Point = new Point();
		private var _localPoint:Point = new Point();
		
		private var _preCounter:Number = 0;
		private var _currentAnimaName:String = "";
		
		private var _mcDic:Dictionary = null;		
		private var _currentMc:MovieClip = null;		
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private  var _beenHitMove:Number = 0;
		private var _heroPosx:Number = 0;
		private var _animaTexture:TextureAtlas = null;
		
		private var _isDeath:Boolean = false;
		
		private var _isDoingAttack:Boolean = false;
		
		private var _isDispoed:Boolean = false;
		private var _isBeenHit:Boolean = false;
		private static const HURT_FRAMES:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13];
		
		private var _blockIngCount:Number = 0;
		
		public function HeroAnimaView()
		{
			super();
			this.initAnimaView();
			this.initModel();
			this.addListeners();	
		}
		
		public function get isPlayhurt():Boolean
		{
			return _currentAnimaName == "HeroHurt" ;
		}

		public function get faceForward():Boolean
		{
			return _faceForward;
		}

		public function readyToAction():void
		{
			this.doIdel();
		}
		override public function dispose():void
		{
			if(!_isDispoed)
			{
				_isDispoed = true;
				_localPoint = null;
				_gloabPoint = null;
				if(_currentMc)
					_currentMc.dispose();
				_currentMc = null;
				for (var key:* in this._mcDic)
				{
					var mc:MovieClip = _mcDic[key];				
					mc.dispose();
					delete _mcDic[key];
					mc = null;
				}
				_mcDic = null;
				if(_manAnima)
				{
					_manAnima.onAnimationComplete.removeAll();
					while(_manAnima.numChildren>0)
					{
						_manAnima.removeChildAt(0,true);
					}
					_manAnima = null;
				}
				
				_animaTexture= null;
				
				if(_manAnima)
					_manAnima.dispose();
				_manAnima = null;
				_movesDatamodel.unRegister(this);
				_heroStatusModel.unRegister(this);
				
				if(_enviDataModel)
				{
					_enviDataModel.unRegister(this);
					_enviDataModel = null;
				}
				
				if(_landAttackRangeBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_landAttackRangeBitmap);
				if(_upAttackRangeBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_upAttackRangeBitmap);
				if(_chopAttackRangeBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_chopAttackRangeBitmap);
				if(_turnRoundAttackRangeRangeBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_turnRoundAttackRangeRangeBitmap);
				if(_heavyAttackRangeBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_heavyAttackRangeBitmap);
//				if(_heroAttackRange.parent == Const.collideLayer)
//					Const.collideLayer.removeChild(_heroAttackRange);
				if(_parryRange.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_parryRange);
				if(_hurtBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_hurtBitmap);
				
				_landAttackRangeBitmap.bitmapData.dispose();
				_upAttackRangeBitmap.bitmapData.dispose();
				_chopAttackRangeBitmap.bitmapData.dispose();
				
				_turnRoundAttackRangeRangeBitmap.bitmapData.dispose();
				_heavyAttackRangeBitmap.bitmapData.dispose();
//				_heroAttackRange.bitmapData.dispose();
				_hurtBitmap.bitmapData.dispose();
				_parryRange.bitmapData.dispose();
			}
		}
		
		public function get isPlayRunEnd():Boolean
		{
			return _isPlayRunEnd;
		}

		public function set faceForward(value:Boolean):void
		{
			_faceForward = value;		
		}

		public function setHeroPos(heroPos:Number):void
		{
			_heroPosx = heroPos;
		}
		
		public function updateladderPlatPos(isActive:Boolean):void
		{
			LadderDataModel.instance.updateLadderPlatStatus(isActive);
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			if(_isBloking)
				_blockIngCount++;
			else
				_blockIngCount = 0;
				
			this._heroStatusModel.noteHeroIsclimb(this._currentAnimaName == "Climb");
			
			_currentMc = _mcDic[_currentAnimaName] as MovieClip;			
			
			if(_currentMc)
			{
				soundExpressions.playActionSound(_currentAnimaName,_currentMc.currentFrame);
				
				if(_currentAnimaName == "RunAnima")
					_moveDataModel.heroRun(_heroPosx,_faceForward);
				else
					_moveDataModel.heroMove(_currentAnimaName,_currentMc.currentFrame,_heroPosx,_faceForward);
				
				if(_currentAnimaName == "HeroHurt" || _currentAnimaName == "HeroHeavyhurt")
				{
					if(HURT_FRAMES.indexOf(_currentMc.currentFrame)> -1 && _enemyHitInfo && !this._isBeenHit)
					{
						this._isBeenHit = true;
						var evet:RoleHurtEvent = new RoleHurtEvent(RoleHurtEvent.ROLE_HURT);
						var moveConfigPos:Number = DicManager.instance.getRoleHurtMoveById(GameRoleEnum.BASE_HERO_CONFIG_ID, _currentMc.currentFrame);
						evet.disX = moveConfigPos;
						evet.disX += this._beenHitMove;
						var moveDis:Number = moveConfigPos + this._beenHitMove;
						if(_enemyHitInfo&&!_enemyHitInfo.faceForward)
							evet.disX = -1*evet.disX;
						if(evet.disX != 0)
							this.dispatchEvent(evet);
						this._heroStatusModel.noteShakWorld(this.faceForward,_enemyHitInfo.attackMoveId,true);
					}
					else
						this._isBeenHit = false;
				}
				
				if(_currentAnimaName == "HeavyAttack")
				{
					_currentMc = _mcDic[_currentAnimaName] as MovieClip;			
					
					if(_currentMc.currentFrame == 0)
						this._heroStatusModel.noteShakWorld(this.faceForward,RoleActionEnum.HERO_HEAVY_ATTACK,false);
				}
			}
			_localPoint.x = _bodyBounds.x;
			_localPoint.y = _bodyBounds.y;
			_gloabPoint = localToGlobal(_localPoint);
			
			if(_faceForward)
			{
				_hurtBitmap.x = _gloabPoint.x+70;
				_landAttackRangeBitmap.x = _gloabPoint.x+50;
				_landAttackRangeBitmap.scaleX = 2.3;
				_upAttackRangeBitmap.scaleX = 1.6;
				_upAttackRangeBitmap.x =  _gloabPoint.x+10;
				_chopAttackRangeBitmap.scaleX = 2.5;
				_chopAttackRangeBitmap.x = _gloabPoint.x+70;
				
				_turnRoundAttackRangeRangeBitmap.scaleX = 1.6;
				_turnRoundAttackRangeRangeBitmap.x = _gloabPoint.x+80;
				
				_heavyAttackRangeBitmap.x = _gloabPoint.x+55;
				_heavyAttackRangeBitmap.scaleX = 1.2;
				
//				_heroAttackRange.x = _gloabPoint.x+70;
//				_heroAttackRange.scaleX = 1;
				_hurtBitmap.scaleX = 1;
				
				_parryRange.scaleX = 1.5;
				_parryRange.x = _gloabPoint.x+70;
			}
				
			else
			{
				_landAttackRangeBitmap.x = _gloabPoint.x-60;
				_landAttackRangeBitmap.scaleX = -2.3;
				_upAttackRangeBitmap.scaleX = -1.6;
				_upAttackRangeBitmap.x =  _gloabPoint.x-10;
				_hurtBitmap.x = _gloabPoint.x-60;
				
				_chopAttackRangeBitmap.scaleX = -2.5;
				_chopAttackRangeBitmap.x = _gloabPoint.x-90;
				_turnRoundAttackRangeRangeBitmap.scaleX = -1.6;
				_turnRoundAttackRangeRangeBitmap.x = _gloabPoint.x-90;
				
				_heavyAttackRangeBitmap.x = _gloabPoint.x-60;
				_heavyAttackRangeBitmap.scaleX = -1.2;
				
//				_heroAttackRange.x = _gloabPoint.x-50;
//				_heroAttackRange.scaleX = -1;
				_hurtBitmap.scaleX = -1;
				
				_parryRange.scaleX = -1.5;
				_parryRange.x = _gloabPoint.x-50;
			}
				
			
			_hurtBitmap.y = _gloabPoint.y+30;
			_landAttackRangeBitmap.y = _gloabPoint.y+25;
			
			_upAttackRangeBitmap.y = _gloabPoint.y-70;
			_chopAttackRangeBitmap.y = _gloabPoint.y+20;
			_turnRoundAttackRangeRangeBitmap.y = _gloabPoint.y + 30;
			
			_heavyAttackRangeBitmap.y = _gloabPoint.y-30;
//			_heroAttackRange.y = _gloabPoint.y+10;
			_parryRange.y = _gloabPoint.y+20;
			
			_heroStatusModel.noteHeroTrail(_hurtBitmap);
			
			if(_currentAnimaName == "AttackLandscape")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_LAND_ATTACK);
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{				
					this.checkAttackResult(_landAttackRangeBitmap,_attackInfo);
					_landAttackRangeBitmap.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					_isDoingAttack = false; 
					_landAttackRangeBitmap.visible = false;
				}
				
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_LAND_ATTACK);
			}
			
			if(_currentAnimaName == "UpAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_UP_ATTACK);
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_upAttackRangeBitmap,_attackInfo);
					_upAttackRangeBitmap.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					_isDoingAttack = false;
					_upAttackRangeBitmap.visible = false;
				}	
				
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_UP_ATTACK);
			}
			
			if(_currentAnimaName == "ChopAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_CHOP_ATTACK);
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_chopAttackRangeBitmap,_attackInfo);
					_chopAttackRangeBitmap.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					_isDoingAttack = false;
					_chopAttackRangeBitmap.visible = false;
				}
				
				
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_CHOP_ATTACK);
			}
			
			
			if(_currentAnimaName == "TurnRoundAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_TURNROUND_ATTACK);
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_turnRoundAttackRangeRangeBitmap,_attackInfo);
					_turnRoundAttackRangeRangeBitmap.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					_isDoingAttack = false;
					_turnRoundAttackRangeRangeBitmap.visible = false;
				}					
				
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_TURNROUND_ATTACK);
			}
			
			if(_currentAnimaName == "HeavyAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_HEAVY_ATTACK);
				if( _attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_heavyAttackRangeBitmap,_attackInfo);
					_heavyAttackRangeBitmap.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					_isDoingAttack = false;
					_heavyAttackRangeBitmap.visible = false;
				}
				
				
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_HEAVY_ATTACK);
			}
			
			if(_currentAnimaName == "parry")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_PARRY_ATTACK);
				if( _attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_parryRange,_attackInfo);
					_parryRange.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					_isDoingAttack = false;
					_parryRange.visible = false;
				}
				
				
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_PARRY_ATTACK);
			}
			
			
			if(_currentAnimaName == "StartHeavyMove")
			{
				_isDoingAttack = false;
				_attackInfo = getAttackInfoById(RoleActionEnum.HERO_START_HEAVY_ATTACK);
				if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.avoidlab)
					noteHeroAtack(RoleActionEnum.HERO_START_HEAVY_ATTACK);
			}
			if(_currentAnimaName == "DeadAnima")
			{
				_isDoingAttack = false;
				_heroStatusModel.heroCurrentHp = 0;
			}
//			this._heroStatusModel.noteHeroAttackRange(this._heroAttackRange);
		}
		
		
		public function get bodyBounds():Shape
		{
			return _bodyBounds;
		}

		public function get isDoingAction():Boolean
		{
			return _isDoingAction;
		}

		public function runStart():void
		{
			if(!_isMoving)
			{
				doRunStart();
			}
		}
		
		public function runEnd():void
		{
			if(this._isMoving && !this._isDoingAction)
			{	
				this.doRunEnd();
			}
		}
		
		override public function initModel():void
		{
			_movesDatamodel = ControlleBarStatusModel.instance;
			_movesDatamodel.register(this);
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_moveDataModel = HeroMoveStepModel.instance;
			
			_enviDataModel = EnviItemsInfoModel.instance;
			_enviDataModel.register(this);
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK_REALEASE)
				this.doHeavyAttack();
			
			if(msgName == RoleActionEnum.PARRY_AND_ATTACK_RELEASE)
			{
				if(_blockIngCount < 20)
					doBlockParry();
				else
					this.doBlockBack();
				_isBloking = false; 
			}
			
			 if(msgName ==  MsgTypeEnum.HERO_ENEMY_ATTACK_HIT)
			 {
				 _enemyHitInfo = data as ObjHitInfo;
				 if(_enemyHitInfo.attackHurtValue == 0)
					 _enemyHitInfo = null;
				 if(_enemyHitInfo)
					 this.checkEnemyAttact(_enemyHitInfo);
			 }
			
			 if(msgName == MsgTypeEnum.ENVI_HIT)
			 {
				 _enviHitInfo = data as ObjEnviHitInfo;
				 if(_enviHitInfo&&_enviHitInfo.enViHitValue>0 && _enviHitInfo.enViHitItemname != "TerrainPillar")
					 this.checkEnviAttact(_enviHitInfo);
			 }
			
			switch(msgName)
			{
				case RoleActionEnum.CONTROLLE_BAR_MAIN_ATTACK:
					if(!this._isDoingAction)
						this.doAttackLandscape();
					break;
				
				case RoleActionEnum.CONTROLLE_BAR_UP_ATTACK:
					if(!this._isDoingAction)
						this.doUpAttack();
					break;
				
				case RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK:	
					if(!this._isDoingAction)
						this.doStartHeavyMove();
					break;

				case RoleActionEnum.PARRY_AND_ATTACK:	
					if(!this._isDoingAction)
						this.doBlock();
					break;
				
				case MsgTypeEnum.HERO_HP_UPDATE:
					_heroHp =  data as Number;
					if(_enemyHitInfo&&_enemyHitInfo.attackHurtValue>30)
						this.doHeavyHurt();
					else
						this.doHurt();
					break;
				
				case MsgTypeEnum.HERO_HP_ADD_UPDATE:
					if(_heroHp>0)
						_heroHp =  data as Number;					
					break;
				
				case RoleActionEnum.RECOVER_HP:
				case RoleActionEnum.RECOVER_MP:
					HeroInfoProxy.instance.infoUpdate(null,msgName);
					break;
			}
		}
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
		}
		
		private function initAnimaView():void
		{
			_bodyBounds = new Shape();
			this.addChild(_bodyBounds);
			
			var animaName:Array = ["AttackLandscape","HeroBlock","BlockBack","parry","ChopAttack","Climb","DeadAnima","HeavyAttack","HeroHurt","HeroHeavyhurt","Idel","RunAnima","RunEnd","RunStart","heavyAttackReady","TurnRoundAttack","UpAttack","skirtFlying","skirtStartFly","hairFlying"];
			_animaTexture = assetManager.getTextureAtlas("heroAnima");
			_manAnima = new AnimationSequence(_animaTexture,animaName,"Idel",Const.GAME_ANIMA_FRAMERATE,false);
			_manAnima.touchable = false;
			_mcDic = _manAnima.mcSequences;
			_bodyBounds.addChild(_manAnima);
			_manAnima.pivotX = _manAnima.width>>1 + 5;
//			_manAnima.pivotY = _manAnima.height
			this.doIdel();
			
			_hurtBitmap = new Bitmap();
			_hurtBitmap.bitmapData = assetManager.getBitmapForHitByName("heroHurt");
			Const.collideLayer.addChild(_hurtBitmap);
			
			_landAttackRangeBitmap = new Bitmap();
			_landAttackRangeBitmap.bitmapData = assetManager.getBitmapForHitByName("heroLandAttackRange");
			Const.collideLayer.addChild(_landAttackRangeBitmap);
			_landAttackRangeBitmap.visible = false;
			_landAttackRangeBitmap.scaleY = 1.5;
			
			_upAttackRangeBitmap = new Bitmap();
			_upAttackRangeBitmap.bitmapData = assetManager.getBitmapForHitByName("heroUpAttackRang");
			Const.collideLayer.addChild(_upAttackRangeBitmap);
			_upAttackRangeBitmap.visible = false;
			
			_chopAttackRangeBitmap = new Bitmap();
			_chopAttackRangeBitmap.bitmapData = assetManager.getBitmapForHitByName("ChopAttackRange");
			Const.collideLayer.addChild(_chopAttackRangeBitmap);
			_chopAttackRangeBitmap.visible = false;
			_chopAttackRangeBitmap.scaleY = 1.5;
			
			_turnRoundAttackRangeRangeBitmap = new Bitmap();
			_turnRoundAttackRangeRangeBitmap.bitmapData = assetManager.getBitmapForHitByName("TurnRoundAttackRange");
			Const.collideLayer.addChild(_turnRoundAttackRangeRangeBitmap);
			_turnRoundAttackRangeRangeBitmap.visible = false;
			_turnRoundAttackRangeRangeBitmap.scaleY = 2;
			
			_heavyAttackRangeBitmap = new Bitmap();
			_heavyAttackRangeBitmap.bitmapData = assetManager.getBitmapForHitByName("heavyAttack");
			Const.collideLayer.addChild(_heavyAttackRangeBitmap);
			_heavyAttackRangeBitmap.visible = false;
			_heavyAttackRangeBitmap.scaleY = 1.5;
			
//			_heroAttackRange = new Bitmap();
//			_heroAttackRange.bitmapData = assetManager.getBitmapForHitByName("heroAttackRange");
//			Const.collideLayer.addChild(_heroAttackRange);
			
			_parryRange = new Bitmap();
			_parryRange.bitmapData = assetManager.getBitmapForHitByName("parryRange");
			Const.collideLayer.addChild(_parryRange); 
			_parryRange.visible = false;
			_parryRange.scaleY = 1.5;
		}
		
		
		public function climbStairs():void
		{
			if(!_isDoingAction&&!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_currentAnimaName = "Climb";
				_manAnima.changeAnimation(_currentAnimaName, false);
				_manAnima.y = -20;
				_manAnima.x = 20;
				this.updateladderPlatPos(true);
			}
		}
		
		private function doStartHeavyMove():void
		{
			if(_heroStatusModel.checkHeroCanUseMagicAttack(RoleActionEnum.HERO_HEAVY_ATTACK)&&!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.y = -71 + 12;
				_manAnima.x = -25;
				_currentAnimaName = "heavyAttackReady";
				_manAnima.changeAnimation(_currentAnimaName, false);
			}
		}
		
		private function doTurnRoundAttack():void
		{
			if(!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.y = -4 + 12;
				_manAnima.x = -5;
				_currentAnimaName = "TurnRoundAttack";
				_manAnima.changeAnimation(_currentAnimaName, false);
			}			
		}		
		
		private function doChopAttack():void
		{
			if(!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.y = -28 + 12;
				_manAnima.x = -13;
				_currentAnimaName = "ChopAttack";
				_manAnima.changeAnimation(_currentAnimaName, false);
			}
		}
		
		private function doSkirtFlyStart():void
		{
			if(!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.x = 20;
				_currentAnimaName = "skirtStartFly";
				_manAnima.changeAnimation(_currentAnimaName, false);
			}
		}
		
		private function doSkirtFlyIng():void
		{
			if(!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.x = 15;
				_currentAnimaName = "skirtFlying";
				_manAnima.changeAnimation(_currentAnimaName, true);
			}
		}
		
		private function doAttackLandscape():void
		{
			if(!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.y = 11;
				_manAnima.x = 0;
				_currentAnimaName = "AttackLandscape";
				_manAnima.changeAnimation(_currentAnimaName, false);
			}			
		}			
		
		private function doBlock():void
		{
			if(_currentAnimaName != "HeroBlock" && !this._isDeath)
			{
				_manAnima.y = -6 + 12;
				_manAnima.x = 0;
				_currentAnimaName = "HeroBlock";
				this._isMoving = false;
				this._isDoingAction = true;
				_manAnima.changeAnimation(_currentAnimaName, false);
				_isBloking = true;
			}
				
		}
		
		private function doBlockBack():void
		{
			if(_currentAnimaName != "BlockBack" && !this._isDeath)
			{
				_currentAnimaName = "BlockBack";
				this._isMoving = false;
				this._isDoingAction = true;
				_manAnima.y = -6 + 12;
				_manAnima.x = 0;
				_manAnima.changeAnimation(_currentAnimaName, false);
			}			
		}
		
		private function doBlockParry():void
		{
			if(_currentAnimaName != "parry" && !this._isDeath)
			{
				_currentAnimaName = "parry";
				_manAnima.y = -21 + 12;
				_manAnima.x = -2;
				this._isMoving = false;
				_manAnima.changeAnimation(_currentAnimaName, false);
			}			
		}
		
		private function doClimb():void
		{
			if(_currentAnimaName != "Climb" && !this._isDeath)
			{
				_currentAnimaName = "Climb";
				_manAnima.changeAnimation("Climb", false);
				this._isMoving = false;
			}
		}
		
		private function doHeavyAttack():void
		{
			if(_currentAnimaName != "HeavyAttack" && !this._isDeath)
			{
				if(_heroStatusModel.checkHeroCanUseMagicAttack(RoleActionEnum.HERO_HEAVY_ATTACK))
				{
					this._isDoingAction = true;
					this._isMoving = false;
					_manAnima.y = -50+12;
					_manAnima.x = -5;
					_currentAnimaName = "HeavyAttack";
					_manAnima.changeAnimation("HeavyAttack", false);
					
					var moveInfo:ObjAttackMoveConfig = this.getAttackInfoById(RoleActionEnum.HERO_HEAVY_ATTACK);
					_heroStatusModel.heroMpUpdate(moveInfo.costMp);
				}
			}
			
		}
		private function doHurt():void
		{
			if(_currentAnimaName != "HeroHurt" && !_heroStatusModel.isDead && !this._isDeath)
			{
				_manAnima.y = -13 + 8;
				_manAnima.x = -20;
				_manAnima.changeAnimation("HeroHurt", false);
				_isDoingAction = true;
				this._isMoving = false;
				_currentAnimaName = "HeroHurt";
			}
			else if(_currentAnimaName != "HeroHurt" &&_currentAnimaName != "DeadAnima"&& _heroStatusModel.isDead)
			{
				doHeroDead();
			}
		}		
		
		private function doHeavyHurt():void
		{
			if(_currentAnimaName != "HeroHeavyhurt" && !_heroStatusModel.isDead && !this._isDeath)
			{
				_manAnima.y = -13 + 8;
				_manAnima.x = -20;
				_manAnima.changeAnimation("HeroHeavyhurt", false);
				_isDoingAction = true;
				this._isMoving = false;
				_currentAnimaName = "HeroHeavyhurt";
			}
			else if(_currentAnimaName != "HeroHeavyhurt" &&_currentAnimaName != "DeadAnima"&& _heroStatusModel.isDead)
			{
				doHeroDead();
			}
		}
		
		
		private function doIdel():void
		{
			if(_currentAnimaName != "Idel"&& !this._isDeath)
			{
				_manAnima.y = 10;
				_manAnima.x = 0;
				_manAnima.changeAnimation("Idel", true);
				_currentAnimaName = "Idel";
				this._isMoving = false;
			}
		}
		
		public function doHeroDead():void
		{
			if(_currentAnimaName != "DeadAnima" && !this._isDeath)
			{
				this._isDeath = true;
				_manAnima.y = -20+11;
				_manAnima.x = 0;
				_manAnima.changeAnimation("DeadAnima", false);
				_currentAnimaName = "DeadAnima";
				_isDoingAction = true;
				this.dispatchEventWith(RoleHurtEvent.ROLE_DEATH);
				
				soundExpressions.playActionSound("DeadAnima",1);
			}
		}	
		
		private function doRunAnima():void
		{
			if(!this._isDeath)
			{
				_manAnima.y = 11;
				_manAnima.x = 0;
				_manAnima.changeAnimation("RunAnima", true);
				_currentAnimaName = "RunAnima";
				_isMoving = true;
				_isPlayRunEnd = false;
				_isDoingAction = false;
			}
		}
		
		private function doRunEnd():void
		{
			if(_currentAnimaName != "RunEnd" && !this._isDeath)
			{
				_manAnima.y = 11;
				_manAnima.x = 0;
				_manAnima.changeAnimation("RunEnd", false);
				_currentAnimaName = "RunEnd";
				_isDoingAction = false;
				_isPlayRunEnd = true;
			}
		}		
		
		private function doRunStart():void
		{
			if(!this._isDeath)
			{
				_manAnima.y = 11;
				_manAnima.x = 0;
				_manAnima.changeAnimation("RunStart", false);
				_currentAnimaName = "RunStart";
				_isMoving = true;
				_isPlayRunEnd = false;
				_isDoingAction = false;
			}
		}		
		private function doUpAttack():void
		{
			if(!this._isDeath)
			{
				this._isDoingAction = true;
				this._isMoving = false;
				_manAnima.x = -5;
				_manAnima.y = -55 + 11;
				_manAnima.changeAnimation("UpAttack", false);
				_currentAnimaName = "UpAttack";
			}
		}
		
		private function animaComplete(name:String):void
		{
			if(name == "RunStart" )
				this.doRunAnima();
			if(name == "RunEnd")
				_isMoving = false;
			
			if(name != "RunStart" && name != "RunEnd")
				_isDoingAction = false;
			
			if(name == "DeadAnima")
			{
				setTimeout(heroDeadHandler,600);
			}
			
			if(name == "Idel")
			{
				if(_heroStatusModel.isDead)
					this.doHeroDead();
			}
			if(name == "AttackLandscape" && !ControlleBarStatusModel.instance.checkMainAttackRelease())
			{
				this.doChopAttack();
			}
			
			if(name == "ChopAttack" && !ControlleBarStatusModel.instance.checkMainAttackRelease())
			{
				this.doTurnRoundAttack();
			}
			
			if(name == "heavyAttackReady" && !ControlleBarStatusModel.instance.checkHeavyAttackRelease())
			{
				this.doSkirtFlyStart();
			}
			
			if(name == "skirtStartFly" && !ControlleBarStatusModel.instance.checkHeavyAttackRelease())
				this.doSkirtFlyIng();
			
			
			if(name == "heavyAttackReady" && ControlleBarStatusModel.instance.checkHeavyAttackRelease())
				this.doHeavyAttack();
			
			if(name == "Climb")
			{
				this._isDoingAction = false;
				this._isMoving = false;
				this.updateladderPlatPos(false);
			}
			
			if(name == "HeroHurt" || name == "HeroHeavyhurt")
			{
				this.doIdel();
			}
			
			if(name == "AttackLandscape")
			{
				ControlleBarStatusModel.instance.isReadyToAction = false;
			}
//			if(name == "SkirtAnima" && !ControlleBarStatusModel.instance.checkHeavyAttackRelease())
//				this.showSkitFlyAnima();
		}
		
		private function heroDeadHandler():void
		{
			_heroStatusModel.unRegisterAll();
			_movesDatamodel.unRegisterAll();
			
			this.dispatchEventWith(MainScenceEvent.SHOW_GAME_END_VIEW);
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(_currentAnimaName != "HeroHurt" && _currentAnimaName != "HeroHeavyhurt")
			{
				if(HitTest.complexHitTestObject(_hurtBitmap,hitInfo.hitBounds))
				{
					this._beenHitMove = hitInfo.targetBeenHitMove;		
					if(!_isBloking)						
						_heroStatusModel.heroHurt(hitInfo.attackHurtValue);
					else
					{
						var evet:RoleHurtEvent = new RoleHurtEvent(RoleHurtEvent.ROLE_HURT);
						evet.disX = DicManager.instance.getRoleHurtMoveById(GameRoleEnum.BASE_HERO_CONFIG_ID, _currentMc.currentFrame);
						evet.disX += this._beenHitMove;
						if(_enemyHitInfo&&!_enemyHitInfo.faceForward)
							evet.disX = -1*evet.disX;
						if(evet.disX != 0)
							this.dispatchEvent(evet);						
						//如果攻击力很强，格挡可以抵消一半的伤害
						if(hitInfo.attackHurtValue>Const.HERO_BLOCK_BUFFER)
							_heroStatusModel.heroHurt(hitInfo.attackHurtValue/2);						
					}
				}
				else
					this._beenHitMove = 0;
			}
			
		}
		
		private function checkEnviAttact(hitInfo:ObjEnviHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtBitmap,hitInfo.hitBounds))
			{
				_enviDataModel.noteEnviHitdone(hitInfo.enViHitItemname);
				_heroStatusModel.heroHurt(hitInfo.enViHitValue);
			}
		}
		
		private function checkAttackResult(attackRange:Bitmap, attackInfo:ObjAttackMoveConfig):void
		{
			if(!_isDoingAttack)
				_heroStatusModel.heroAttack(attackRange,attackInfo,_faceForward);
		}
		
		/**
		 * 英雄攻击，敌人躲避 
		 * 
		 */		
		private function noteHeroAtack(moviId:Number):void
		{
			_heroStatusModel.noteHeroAtack(moviId);
		}
		
		
		/**
		 * 由招式id获取招式配置信息 
		 * @param attackMoveId
		 * @return 
		 * 
		 */		
		private function getAttackInfoById(attackMoveId:Number):ObjAttackMoveConfig
		{
			return DicManager.instance.getAttackMoveConfigInfoById(attackMoveId);
		}
	}
}
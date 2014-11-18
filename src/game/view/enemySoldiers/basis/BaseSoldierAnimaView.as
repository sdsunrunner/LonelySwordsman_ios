package game.view.enemySoldiers.basis
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import frame.view.IObserver;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.dataProxy.AutoRecoverCenter;
	import game.manager.dicManager.DicManager;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.event.RoleHurtEvent;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	import game.view.models.EnviItemsInfoModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	import utils.HitTest;
	
	import vo.ObjEnemyStatusInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjEnviHitInfo;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 基础士兵动画视图 
	 * @author admin
	 * 
	 */	
	public class BaseSoldierAnimaView extends BaseViewer implements IObserver
	{
		private var _manAnima:AnimationSequence = null;
		private var _animaName:Array = null;
		private var _doActioning:Boolean = false;
		private var _doIngHurt:Boolean = false;
		private var _walking:Boolean = false;
		
		private var _bodyBounds:Sprite = null;
		
		private var _baseHitBitMap:Bitmap = null;
		private var _senioneHitBitMap:Bitmap = null;
		
		private var _auditionBitMap:Bitmap = null;
		private var _sightBitMap:Bitmap = null;
		private var _hurtRangeBitMap:Bitmap = null;
		
		private var _currentAnimaName:String = "";		
		
		private var _mcDic:Dictionary = null;
//		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _enviDataModel:EnviItemsInfoModel = null;
		private var _sttausInfoModel:EnemyGuiInfoDataModel = null;
		
		private var _faceForward:Boolean = true;
		private var _preCounter:Number = 0;		
				
		private var _maxHp:Number = 0;
		private var _currentHp:Number = 0;		
		private var _delayFlag:Boolean = false;
		
		private  var _beenHitMove:Number = 0;
		private  var _beenHitMoveY:Number = 0;
		private var _enemyHitInfo:ObjHitInfo = null;
		private var _enviHitInfo:ObjEnviHitInfo = null;
		private var _enemyInfo:ObjEnemyStatusInfo = null;
		private var _configInfo:ObjRoleConfigInfo = null;
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private var _name:String = "";
		
		private var _animaTexture:TextureAtlas = null;
		
		private var _localPoint:Point = new Point();
		private var _gloabPoint:Point = new Point();
		private var _currentPos:Point = new Point();
		private var _frameCount:Number = 0;
		
		private var _autoRecoverCenter:AutoRecoverCenter = null;
		private var _canNotBeHit:Boolean = false;
		
		private var _isDoingAttack:Boolean = false;
		
		public function BaseSoldierAnimaView()
		{
			super();
			this.initAnimaView();	
			this.initModel();
			this.addListeners();
		}
		
		public function doAttackLoop():void
		{
			_manAnima.changeAnimation("BasisSoldierWalkAnima",true);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_localPoint = null;
			_gloabPoint = null;
			_currentPos = null;
			
			if(_autoRecoverCenter)
				_autoRecoverCenter.unRegister(this);
			_autoRecoverCenter = null;
			
			if(_sttausInfoModel)
				_sttausInfoModel.removeEnemyInfo(_enemyInfo);
			_enemyInfo = null;
			
			if(_heroStatusModel)
				_heroStatusModel.unRegister(this);
			_heroStatusModel = null;
			
			if(_enviDataModel)
				_enviDataModel.unRegister(this);
			_enviDataModel = null;
			if(_sttausInfoModel)
				_sttausInfoModel.unRegister(this);
			_sttausInfoModel= null;
			
			if(_manAnima)
			{
				_manAnima.parent.removeChild(_manAnima);
				while(_manAnima.numChildren>0)
				{
					_manAnima.removeChildAt(0,true);
				}
				_manAnima.destroy();
				_manAnima.dispose();
				_manAnima = null;
			}
			
			try
			{
				Const.collideLayer.removeChild(_baseHitBitMap);
				_baseHitBitMap = null;
				Const.collideLayer.removeChild(_senioneHitBitMap);
				_senioneHitBitMap = null;
				Const.collideLayer.removeChild(_auditionBitMap);
				_auditionBitMap = null;
				Const.collideLayer.removeChild(_sightBitMap);
				_sightBitMap = null;
				Const.collideLayer.removeChild(_hurtRangeBitMap);
				_hurtRangeBitMap = null;
				
				_enemyHitInfo= null;
				_enviHitInfo = null;
				_enemyInfo = null;
				_configInfo = null;
				_attackInfo = null;
				
				this.removeEventListeners();
			}
			catch(error:Error)
			{
				
			}
		}
		
		public function get faceForward():Boolean
		{
			return _faceForward;
		}

		public function setConfigInfo(configInfo:ObjRoleConfigInfo,name:String):void
		{
			_configInfo = configInfo;
			_maxHp = configInfo.maxHp;
			_currentHp = _maxHp;
			_name = name;
		}

		public function updateCurrentPos(posX:Number, posY:Number):void
		{
			if(_currentPos)
			{
				_currentPos.x = posX;
				_currentPos.y = posY;
			}
		}
		
		public function set faceForward(value:Boolean):void
		{
			_faceForward = value;
		}

		public function get walking():Boolean
		{
			return _walking;
		}

		public function get bodyBounds():Sprite
		{
			return _bodyBounds;
		}
		
		override public function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_enviDataModel = EnviItemsInfoModel.instance;
			_enviDataModel.register(this);
			
			_sttausInfoModel = EnemyGuiInfoDataModel.instance;
			
			
			_autoRecoverCenter = AutoRecoverCenter.instance;
			_autoRecoverCenter.register(this);
			
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_ATTACK)
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
				if(_enviHitInfo)
					this.checkEnviAttact(_enviHitInfo);
			}
			
			if(msgName == MsgTypeEnum.ENEMY_RECOVER && this._currentHp>0)
			{
				this._currentHp += 0.05;
				if(_configInfo&&this._currentHp>_configInfo.maxHp)
					this._currentHp = _configInfo.maxHp;
			}
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			checkcantbreakMove();
			_frameCount++;
			if(_frameCount == Const.FRAME_DELAY)				
			{
				_frameCount = 0;
				_delayFlag = true;
			}
			else
				_delayFlag = false;
			
			this._localPoint.x = this.x;
			this._localPoint.y = this.y;
			_gloabPoint = localToGlobal(this._localPoint);
			var value:Number = 1;
			if(_faceForward)
				value = -1.5;
			else
				value = 1;
			
			
			_baseHitBitMap.y = _gloabPoint.y +110;
			
			
			_senioneHitBitMap.y =  _gloabPoint.y + 110;
			_hurtRangeBitMap.y = _gloabPoint.y + 90;
			_baseHitBitMap.scaleX = 2.3;
			_senioneHitBitMap.scaleX = 2.2;
			if(!_faceForward)
			{
				_baseHitBitMap.x = _gloabPoint.x + value*100-20;
				_auditionBitMap.x =  _gloabPoint.x -100;
				_sightBitMap.x =  _gloabPoint.x +90;
				_hurtRangeBitMap.x = _gloabPoint.x +60;
				_senioneHitBitMap.x =  _gloabPoint.x + value*100;
			}
			else
			{
				_baseHitBitMap.x = _gloabPoint.x + value*100 - 40;
				_senioneHitBitMap.x =  _gloabPoint.x + value*100 - 30;
				_auditionBitMap.x =  _gloabPoint.x -80;
				_sightBitMap.x =  _gloabPoint.x -390;
				_hurtRangeBitMap.x = _gloabPoint.x -75;
			}
			
			_auditionBitMap.y = _gloabPoint.y+100;
			_sightBitMap.y = _gloabPoint.y+100;
			
			
			if(_currentAnimaName == "BasisSoldierHurtAnima")
			{
				if(_mcDic[_currentAnimaName].currentFrame == 2&&this._enemyHitInfo&&this._enemyHitInfo.attackMoveId>0)
					this._heroStatusModel.noteShakWorld(this._enemyHitInfo.faceForward,this._enemyHitInfo.attackMoveId,true);
				
				var evet:RoleHurtEvent = new RoleHurtEvent(RoleHurtEvent.ROLE_HURT);
				
				evet.disX = DicManager.instance.getRoleHurtMoveById(GameRoleEnum.BASE_ENEMY_SOLDIER_CONFIG_ID, _mcDic[_currentAnimaName].currentFrame);
				evet.disX += this._beenHitMove;
				evet.disY = this._beenHitMoveY;
				if(_enemyHitInfo&&!this._enemyHitInfo.faceForward)
					evet.disX = -1*evet.disX;
				this.dispatchEvent(evet);
				_isDoingAttack = false;
			}
			
			if(_currentAnimaName == "BasisSoldierBaseAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.BASE_SOLDIER_BASE_ATTACK);
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_baseHitBitMap,_attackInfo);
					_baseHitBitMap.visible = true;
					_isDoingAttack = true;
				}					
				else
				{
					this.checkAttackResult(_baseHitBitMap,null);
					_isDoingAttack = false;
				}
			}
			
			if(_currentAnimaName == "BasisSoldieSeniorAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.BASE_SOLDIER_SENIOR_ATTACK);
				
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_senioneHitBitMap,_attackInfo);
					_senioneHitBitMap.visible = true;
					_isDoingAttack = true;
				}
				else
				{
					this.checkAttackResult(_senioneHitBitMap,null);
					_isDoingAttack = false;
				}
			}
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
			}
			this.noteStatus();
		}
		
		/**
		 * 检查士兵传感器接货类型 
		 * @param trail
		 * @return 
		 * 
		 */		
		public function checkHeroTrail(trail:Bitmap):String
		{
			
			if(HitTest.complexHitTestObject(trail,_auditionBitMap)&&this._delayFlag)
				return SensorEnum.AUDITION;
			
			if(HitTest.complexHitTestObject(trail,_sightBitMap))
			{
				return SensorEnum.SOLDIER_SIGHT;
			}			
			return "";
		}
		
		
		public function doAttack():void
		{
			if(!_doActioning&&!_doIngHurt && this._currentHp>0)
			{
				_doIngHurt = false;
				if(Math.random()>0.5)
					_currentAnimaName = "BasisSoldieSeniorAttack";
				else
					_currentAnimaName = "BasisSoldierBaseAttack";
					
				_manAnima.changeAnimation(_currentAnimaName,false);
				_walking = false;
				_doActioning = true;
			}
		}
		
		private function doDeath():void
		{
			_currentAnimaName = "BasisSoldierDeath";
			_manAnima.changeAnimation(_currentAnimaName,false);
			
			this.dispatchEventWith(EnemyEvent.ENMY_DEATH_NOTE);
			
		}
		
		public function doWalk():void
		{
			if(!_walking && !_doActioning&&!_doIngHurt&& this._currentHp>0)
			{
				_doIngHurt = false;
				_walking = true;
				_doActioning = false;
				_currentAnimaName = "BasisSoldierWalkAnima";
				_manAnima.changeAnimation(_currentAnimaName,true);
			}
				
		}
		
		public function doHurt(hurtValue:Number):void
		{
			if(!_doIngHurt)
			{
				_currentHp -= hurtValue;
				_doIngHurt = true;
				_walking = false;
				_doActioning = false;
				_currentAnimaName = "BasisSoldierHurtAnima";
				_manAnima.changeAnimation(_currentAnimaName,false);
			}
		}
		
		private function initAnimaView():void
		{
			_animaName = ["BasisSoldierBaseAttack","BasisSoldierDeath","BasisSoldierHurtAnima","BasisSoldierIdelMc","BasisSoldierWalkAnima","BasisSoldieSeniorAttack"];
			_animaTexture = assetManager.getTextureAtlas("basetallSoldier");
			_manAnima = new AnimationSequence(_animaTexture,_animaName,"BasisSoldierIdelMc",Const.GAME_ANIMA_FRAMERATE,true);
			_manAnima.touchable = false;
			_manAnima.scaleX = -1;
			_walking = false;
			_manAnima.pivotX = _manAnima.width+7;
			_mcDic = _manAnima.mcSequences;
			_bodyBounds = new Sprite();
			this.addChild(_bodyBounds);
			_bodyBounds.addChild(_manAnima);

			_baseHitBitMap = new Bitmap();
			_baseHitBitMap.bitmapData = assetManager.getBitmapForHitByName("baseHit");
			Const.collideLayer.addChild(_baseHitBitMap);

			_senioneHitBitMap = new Bitmap();
			_senioneHitBitMap.bitmapData = assetManager.getBitmapForHitByName("seniorHit");
			Const.collideLayer.addChild(_senioneHitBitMap);
			
			_auditionBitMap = new Bitmap();
			_auditionBitMap.bitmapData = assetManager.getBitmapForHitByName("basicesaudition");
			Const.collideLayer.addChild(_auditionBitMap);
			
			_sightBitMap = new Bitmap();
			_sightBitMap.bitmapData = assetManager.getBitmapForHitByName("basicSight");
			Const.collideLayer.addChild(_sightBitMap);
			
			_hurtRangeBitMap = new Bitmap();
			_hurtRangeBitMap.bitmapData = assetManager.getBitmapForHitByName("baseSoldierHurtRang");
			Const.collideLayer.addChild(_hurtRangeBitMap);
		}
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
		}
		
		private function animaComplete(name:String):void
		{
			if(name == "BasisSoldieSeniorAttack" || name == "BasisSoldierBaseAttack")
				_doActioning = false;
			
			if(name == "BasisSoldierHurtAnima" && this._currentHp > 0)
				_doIngHurt = false;
			
			if(name == "BasisSoldierHurtAnima" && this._currentHp <= 0)
			{
				_doActioning = true;
				this.doDeath();
			}
			
			if(name == "BasisSoldierDeath")
			{
				this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
			}
		}
		
		private function checkAttackResult(hitBmap:Bitmap,moveAttackConfig:ObjAttackMoveConfig):void
		{
			if(!_isDoingAttack)
				_heroStatusModel.enemyHitMove(hitBmap,moveAttackConfig, this._faceForward);
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtRangeBitMap,hitInfo.hitBounds))
			{
				if(!this._canNotBeHit)
				{
					this._beenHitMove = hitInfo.targetBeenHitMove;
					this._beenHitMoveY = hitInfo.targetBeenHitMoveY;
					this.doHurt(hitInfo.attackHurtValue);
				}
			}
			else
			{
				this._beenHitMove = 0;
				this._beenHitMoveY = 0;
			}	
		}
		
		private function checkEnviAttact(hitInfo:ObjEnviHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtRangeBitMap,hitInfo.hitBounds))
			{
				_enviDataModel.noteEnviHitdone(hitInfo.enViHitItemname);
				this.doHurt(hitInfo.enViHitValue);
			}
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
		
		/**
		 * 不能被打断招数 
		 * 
		 */		
		private function checkcantbreakMove():void
		{
//			if(_attackInfo)
//			{
//				if(_attackInfo.unconquerableLabMin>0)
//				{
//					if(_mcDic[_currentAnimaName].currentFrame >= _attackInfo.unconquerableLabMin
//						&&_mcDic[_currentAnimaName].currentFrame<=_attackInfo.releaseLab[0]-1)
//						this._canNotBeHit = false;
//					else
//						this._canNotBeHit = false;
//				}
//				else
//					this._canNotBeHit = false;
//			}
		}
		
		private function noteStatus():void
		{
			if(null == _enemyInfo)
			{
				_enemyInfo = new ObjEnemyStatusInfo();
				_enemyInfo.enemyConfigInfo = _configInfo;
				_enemyInfo.enemyId = this._name;
			}
			
			_enemyInfo.currentHp = this._currentHp;
			if(_currentPos&&_sttausInfoModel&&_enemyInfo)
				_enemyInfo.currentPos = new Point(_currentPos.x,_currentPos.y);
			_enemyInfo.isDead = this._currentHp<=0;
			_sttausInfoModel.updateEnemyInfo(_enemyInfo);
		}
		
	}
}
package  game.view.enemySoldiers.twoKnives
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import extend.draw.display.Shape;
	
	import frame.sys.track.ITrackable;
	import frame.view.IObserver;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.dataProxy.AutoRecoverCenter;
	import game.manager.dicManager.DicManager;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.event.RoleHurtEvent;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.display.MovieClip;
	
	import utils.HitTest;
	
	import vo.ObjEnemyStatusInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 双刀士兵动画视图 
	 * @author admin
	 * 
	 */	
	public class TwoKnivesSoldierAnimaView extends BaseViewer implements IObserver, ITrackable
	{
		private var _manAnima:AnimationSequence = null;
		private var _doActioning:Boolean = false;
		private var _doIngHurt:Boolean = false;
		private var _walking:Boolean = false;
		private var _bodyBounds:Shape = null;
		
		
		private var _baseHitBitMap:Bitmap = null;
		private var _magicHitBitMap:Bitmap = null;
		
		
		private var _auditionBitMap:Bitmap = null;
		private var _sightBitMap:Bitmap = null;
		private var _hurtRangeBitMap:Bitmap = null;
		
		private var _currentAnimaName:String = "";
		
		private static const  _baseAttackLab:Number = 9;
		private static const  _seniorAttackLab:Number = 23;
		private var _mcDic:Dictionary = null;
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _gloabPoint:Point = new Point();
		
		private var _faceForward:Boolean = true;
		private var _preCounter:Number = 0;
		
		private var _enemyHitInfo:ObjHitInfo = null;
		
		private var _maxHp:Number = 0;
		private var _currentHp:Number = 0;
		private var _delayFlag:Boolean = false;
		
		private var _sttausInfoModel:EnemyGuiInfoDataModel = null;
		private var _enemyInfo:ObjEnemyStatusInfo = null;
		private var _configInfo:ObjRoleConfigInfo = null;
		private var _name:String = "";
		private var _currentPos:Point = null;
		
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private var _currentMc:MovieClip = null;
		private var _attackMoveIdArr:Array = [RoleActionEnum.TWOKNIVES_SOLDIER_BASE_ATTACK_1,
											RoleActionEnum.TWOKNIVES_SOLDIER_BASE_ATTACK_2,
											RoleActionEnum.TWOKNIVES_SOLDIER_BASE_ATTACK_3,
											RoleActionEnum.TWOKNIVES_SOLDIER_BASE_ATTACK_4,
											RoleActionEnum.TWOKNIVES_SOLDIER_BASE_ATTACK_5];
			
		private var _attackMoveInfoDic:Dictionary = null;
		private var _beenHitMove:Number = 0;
		private var _frameCount:Number = 0;
		private var _isDoingAttack:Boolean = false;
		private var _autoRecoverCenter:AutoRecoverCenter = null;
		
		private var _canNotBeHit:Boolean = false;
		public function TwoKnivesSoldierAnimaView()
		{
			super();
			this.initAnimaView();
			this.addListeners();
			this.initModel();
			this.initAttackMoveInfo();
		}
		
		public function doAttackLoop():void
		{
			_manAnima.changeAnimation("TwoKnivesAttackMc",true);
		}
		
		public function setConfigInfo(configInfo:ObjRoleConfigInfo,name:String):void
		{
			_configInfo = configInfo;
			_maxHp = configInfo.maxHp;
			_currentHp = _maxHp;
			_name = name;
		}
		
		
		
		public function set faceForward(value:Boolean):void
		{
			_faceForward = value;
		}
		
		public function get walking():Boolean
		{
			return _walking;
		}
		
		public function get bodyBounds():Shape
		{
			return _bodyBounds;
		}
		
		public function updateCurrentPos(posX:Number, posY:Number):void
		{
			if(this._currentPos == null)
				_currentPos = new Point();
			_currentPos.x = posX;
			_currentPos.y = posY;
		}
		
		public function heroDeathHandler():void
		{
			this.doIdel();
		}
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_autoRecoverCenter = AutoRecoverCenter.instance;
			_autoRecoverCenter.register(this);
			
			_sttausInfoModel = EnemyGuiInfoDataModel.instance;
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
			
			if(msgName == MsgTypeEnum.ENEMY_RECOVER && this._currentHp>0)
			{
				this._currentHp += 0.05;
				if(this._currentHp > this._configInfo.maxHp)
					this._currentHp = this._configInfo.maxHp;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_sttausInfoModel.removeEnemyInfo(_enemyInfo);
			_enterFrameCenter.unRegister(this);
			_heroStatusModel.unRegister(this);
			_sttausInfoModel.unRegister(this);
			if(_autoRecoverCenter)
			{
				_autoRecoverCenter.unRegister(this);
				_autoRecoverCenter = null;				
			}
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{	
			_frameCount++;
			checkcantbreakMove();
			if(_frameCount == Const.FRAME_DELAY)				
			{
				_frameCount = 0;
				_delayFlag = true;
			}
			else
				_delayFlag = false;
			
			_gloabPoint = localToGlobal(new Point(this.x,this.y));
			
			if(!_faceForward)
			{
				_auditionBitMap.x =  _gloabPoint.x - 120;
				_sightBitMap.x =  _gloabPoint.x + 90;
			
				_baseHitBitMap.x = _gloabPoint.x + 70;
				_magicHitBitMap.x = _gloabPoint.x + 90;
				_hurtRangeBitMap.x = _gloabPoint.x+80;
				_hurtRangeBitMap.scaleX = -1;
			}
			else
			{
				_auditionBitMap.x =  _gloabPoint.x-40;
				_sightBitMap.x =  _gloabPoint.x -390;
				_hurtRangeBitMap.x = _gloabPoint.x-80;
			
				_baseHitBitMap.x = _gloabPoint.x -180;
				_magicHitBitMap.x = _gloabPoint.x - 240;
				_hurtRangeBitMap.scaleX = 1;
			}
			
		
			_baseHitBitMap.scaleX = 3;
			_baseHitBitMap.scaleY = 2;
			_auditionBitMap.scaleX = 1.2;
			
			_auditionBitMap.y = _gloabPoint.y+60;
			_sightBitMap.y = _gloabPoint.y+60;
			_baseHitBitMap.y = _gloabPoint.y +70;			
		
			_hurtRangeBitMap.y = _gloabPoint.y + 60;
			_magicHitBitMap.y = _gloabPoint.y + 60;
			_magicHitBitMap.visible = false;
			
			if(_currentAnimaName == "TwoKnivesHurtMc")
			{
				if(_mcDic[_currentAnimaName].currentFrame == 2&&this._enemyHitInfo.attackMoveId>0)
					this._heroStatusModel.noteShakWorld(this._enemyHitInfo.faceForward,this._enemyHitInfo.attackMoveId,true);
				
				var evet:RoleHurtEvent = new RoleHurtEvent(RoleHurtEvent.ROLE_HURT);
				
				evet.disX = DicManager.instance.getRoleHurtMoveById(GameRoleEnum.TWO_KNIFES_ENEMY_SOLDIER_CONFIG_ID, _mcDic[_currentAnimaName].currentFrame);
				evet.disX += this._beenHitMove;
				if(!this._enemyHitInfo.faceForward)
					evet.disX = -1*evet.disX;
				this.dispatchEvent(evet);
			}
			
			
			if(_currentAnimaName == "TwoKnivesAttackMc")
			{
				_attackInfo = getCurrentAttackInfo(_mcDic[_currentAnimaName].currentFrame);
				
				if(_attackInfo&&_attackInfo.releaseLab[0]>50)
				{
					_magicHitBitMap.visible = true;
					this.checkAttackResult(_magicHitBitMap,_attackInfo);
				}
				else
				{
					_magicHitBitMap.visible = false;
					this.checkAttackResult(_baseHitBitMap,_attackInfo);
				}
					
			}
			
			this.noteStatus();
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
			}
		}
		
		/**
		 * 检查士兵传感器接货类型 
		 * @param trail
		 * @return 
		 * 
		 */		
		public function checkHeroTrail(trail:Bitmap):String
		{
		
			if(HitTest.complexHitTestObject(trail,_auditionBitMap) &&_delayFlag)
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
				_manAnima.y = -49;
				_manAnima.x = -30;
				_doIngHurt = false;
				_currentAnimaName = "TwoKnivesAttackMc";
				_manAnima.changeAnimation(_currentAnimaName,false);
				_walking = false;
				_doActioning = true;
				
			}
		}
		
		private function doDeath():void
		{
			_manAnima.x = -60;
			_manAnima.y = -16;
			_currentAnimaName = "TwoKnivesDeath";
			_manAnima.changeAnimation(_currentAnimaName,false);
			_walking = false;
			this.dispatchEventWith(EnemyEvent.ENMY_DEATH_NOTE);
		}
		
		public function doWalk():void
		{
			if(!_walking && !_doActioning&&!_doIngHurt&& this._currentHp>0)
			{
				_manAnima.x = 0;
				_manAnima.y = -7;
				_doIngHurt = false;
				_walking = true;
				_doActioning = false;
				_currentAnimaName = "TwoKnivesWalkMc";
				_manAnima.changeAnimation(_currentAnimaName,true);
			}
			
		}
		
		public function doHurt():void
		{
			if(!_doIngHurt)
			{
				_manAnima.x = -5;
				_manAnima.y = -10;
				_doIngHurt = true;
				_walking = false;
				_doActioning = false;
				_currentAnimaName = "TwoKnivesHurtMc";
				_manAnima.changeAnimation(_currentAnimaName,false);
			}
		}
		public function doIdel():void
		{
			_manAnima.x = 0;
			_manAnima.y = 0;
			_doIngHurt = false;
			_walking = false;
			_doActioning = false;
			_currentAnimaName = "TwoKnivesIdelMc";
			_manAnima.changeAnimation(_currentAnimaName,false);
		}
		
		private function initAnimaView():void
		{
			var animaName:Array = ["TwoKnivesAttackMc","TwoKnivesDeath","TwoKnivesHurtMc","TwoKnivesIdelMc","TwoKnivesWalkMc"];
			_manAnima = new AnimationSequence(assetManager.getTextureAtlas("twoKnivers"),animaName,"TwoKnivesIdelMc",Const.GAME_ANIMA_FRAMERATE,true);
			_manAnima.touchable = false;
			
			_manAnima.pivotX = _manAnima.width>>1+10;
			_mcDic = _manAnima.mcSequences;
			doWalk();
			
			_bodyBounds = new Shape();
			this.addChild(_bodyBounds);
			this.addChild(_manAnima);
			
			_baseHitBitMap = new Bitmap();
			_baseHitBitMap.bitmapData = assetManager.getBitmapForHitByName("baseHit");
			Const.collideLayer.addChild(_baseHitBitMap);
		
			
			_auditionBitMap = new Bitmap();
			_auditionBitMap.bitmapData = assetManager.getBitmapForHitByName("basicesaudition");
			Const.collideLayer.addChild(_auditionBitMap);
			
			_sightBitMap = new Bitmap();
			_sightBitMap.bitmapData = assetManager.getBitmapForHitByName("basicSight");
			Const.collideLayer.addChild(_sightBitMap);
			
			_hurtRangeBitMap = new Bitmap();
			_hurtRangeBitMap.bitmapData = assetManager.getBitmapForHitByName("twoNifesHurt");
			Const.collideLayer.addChild(_hurtRangeBitMap);
			
			_magicHitBitMap = new Bitmap();
			_magicHitBitMap.scaleX = 3;
			_magicHitBitMap.bitmapData = assetManager.getBitmapForHitByName("twoKnifSoldierSAttac");
			Const.collideLayer.addChild(_magicHitBitMap);
		}
		
		private function initAttackMoveInfo():void
		{
			_attackMoveInfoDic = new Dictionary();
			for(var i:Number = 0; i < _attackMoveIdArr.length; i++)
			{
				var attackId:Number = _attackMoveIdArr[i];
				var attackInfo:ObjAttackMoveConfig = this.getAttackInfoById(attackId);
				_attackMoveInfoDic[attackInfo.releaseLab[0]] = attackInfo;
			}
		}
		
		/**
		 * 获取当前攻击信息 
		 * @param currentFrame
		 * @return 
		 * 
		 */		
		private function getCurrentAttackInfo(currentFrame:Number):ObjAttackMoveConfig
		{
			return _attackMoveInfoDic[currentFrame] as ObjAttackMoveConfig;
		}
		
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
		}
		
		private function animaComplete(name:String):void
		{
			if(name == "TwoKnivesAttackMc")
				_doActioning = false;
			
			if(name == "TwoKnivesHurtMc" && this._currentHp > 0)
				_doIngHurt = false;
			
			if(name == "TwoKnivesHurtMc" && this._currentHp <= 0)
			{
				_doActioning = true;
				this.doDeath();
			}
			
			
			if(name == "TwoKnivesDeath")
			{
				this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
				Const.collideLayer.removeChild(_baseHitBitMap);
				Const.collideLayer.removeChild(_auditionBitMap);
				Const.collideLayer.removeChild(_sightBitMap);
				Const.collideLayer.removeChild(_hurtRangeBitMap);
				Const.collideLayer.removeChild(_magicHitBitMap);
				this.visible = false;
			}
		}
		
		private function checkAttackResult(hitBmap:Bitmap,moveAttackId):void
		{
			_heroStatusModel.enemyHitMove(hitBmap,moveAttackId, this._faceForward);
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtRangeBitMap,hitInfo.hitBounds))
			{
				if(!this._canNotBeHit)
				{
					_currentHp -= hitInfo.attackHurtValue;
					this._beenHitMove = hitInfo.targetBeenHitMove;
					this.doHurt();
				}
			}
			else
				this._beenHitMove = 0;
		}
		
		/**
		 * 不能被打断招数 
		 * 
		 */		
		private function checkcantbreakMove():void
		{
			if(_attackInfo)
			{
				if(_attackInfo.unconquerableLabMin>0)
				{
					if(_mcDic[_currentAnimaName].currentFrame >= _attackInfo.unconquerableLabMin
						&&_mcDic[_currentAnimaName].currentFrame<=_attackInfo.unconquerableLabMax)
						this._canNotBeHit = true;
					else
						this._canNotBeHit = false;
				}
				else
					this._canNotBeHit = false;
			}
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
package game.view.enemySoldiers.tall
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import extend.draw.display.Shape;
	
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
	
	import starling.display.MovieClip;
	
	import utils.HitTest;
	
	import vo.ObjEnemyStatusInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 高大士兵动画视图 
	 * @author admin
	 * 
	 */	
	public class TallSoldierAnimaView extends BaseViewer implements IObserver
	{
		private var _manAnima:AnimationSequence = null;
		private var _doActioning:Boolean = false;
		private var _doIngHurt:Boolean = false;
		private var _walking:Boolean = false;
		
		private var _bodyBounds:Shape = null;
		
		
		private var _baseHitBitMap:Bitmap = null;	
		private var _hurtRangeBitMap:Bitmap = null;
		
		private var _auditionBitMap:Bitmap = null;
		private var _sightBitMap:Bitmap = null;		
		private var _currentAnimaName:String = "";
		
	
		private var _mcDic:Dictionary = null;
		
		private var _heroStatusModel:HeroStatusModel = null;
		private var _sttausInfoModel:EnemyGuiInfoDataModel = null;
		private var _enviItemsInfoModel:EnviItemsInfoModel = null;
		private var _enemyInfo:ObjEnemyStatusInfo = null;
		private var _gloabPoint:Point = new Point();
		
		private var _faceForward:Boolean = false;
		private var _preCounter:Number = 0;
		
		private var _enemyHitInfo:ObjHitInfo = null;
		private var _enviHitInfo:ObjHitInfo = null;
		private var _maxHp:Number = 0;
		private var _currentHp:Number = 0;
		private var _delayFlag:Boolean = false;
		private var _configInfo:ObjRoleConfigInfo = null;
		private var _name:String = "";
		private var _currentPos:Point = null;
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private  var _beenHitMove:Number = 0;
		private  var _beenHitMoveY:Number = 0;
		private var _frameCount:Number = 0;
		
		private var _autoRecoverCenter:AutoRecoverCenter  = null;
		private var _canNotBeHit:Boolean = false;
		private var _isDoingAttack:Boolean = false;
		public function TallSoldierAnimaView()
		{
			super();
			this.initAnimaView();
			this.addListeners();
			this.initModel();
		}
		
		public function doAttackLoop():void
		{
//			_manAnima.changeAnimation("TallWalklMc",true);
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
			if(this._currentPos == null)
				_currentPos = new Point();
			_currentPos.x = posX;
			_currentPos.y = posY;
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
		
		override public function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			_sttausInfoModel = EnemyGuiInfoDataModel.instance;
			
			_enviItemsInfoModel = EnviItemsInfoModel.instance;
			_enviItemsInfoModel.register(this);
			
			
			_autoRecoverCenter = AutoRecoverCenter.instance;
			_autoRecoverCenter.register(this);
		}
		
		override public function dispose():void
		{
			super.dispose();
			if(_sttausInfoModel)
			{
				_sttausInfoModel.removeEnemyInfo(_enemyInfo);
				_sttausInfoModel.unRegister(this);
			}
			if(_heroStatusModel)
				_heroStatusModel.unRegister(this);
			_heroStatusModel = null;
			
			_enviItemsInfoModel.unRegister(this);
			_enviItemsInfoModel = null;
			_gloabPoint = null;
			_currentPos = null;
			
			if(_autoRecoverCenter)
			{
				_autoRecoverCenter.unRegister(this);
				_autoRecoverCenter = null;
			}
			
			for (var key:* in this._mcDic)
			{
				var mc:MovieClip = _mcDic[key];				
				mc.dispose();
				delete _mcDic[key];
				mc = null;
			}
			
			if(_manAnima)
			{
				_manAnima.onAnimationComplete.removeAll();
//				_manAnima.removeAllAnimations();
				
				while(_manAnima.numChildren>0)
				{
					_manAnima.removeChildAt(0,true);
				}
				_manAnima = null;
			}
			
			
			if(_autoRecoverCenter)
			{
				_autoRecoverCenter.unRegister(this);
				_autoRecoverCenter = null;
			}
			
			if(_sttausInfoModel)
				_sttausInfoModel.unRegister(this);
			_sttausInfoModel= null;
			
			if(_manAnima)
			{
				_manAnima.destroy();
				_manAnima.dispose();
			}
			
			if(_baseHitBitMap && _auditionBitMap &&_sightBitMap && _hurtRangeBitMap)
			{
				if(_baseHitBitMap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_baseHitBitMap);
				if(_auditionBitMap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_auditionBitMap);
				if(_sightBitMap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_sightBitMap);
				if(_hurtRangeBitMap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_hurtRangeBitMap);
				
				_baseHitBitMap.bitmapData.dispose();
				_baseHitBitMap = null;
				
				_auditionBitMap.bitmapData.dispose();
				_auditionBitMap = null;
				
				_sightBitMap.bitmapData.dispose();
				_sightBitMap = null;
				
				_hurtRangeBitMap.bitmapData.dispose();
				_hurtRangeBitMap = null;
				_enemyHitInfo= null;
				_enviHitInfo = null;
				_enemyInfo = null;
				_configInfo = null;
				_attackInfo = null;
			}
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}			
			this.removeEventListeners();
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
				_enviHitInfo = data as ObjHitInfo;
				if(_enviHitInfo)
					this.checkEnemyAttact(_enviHitInfo);
			}
			
			if(msgName == MsgTypeEnum.ENEMY_RECOVER && this._currentHp>0)
			{
				this._currentHp += 0.05;
				if(this._currentHp > this._configInfo.maxHp)
					this._currentHp = this._configInfo.maxHp;
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
				_baseHitBitMap.x = _gloabPoint.x+225;
				_hurtRangeBitMap.x = _gloabPoint.x +90;
				_auditionBitMap.x =  _gloabPoint.x -120;
				_sightBitMap.x =  _gloabPoint.x +100;
				
				_baseHitBitMap.scaleX = -1.5;
				_sightBitMap.scaleX = 0.8;
				_hurtRangeBitMap.scaleX = -1;
			}
			else
			{
				_baseHitBitMap.scaleX = 1;
				_hurtRangeBitMap.scaleX = 1.5;
				_sightBitMap.scaleX = 0.8;
				_baseHitBitMap.x = _gloabPoint.x-225;
				_auditionBitMap.x =  _gloabPoint.x -50;
				_sightBitMap.x =  _gloabPoint.x -390;
				_hurtRangeBitMap.x = _gloabPoint.x -100;
			}
			
			_auditionBitMap.y = _gloabPoint.y+90;
			_sightBitMap.y = _gloabPoint.y+90;
			_baseHitBitMap.y = _gloabPoint.y +80;
			_hurtRangeBitMap.y = _gloabPoint.y + 110;
			if(_currentAnimaName == "TallAttackMc")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.TALL_SOLDIER_ATTACK);
				if( _attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{	
					this.checkAttackResult(_baseHitBitMap,_attackInfo);
					_baseHitBitMap.visible = true;
					_isDoingAttack = true;
				}
				else
					_isDoingAttack = false;
			}
			
			if(_currentAnimaName == "TallHurtMc")
			{
				if(_mcDic[_currentAnimaName].currentFrame == 2)
					this._heroStatusModel.noteShakWorld(this._enemyHitInfo.faceForward,this._enemyHitInfo.attackMoveId,true);
				
				var evet:RoleHurtEvent = new RoleHurtEvent(RoleHurtEvent.ROLE_HURT);
				
				evet.disX = DicManager.instance.getRoleHurtMoveById(GameRoleEnum.BASE_ENEMY_SOLDIER_CONFIG_ID, _mcDic[_currentAnimaName].currentFrame);
				evet.disX += this._beenHitMove;
				evet.disY = this._beenHitMoveY/2;
				if(!this._enemyHitInfo.faceForward)
					evet.disX = -1*evet.disX;
				this.dispatchEvent(evet);
				
				_isDoingAttack = false;
				
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
				_manAnima.x = 50;
				_doIngHurt = false;
				_currentAnimaName = "TallAttackMc";
				_manAnima.changeAnimation(_currentAnimaName,false);
				_walking = false;
				_doActioning = true;
				
			}
		}
		
		private function doDeath():void
		{
			_manAnima.x = -10;
			_manAnima.y = -18;
			_currentAnimaName = "TallDeath";
			_manAnima.changeAnimation(_currentAnimaName,false);
			
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
				_currentAnimaName = "TallWalklMc";
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
				_currentAnimaName = "TallHurtMc";
				_manAnima.changeAnimation(_currentAnimaName,false);
			}
		}
		
		private function initAnimaView():void
		{
			var animaName:Array = ["TallAttackMc","TallDeath","TallHurtMc","TallIdelMc","TallWalklMc"];
			_manAnima = new AnimationSequence(assetManager.getTextureAtlas("basetallSoldier"),animaName,"TallIdelMc",Const.GAME_ANIMA_FRAMERATE,true);
			_manAnima.touchable = false;
			_manAnima.scaleX = -1;
			
			_manAnima.pivotX = _manAnima.width+3;
			_mcDic = _manAnima.mcSequences;
			doWalk();
			
			_bodyBounds = new Shape();
			this.addChild(_bodyBounds);
			_bodyBounds.addChild(_manAnima);
			
			_baseHitBitMap = new Bitmap();
			_baseHitBitMap.bitmapData = assetManager.getBitmapForHitByName("tallHitrange");
			Const.collideLayer.addChild(_baseHitBitMap);
			
			
			_auditionBitMap = new Bitmap();
			_auditionBitMap.bitmapData = assetManager.getBitmapForHitByName("basicesaudition");
			Const.collideLayer.addChild(_auditionBitMap);
			
			_sightBitMap = new Bitmap();
			_sightBitMap.bitmapData = assetManager.getBitmapForHitByName("basicSight");
			Const.collideLayer.addChild(_sightBitMap);
			
			_hurtRangeBitMap = new Bitmap();
			_hurtRangeBitMap.bitmapData = assetManager.getBitmapForHitByName("tallHurtRange");
			Const.collideLayer.addChild(_hurtRangeBitMap);
		}
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
		}
		
		private function animaComplete(name:String):void
		{
			if(name == "TallAttackMc")
				_doActioning = false;
			
			if(name == "TallHurtMc" && this._currentHp > 0)
				_doIngHurt = false;
			
			if(name == "TallHurtMc" && this._currentHp <= 0)
			{
				_doActioning = true;
				this.doDeath();
			}
			
			
			if(name == "TallDeath")
			{
				this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
				if(_baseHitBitMap)
					Const.collideLayer.removeChild(_baseHitBitMap);
				if(_auditionBitMap)
					Const.collideLayer.removeChild(_auditionBitMap);
				if(_sightBitMap)
					Const.collideLayer.removeChild(_sightBitMap);
				if(_hurtRangeBitMap)
					Const.collideLayer.removeChild(_hurtRangeBitMap);
				this.visible = false;
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
					_currentHp -= hitInfo.attackHurtValue;
					this._beenHitMove = hitInfo.targetBeenHitMove;
					this._beenHitMoveY = hitInfo.targetBeenHitMoveY;
					this.doHurt();
				}
			}
			else
			{
				this._beenHitMove = 0;
				this._beenHitMoveY = 0;
			}	
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
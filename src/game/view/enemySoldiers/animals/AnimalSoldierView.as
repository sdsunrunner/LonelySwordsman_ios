package game.view.enemySoldiers.animals
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
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	
	import starling.display.MovieClip;
	
	import utils.HitTest;
	
	import vo.ObjEnemyStatusInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 动物士兵动画视图 
	 * @author admin
	 * 
	 */	
	public class AnimalSoldierView extends BaseViewer implements IObserver
	{
		private var _manAnima:AnimationSequence = null;
		private var _smokeAnima:AnimationSequence = null;
		
		
		private var _doActioning:Boolean = false;
		private var _doIngHurt:Boolean = false;
		private var _walking:Boolean = false;
		
		private var _bodyBounds:Shape = null;
		private var _hitBitMap:Bitmap = null;
		
		private var _auditionBitMap:Bitmap = null;
		private var _sightBitMap:Bitmap = null;
		private var _hurtRangeBitMap:Bitmap = null;
		
		private var _currentAnimaName:String = "";
		
		private static const  _baseAttackLab:Number = 9;
		private static const  _seniorAttackLab:Number = 23;
		private var _mcDic:Dictionary = null;
		
		private var _heroStatusModel:HeroStatusModel = null;
		private var _gloabPoint:Point = new Point();
		
		private var _faceForward:Boolean = true;	
		private var _preCounter:Number = 0;
		
		private var _enemyHitInfo:ObjHitInfo = null;
		
		private var _maxHp:Number = 0;
		private var _currentHp:Number = 0;
		private var _delayFlag:Boolean = false;
		
		private var _configInfo:ObjRoleConfigInfo = null;
		private var _name:String = "";
		private var _currentPos:Point = null;
		private var _enemyInfo:ObjEnemyStatusInfo = null;
		private var _sttausInfoModel:EnemyGuiInfoDataModel = null;
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private  var _beenHitMoveX:Number = 0;
		private  var _beenHitMoveY:Number = 0;
		private var _frameCount:Number = 0;
		
		private var _autoRecoverCenter:AutoRecoverCenter = null;
		private var _isDingAttack:Boolean = false;
		private var _isDeath:Boolean = false;
		
		public function AnimalSoldierView()
		{
			super();
			this.initAnimaView();
			this.addListeners();
			this.initModel();
		}
		
		public function doAttackLoop():void
		{
			_manAnima.changeAnimation("AnimalAttack",true);
		}
		
		public function get isDeath():Boolean
		{
			return _isDeath;
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
			
			if(msgName == MsgTypeEnum.ENEMY_RECOVER && this._currentHp>0)
			{
				this._currentHp +=0.1;
				if(this._currentHp>this._configInfo.maxHp)
					this._currentHp = this._configInfo.maxHp;
			}
		}
		
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{	
			_frameCount++;
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
				_auditionBitMap.x =  _gloabPoint.x -80;
				_sightBitMap.x =  _gloabPoint.x +470;
				
				_hurtRangeBitMap.x = _gloabPoint.x+150;
				_hitBitMap.x = _gloabPoint.x + 220;
				_hurtRangeBitMap.scaleX = -1.5;
				_hitBitMap.scaleX = -2;
				_sightBitMap.scaleX  = -1.3;
			}
			else
			{
				_hitBitMap.x = _gloabPoint.x -180;
				_auditionBitMap.x =  _gloabPoint.x - 60;
				_sightBitMap.x =  _gloabPoint.x -460;
				_hurtRangeBitMap.x = _gloabPoint.x -150;
				_hurtRangeBitMap.scaleX = 1.5;
				_hitBitMap.scaleX = 3;
				_sightBitMap.scaleX  = 1.3;
			}
			
			_auditionBitMap.y = _gloabPoint.y;
			_sightBitMap.y = _gloabPoint.y;
			_hitBitMap.y = _gloabPoint.y+10;			
			_hurtRangeBitMap.y = _gloabPoint.y+10;
			
			
			if(_currentAnimaName == "AnimalAttack")
			{
				_attackInfo = getAttackInfoById(RoleActionEnum.ANIMA_SOLDIER_ATTACK);
				if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)
				{
					this.checkAttackResult(_hitBitMap,_attackInfo);
					_hitBitMap.visible = true;
					_isDingAttack = true;
				}					
				else
				{
					_isDingAttack = false;
					this.checkAttackResult(_hitBitMap,null);
				}
			}
			
			if(_currentAnimaName == "AnimalHurt")
			{
				if(_mcDic[_currentAnimaName].currentFrame == 2)
					this._heroStatusModel.noteShakWorld(this._enemyHitInfo.faceForward,this._enemyHitInfo.attackMoveId,true);
				
				var evet:RoleHurtEvent = new RoleHurtEvent(RoleHurtEvent.ROLE_HURT);
				
				evet.disX = DicManager.instance.getRoleHurtMoveById(GameRoleEnum.ANIMA_ENEMY_SOLDIER_CONFIG_ID, _mcDic[_currentAnimaName].currentFrame);
				evet.disX += this._beenHitMoveX+2;
				evet.disY = this._beenHitMoveY + 2;
				if(!this._enemyHitInfo.faceForward)
					evet.disX = -1*evet.disX;
				
				this.dispatchEvent(evet);
			}
			
			this.noteStatus();
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
			}
		}
		
		override public function dispose():void
		{
			if(_auditionBitMap.parent == Const.collideLayer)
				Const.collideLayer.removeChild(_auditionBitMap);	
			if(_sightBitMap.parent == Const.collideLayer)
				Const.collideLayer.removeChild(_sightBitMap);
			if(_hurtRangeBitMap.parent == Const.collideLayer)
				Const.collideLayer.removeChild(_hurtRangeBitMap);
			
			if(_sttausInfoModel)
				_sttausInfoModel.removeEnemyInfo(_enemyInfo);
			
			super.dispose();
			
			_gloabPoint = null;
			_currentPos = null;
			
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
				
				while(_manAnima.numChildren>0)
				{
					_manAnima.removeChildAt(0,true);
				}	
				_manAnima.dispose();
				_manAnima = null;
			}
			
			if(_heroStatusModel)
				_heroStatusModel.unRegister(this);
			_heroStatusModel = null;
			
			if(_autoRecoverCenter)
			{
				_autoRecoverCenter.unRegister(this);
				_autoRecoverCenter = null;
			}
				
			if(_sttausInfoModel)
				_sttausInfoModel.unRegister(this);
			_sttausInfoModel= null;
			
			if(_smokeAnima)
			{
				while(_smokeAnima.numChildren>0)
				{
					_smokeAnima.removeChildAt(0,true);
				}
				_smokeAnima.destroy();
				_smokeAnima.dispose();
				_smokeAnima = null;
			}
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
			this.removeEventListeners();
		}
		/**
		 * 检查士兵传感器接货类型 
		 * @param trail
		 * @return 
		 * 
		 */		
		public function checkHeroTrail(trail:Bitmap):String
		{
			if(HitTest.complexHitTestObject(trail,_auditionBitMap)&&_delayFlag)
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
				_manAnima.x = 0;
				_manAnima.y = -10;
				_doIngHurt = false;
				_currentAnimaName = "AnimalAttack";
				_manAnima.changeAnimation(_currentAnimaName,false);
				_walking = false;
				_doActioning = true;
			}
		}
		
		private function doDeath():void
		{
			_currentAnimaName = "AnimaDead";
			_manAnima.x = 20;
			_manAnima.y = 5;
			_manAnima.changeAnimation(_currentAnimaName,false);
			_walking = false;
		}
		
		public function doWalk():void
		{
			if(!_walking && !_doActioning&&!_doIngHurt&& this._currentHp>0)
			{
				_manAnima.x = 0;
				_manAnima.y = 0;
				
				_doIngHurt = false;
				_walking = true;
				_doActioning = false;
				_currentAnimaName = "AnimalWalk";
				_manAnima.changeAnimation(_currentAnimaName,true);
			}
			
		}
		
		public function doHurt():void
		{
			if(!_doIngHurt)
			{
				_manAnima.x = 0;
				_manAnima.y = 0;
				_doIngHurt = true;
				_walking = false;
				_doActioning = false;
				_currentAnimaName = "AnimalHurt";
				_manAnima.changeAnimation(_currentAnimaName,false);
			}
		}
		
		private function initAnimaView():void
		{
			var animaName:Array = ["AnimalAttack","AnimaDead","AnimalHurt","AnimalIdel","AnimalWalk"];
			_manAnima = new AnimationSequence(assetManager.getTextureAtlas("basetallSoldier"),animaName,"AnimalWalk",Const.GAME_ANIMA_FRAMERATE,true);
			_manAnima.touchable = false;
			_manAnima.scaleX = -1;
			_walking = true;
			_manAnima.pivotX = _manAnima.width+2;
			_mcDic = _manAnima.mcSequences;
			_bodyBounds = new Shape();
			this.addChild(_bodyBounds);
			_bodyBounds.addChild(_manAnima);
			
		
			
//			_smokeAnima.pauseAnimation(false);
//			_smokeAnima.visible = false;
			
			_hitBitMap = new Bitmap();
			_hitBitMap.bitmapData = assetManager.getBitmapForHitByName("animaHit");
			Const.collideLayer.addChild(_hitBitMap);
			
			_auditionBitMap = new Bitmap();
			_auditionBitMap.bitmapData = assetManager.getBitmapForHitByName("basicesaudition");
			Const.collideLayer.addChild(_auditionBitMap);
			
			_sightBitMap = new Bitmap();
			_sightBitMap.bitmapData = assetManager.getBitmapForHitByName("basicSight");
			Const.collideLayer.addChild(_sightBitMap);
			
			_hurtRangeBitMap = new Bitmap();
			_hurtRangeBitMap.bitmapData = assetManager.getBitmapForHitByName("animaHurt");
			Const.collideLayer.addChild(_hurtRangeBitMap);
		}
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
			
		}
		
		private function smokeAnimaComplete(name:String):void
		{
			this.visible = false;
			this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
		}		
		
		private function animaComplete(name:String):void
		{
			if(name == "AnimalAttack")
				_doActioning = false;
			
			if(name == "AnimalHurt" && this._currentHp > 0)
				_doIngHurt = false;
			
			if(name == "AnimalHurt" && this._currentHp <= 0)
			{
				_doActioning = true;
				this.doDeath();
			}
			
			if(name == "AnimaDead")
			{
				_sttausInfoModel.removeEnemyInfo(_enemyInfo);
				
				_heroStatusModel.unRegister(this);
				_sttausInfoModel.unRegister(this);
				_hitBitMap.bitmapData.dispose();
				Const.collideLayer.removeChild(_hitBitMap);
				
				_auditionBitMap.bitmapData.dispose();
				Const.collideLayer.removeChild(_auditionBitMap);
				_sightBitMap.bitmapData.dispose();
				Const.collideLayer.removeChild(_sightBitMap);
				_hurtRangeBitMap.bitmapData.dispose();
				Const.collideLayer.removeChild(_hurtRangeBitMap);
				
				_walking = false;
				var smokeanimaName:Array = ["expsmoke"];			
				_smokeAnima = new AnimationSequence(assetManager.getTextureAtlas("scence_effect"),smokeanimaName,"expsmoke",Const.GAME_ANIMA_FRAMERATE,false);
				_smokeAnima.scaleX = _smokeAnima.scaleY = 0.5;		
				_smokeAnima.y = -130;
				_bodyBounds.addChild(_smokeAnima);
				_manAnima.visible = false;
				_smokeAnima.onAnimationComplete.add(smokeAnimaComplete);
				_currentAnimaName = "expsmoke";
				this._isDeath = true;
				soundExpressions.playActionSound(_currentAnimaName,1);
			}
		}
		
		private function checkAttackResult(hitBmap:Bitmap,moveAttackId):void
		{
			if(!_isDingAttack)
				_heroStatusModel.enemyHitMove(hitBmap,moveAttackId, this._faceForward);
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtRangeBitMap,hitInfo.hitBounds))
			{
				_currentHp -= hitInfo.attackHurtValue;
				
				this._beenHitMoveX = hitInfo.targetBeenHitMove;
				this._beenHitMoveY = hitInfo.targetBeenHitMoveY;
				this.doHurt();
			}
			else
			{
				this._beenHitMoveY = 0;
				this._beenHitMoveX = 0;
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
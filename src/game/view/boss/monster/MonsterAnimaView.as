package game.view.boss.monster
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.dataProxy.AutoRecoverCenter;
	import game.manager.dicManager.DicManager;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	
	import utils.HitTest;
	
	import vo.ObjEnemyStatusInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 怪物动画视图 
	 * @author admin
	 * 
	 */	
	public class MonsterAnimaView extends BaseViewer
	{
		private var _manAnima:AnimationSequence = null;
		private var _effectAnima:AnimationSequence = null;
		
		private var _smokeAnima:AnimationSequence = null;
		
		private var _mcDic:Dictionary = null;
		private var _faceForward:Boolean = false;
		private var _isMoving:Boolean = false;
		private var _currentAnimaName:String = "";
		private var _doAction:Boolean = false;
		
		private var _hitRange:Bitmap = null;
		private var _hurtRange:Bitmap = null;		
		private var _sightRange:Bitmap = null;
		
		private var _gloabPoint:Point = null;	
		private var _heroStatusModel:HeroStatusModel = null;
		private var _sttausInfoModel:EnemyGuiInfoDataModel = null;
		
		private var _heroHurtRange:Bitmap = null;
		
		private var _currentHp:Number = NaN;
		private var _currentMp:Number = NaN;
		private var _maxHp:Number = NaN;
		private var _maxMp:Number = NaN;
		private static const  OFFSET_X:Number = 0;
		private var _enemyHitInfo:ObjHitInfo = null;
		
		private var _canNotBeHit:Boolean = false;
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private var _enemyInfo:ObjEnemyStatusInfo = null;
		private var _configInfo:ObjRoleConfigInfo = null;
		private var _name:String = "";
		private var _currentPos:Point = null;	
		private var _isDead:Boolean = false;
		
		private var _isWorking:Boolean = false;
		
		private var _autoRecoverCenter:AutoRecoverCenter = null;
		private var _isDingAttack:Boolean = false;
		
		public function MonsterAnimaView()
		{
			super();
			this.initAnimaView();
			this.initModel();
			this.addListeners();
		}
		
		public function get isDead():Boolean
		{
			return _isDead;
		}

		public function monsterAttack():void
		{
			var value:Number = Math.random();
			if(value>0.4)
				this.doattack();
			else
				this.dolandAttack()
		}
		
		public function monsterMove():void
		{
			this.dowalk();
		}
		
		public function setConfigInfo(configInfo:ObjRoleConfigInfo,name:String):void
		{
			_configInfo = configInfo;
			_maxHp = configInfo.maxHp;
			_maxMp = configInfo.maxMp;
			_currentHp = _maxHp;
			_currentMp = _maxMp;
			_name = name;
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
				_currentHp+=0.1;
				if(_currentHp>this._maxHp)
					_currentHp = this._maxHp;
				
				_currentMp+=0.05;
				if(_currentMp>this._maxMp)
					_currentMp = this._maxMp;
			}
		}
		
		override public function dispose():void
		{
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			this.removeEventListeners();
			super.dispose();	
			
			this.removeChild(_effectAnima);
			_effectAnima.dispose();
			_effectAnima = null;
			
			_heroStatusModel.unRegister(this);
			_heroStatusModel = null;
			
			_sttausInfoModel.removeEnemyInfo(_enemyInfo);
			_sttausInfoModel = null;
			
			
			_hitRange.bitmapData.dispose();
			_hurtRange.bitmapData.dispose();
			_sightRange.bitmapData.dispose();			
			_hitRange = null;
			_hurtRange = null;
			_sightRange = null;			
			
			if(_effectAnima)
			{
				while(_effectAnima.numChildren>0)
				{
					_effectAnima.removeChildAt(0,true);
				}
				_effectAnima.removeAllAnimations();			
				_effectAnima.dispose();			
				_effectAnima = null;
			}
			
			while(_manAnima.numChildren>0)
			{
				_manAnima.removeChildAt(0,true);
			}
			_manAnima.removeAllAnimations();			
			_manAnima.dispose();			
			_manAnima = null;
			
			if(_smokeAnima)
			{
				while(_smokeAnima.numChildren>0)
				{
					_smokeAnima.removeChildAt(0,true);
				}
				_smokeAnima.removeAllAnimations();
				_smokeAnima.dispose();
				_smokeAnima = null;
			}
			
		}
		
		public function updateCurrentPos(posX:Number, posY:Number):void
		{
			if(this._currentPos == null)
				_currentPos = new Point();
			_currentPos.x = posX;
			_currentPos.y = posY;
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean=false):void
		{
			if(!_isDead)
			{
				this.checkcantbreakMove();
				
				_gloabPoint = localToGlobal(new Point(this.x,this.y));
				
				
				_hurtRange.x = _gloabPoint.x+310;
				_hurtRange.y = _gloabPoint.y+250;
				
				_hitRange.x = _gloabPoint.x;
				_hitRange.y = _gloabPoint.y+220;
				_sightRange.x = _gloabPoint.x+20;
				_sightRange.y = _gloabPoint.y+250;
				
				if(_currentAnimaName == "attack")
				{
					var normalAttackInfo:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.MONST_ATTACK_MOVE_NORMAL);
					
					if(normalAttackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{	
						_attackInfo =  normalAttackInfo;
						this.checkAttackResult(_hitRange,normalAttackInfo);
						_isDingAttack = true;
					}	
					else
						_isDingAttack = false;
					
					if(_mcDic[_currentAnimaName].currentFrame == 30)			
					{	
						_effectAnima.visible = true;
						_effectAnima.changeAnimation("normalAttackEffect",false);
						_effectAnima.x = 0;
						_effectAnima.y = 70;
					}	
					
					if(_mcDic[_currentAnimaName].currentFrame == normalAttackInfo.releaseLab[1]&&normalAttackInfo.attackMoveId>0)
						this._heroStatusModel.noteShakWorld(this._faceForward,normalAttackInfo.attackMoveId,true);
				}
				
				if(_currentAnimaName == "landAttack")
				{
					var landAttackInfo:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.MONST_ATTACK_MOVE_LAND);	
					if(landAttackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						_attackInfo =  landAttackInfo;
						this.checkAttackResult(_hitRange,landAttackInfo);
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					
					if(_mcDic[_currentAnimaName].currentFrame == 44)			
					{	
						_effectAnima.visible = true;
						_effectAnima.changeAnimation("landAttackEffect",false);
						_effectAnima.x = -20;
						_effectAnima.y = 70;
					}
					
					if(_mcDic[_currentAnimaName].currentFrame == landAttackInfo.releaseLab[1]&&landAttackInfo.attackMoveId>0)
						this._heroStatusModel.noteShakWorld(this._faceForward,landAttackInfo.attackMoveId,true);
				}
				
				if(_currentAnimaName == "taunt")
				{
					var taunt:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.MONST_TAUNT);	
					if(taunt.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1 && !_isWorking)			
					{
						_isWorking = true;
						_attackInfo =  taunt;		
						if(this._currentHp + taunt.addHp<this._maxHp)
							this._currentHp += taunt.addHp;		
						
						if(this._currentMp - taunt.costMp>=0)
							this._currentMp -= taunt.costMp;
					}
					else
						_isWorking = false;
				}
			}
			
			this.noteStatus();
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
			}
		}
		
		public function get faceForward():Boolean
		{
			return _faceForward;
		}
		public function get isMoving():Boolean
		{
			return _isMoving;
		}
		
		public function checkHeroTrail(trail:Bitmap):String
		{
			_heroHurtRange = trail;
			var scensorType:String = "";			
			if(HitTest.complexHitTestObject(trail,_hitRange))
				return  SensorEnum.IN_MONSTER_ATTACK_RANGE;	
			
			if(HitTest.complexHitTestObject(trail,_sightRange))	
			{
				_sightRange.scaleX = -1.5;
				return SensorEnum.IN_MONSER_SIGHT;
			}	
	
			return scensorType;
		}
		
		
		private function initAnimaView():void
		{
			var animaName:Array = ["idel","walk","taunt","hurt","death","attack","landAttack"];
			_manAnima = new AnimationSequence(assetManager.getTextureAtlas("monster"),animaName,"idel",Const.GAME_ANIMA_FRAMERATE,false);
			_manAnima.touchable = false;
			_mcDic = _manAnima.mcSequences;
			this.addChild(_manAnima);
			
			var effectName:Array = ["normalAttackEffect","landAttackEffect"];
			_effectAnima = new AnimationSequence(assetManager.getTextureAtlas("monsterAttackEffect"),effectName,"normalAttackEffect",Const.GAME_ANIMA_FRAMERATE,false);
			_effectAnima.touchable = false;
			_effectAnima.pivotX = _effectAnima.width>>1;	
			_effectAnima.visible = false;
			this.addChild(_effectAnima);
			_mcDic = _manAnima.mcSequences;
			_hitRange = new Bitmap();
			_hitRange.bitmapData = assetManager.getBitmapForHitByName("monstHit");
			Const.collideLayer.addChild(_hitRange);
			
			_hurtRange = new Bitmap();
			_hurtRange.bitmapData = assetManager.getBitmapForHitByName("monstHurt");
			Const.collideLayer.addChild(_hurtRange);
			
			_sightRange = new Bitmap();
			_sightRange.scaleX = -1;
			_sightRange.bitmapData = assetManager.getBitmapForHitByName("basicSight");
			Const.collideLayer.addChild(_sightRange);
			this.doIdel();
		}
		
		private function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_sttausInfoModel = EnemyGuiInfoDataModel.instance;
			
			_autoRecoverCenter = AutoRecoverCenter.instance;
			_autoRecoverCenter.register(this);
		}
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
			_effectAnima.onAnimationComplete.add(effectComplete);
			
		}
		private function doIdel():void
		{
			if(_currentAnimaName != "idel")
			{
				_doAction = false;
				_manAnima.y = 0;
				_manAnima.x = OFFSET_X ;
				_manAnima.changeAnimation("idel", false);
				_currentAnimaName = "idel";
				this._isMoving = false;
			}			
		}
		
		private function dowalk():void
		{
			if(_currentAnimaName != "walk"&& !_doAction)
			{
				_doAction = false;
				_manAnima.y = 4;
				_manAnima.x = OFFSET_X;
				_manAnima.changeAnimation("walk", true);
				_currentAnimaName = "walk";
				this._isMoving = true;
			}			
		}
		
		private function dotaunt():void
		{			
			if(_currentAnimaName != "taunt"&& !_doAction)
			{
				_doAction = true;
				_manAnima.y = -13;
				_manAnima.x = -25+OFFSET_X;
				_manAnima.changeAnimation("taunt", false);
				_currentAnimaName = "taunt";
				this._isMoving = false;
			}			
		}
		
		
		private function dohurt():void
		{
			if(_currentAnimaName != "hurt")
			{
				_doAction = true;
				_manAnima.y = -50;
				_manAnima.x = OFFSET_X;
				_manAnima.changeAnimation("hurt", false);
				_currentAnimaName = "hurt";
				this._isMoving = false;
			}			
		}
		
		private function dodeath():void
		{
			if(_currentAnimaName != "death")
			{
				_isDead = true;
				_doAction = true;
				_manAnima.y = -51;
				_manAnima.x = OFFSET_X+20;
				_manAnima.changeAnimation("death", false);
				_currentAnimaName = "death";
				this._isMoving = false;		
				
				deathHandler();
				this.dispatchEventWith(EnemyEvent.ENMY_DEATH_NOTE);
				
			}			
		}	
		
		private function doattack():void
		{
			if(_currentAnimaName != "attack" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -61;
				_manAnima.x = -150 + OFFSET_X;
				_manAnima.changeAnimation("attack", false);
				_currentAnimaName = "attack";
				this._isMoving = false;
			}			
		}
		
		private function dolandAttack():void
		{
			if(_currentAnimaName != "landAttack" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -15;
				_manAnima.x = -90 + OFFSET_X;
				_manAnima.changeAnimation("landAttack", false);
				_currentAnimaName = "landAttack";
				this._isMoving = false;
			}			
		}
		
		private function animaComplete(name:String):void
		{
			_doAction = false;
			if(_currentAnimaName == "taunt" || _currentAnimaName == "landAttack")
				this.doIdel();
			if(_currentAnimaName == "attack")
			{
				if(HitTest.complexHitTestObject(_heroHurtRange,_hitRange))	
				{
					this.dolandAttack();
				}
			}
			
			if(_currentAnimaName == "hurt" ||  _currentAnimaName == "landAttack" || _currentAnimaName == "attack")
			{
				var value:Number = Math.random();
				
				var taunt:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.MONST_TAUNT);	
				if((this._currentMp - taunt.costMp) >= 0)
				{
					if((this._currentHp<this._maxHp*9/10) && this._currentHp>this._maxHp*1/3)
					{
						if(value>0.6)
							this.dotaunt();
					}
					
					if(this._currentHp<this._maxHp*1/3)
					{
						if(value>0.1)
							this.dotaunt();
					}
				}
			}
			
			if(_currentAnimaName == "death")
			{
				this._currentHp = 0;
				
				setTimeout(delayShowSmoke,800);
			}
		}
		
		
		private function delayShowSmoke():void
		{
			TweenMax.to(_manAnima,.2,{alpha:0});
			var smokeanimaName:Array = ["expsmoke"];			
			_smokeAnima = new AnimationSequence(assetManager.getTextureAtlas("scence_effect"),smokeanimaName,"expsmoke",Const.GAME_ANIMA_FRAMERATE,false);
			_smokeAnima.y = -150;
			_smokeAnima.x = 70;
			this.addChild(_smokeAnima);
			_smokeAnima.onAnimationComplete.add(smokeEffectComplete);
			
			soundExpressions.playActionSound("expsmoke",1);
			
			this._currentHp = 0;
			this.noteStatus();
		}
		private function deathHandler():void
		{
			if(_heroStatusModel)
				_heroStatusModel.unRegister(this);
			Const.collideLayer.removeChild(_hitRange);
			Const.collideLayer.removeChild(_hurtRange);
			Const.collideLayer.removeChild(_sightRange);
		}
		
		private function effectComplete(name:String):void
		{
			_effectAnima.visible = false;
		}
		
		private function smokeEffectComplete(name:String):void
		{
			this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
			this.visible = false;
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtRange,hitInfo.hitBounds))
			{					
				if(!this._canNotBeHit)
				{
					_currentHp -= hitInfo.attackHurtValue;
					if(_currentHp>=0)
						this.dohurt();
					else
						this.dodeath();
				}
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
		
		private function checkAttackResult(hitBmap:Bitmap,moveAttackConfig:ObjAttackMoveConfig):void
		{
			if(!_isDingAttack)
				_heroStatusModel.enemyHitMove(hitBmap,moveAttackConfig, this._faceForward);
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
			_enemyInfo.currentMp = this._currentMp;
			if(_currentPos&&_sttausInfoModel&&_enemyInfo)
				_enemyInfo.currentPos = new Point(_currentPos.x,_currentPos.y);
			_enemyInfo.isDead = this._currentHp<=0;
			_sttausInfoModel.updateEnemyInfo(_enemyInfo);
		}
	}
}
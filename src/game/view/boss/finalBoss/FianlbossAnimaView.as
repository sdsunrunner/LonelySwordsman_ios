package game.view.boss.finalBoss
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.dicManager.DicManager;
	import game.view.boss.finalBoss.bossEvent.BossEvent;
	import game.view.boss.finalBoss.logicModel.BossDataModel;
	import game.view.boss.finalBoss.utils.BossAiKeyMapUtil;
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SensorEnum;
	
	import utils.HitTest;
	
	import vo.ObjBossrunAway;
	import vo.ObjEnemyStatusInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.ObjfinalBossAiConfig;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 最终boss动画视图 
	 * @author admin
	 * 
	 */	
	public class FianlbossAnimaView extends BaseViewer
	{
		private var _manAnima:AnimationSequence = null;
		private var _strokesAnima:AnimationSequence = null;
		private var _strokesEffectAnima:AnimationSequence = null;
		
		private var _bodyBounds:Shape = null;
		private var _mcDic:Dictionary = null;
		
		private var _currentAnimaName:String = "";
		private var _isMoving:Boolean = false;
		private var _doAction:Boolean = false;
		
		//ai探测器
		private var _walkrange:Bitmap = null;
		private var _runRange:Bitmap = null;
		private var _auditionBitMap:Bitmap = null;
		private var _normaAttacklRange:Bitmap = null;
		private var _strokesRange:Bitmap = null;
		private var _hurtRange:Bitmap = null;
		
		
		private var _enemyInfo:ObjEnemyStatusInfo = null;
		private var _sttausInfoModel:EnemyGuiInfoDataModel = null;
		
		private var _bossDataModel:BossDataModel = null;
		//攻击招式探测器
		private var _runEndAttackBit:Bitmap = null;
		private var _attackGroupABit:Bitmap = null;
		private var _attackGroupBBit:Bitmap = null;
		private var _attackGroupCBit:Bitmap = null;
		private var _attackGroupDBit:Bitmap = null;		
		private var _heroAttackRange:Bitmap = null;
		private var _heroHurtRange:Bitmap = null;
		private var _bossStrokesAttackRange:Bitmap = null;		
		
		private var _heroStatusModel:HeroStatusModel = null;
		
		private var _faceForward:Boolean = false;	
		private var _delayFlag:Boolean = false;
		private var _gloabPoint:Point = null;
		
		private var _enemyHitInfo:ObjHitInfo = null;	
		private var  _attackInfo:ObjAttackMoveConfig = null;
		private var _currentPos:Point = null;	
		private var _configInfo:ObjRoleConfigInfo = null;
		
		private var _currentHp:Number = NaN;
		private var _currentMp:Number = NaN;
		private var _maxHp:Number = NaN;
		private var _maxMp:Number = NaN;		
		
		private var _heroPos:Point = null;
		
		private var _heroHpRatio:Number = 0;
		private var _bossAiConfigInfo:ObjfinalBossAiConfig = null;
		private var _bossMoveConfigInfo:ObjAttackMoveConfig = null;
		private var _romnum:Number = NaN;
		private var _strokesReady:Boolean = false;
		private var _canNotBeHit:Boolean = false;
	
		private var _frameCount:Number = 0;
		private var _addingHp:Boolean = false;
		private var _name:String = "";
		private var _isShowEffect:Boolean = false;
		
		private var _isDingAttack:Boolean = false;
		
		private var _isGameEnd:Boolean = false;
		
		public function FianlbossAnimaView()
		{
			super();
			this.initAnimaView();
			this.initModel();
			this.addListeners();
		}

		public function get isGameEnd():Boolean
		{
			return _isGameEnd;
		}

		public function set faceForward(value:Boolean):void
		{
			_faceForward = value;
		}

		public function get isMoving():Boolean
		{
			return _isMoving;
		}

		public function get faceForward():Boolean
		{
			return _faceForward;
		}

		public function turnAround():void
		{
			_faceForward = !_faceForward;
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
			if(_currentHp <= 0)
			{
				_isGameEnd = true;
				this.dofinalBossDeath();
			}
			if(_isGameEnd)	
				return;
			
			if(!_heroStatusModel.isDead)
			{
				this.checkcantbreakMove();
				_frameCount++;
				if(_frameCount == Const.FRAME_DELAY)				
				{
					_frameCount = 0;
					_delayFlag = true;
				}
				else
					_delayFlag = false;
				
				
				_gloabPoint = localToGlobal(new Point(this.x,this.y));
				
				_normaAttacklRange.visible = false;
				_walkrange.visible = false;
				_runRange.visible = false;
				_auditionBitMap.visible = false;
				_strokesRange.visible = false;
				_bossStrokesAttackRange.visible = true;
				if(_faceForward)
				{
					this._manAnima.scaleX = -1;
					_walkrange.x =  _gloabPoint.x+730;
					_runRange.x =  _gloabPoint.x+550;
					_normaAttacklRange.x = _gloabPoint.x+130;
					_auditionBitMap.x =  _gloabPoint.x-10;
					_strokesRange.x =  _gloabPoint.x+800;
					_hurtRange.x = _gloabPoint.x+20;
					_runEndAttackBit.x = _gloabPoint.x+120;
					_attackGroupABit.x = _gloabPoint.x+125;
					_attackGroupBBit.x = _gloabPoint.x+125;
					_attackGroupCBit.x = _gloabPoint.x+125;
					_attackGroupDBit.x = _gloabPoint.x+125;
					
					_walkrange.scaleX = -1;
					_runRange.scaleX = -1;
					_auditionBitMap.scaleX = -1;
					_normaAttacklRange.scaleX = -1;
					_strokesRange.scaleX = -1;
					_hurtRange.scaleX = -1;
					_runEndAttackBit.scaleX = -1.1;				
					_attackGroupABit.scaleX = -1.4;
					_attackGroupBBit.scaleX = -1.4;
					_attackGroupCBit.scaleX = -1.4;
					_attackGroupDBit.scaleX = -1.4;
					
					_bossStrokesAttackRange.scaleX = -1.2;
					_bossStrokesAttackRange.x = _gloabPoint.x+500;
				}
				else
				{
					this._manAnima.scaleX = 1;
					_walkrange.x =  _gloabPoint.x-730;
					_runRange.x =  _gloabPoint.x-430;
					_normaAttacklRange.x = _gloabPoint.x-40;
					_auditionBitMap.x =  _gloabPoint.x+40;
					_strokesRange.x =  _gloabPoint.x-800;
					_hurtRange.x = _gloabPoint.x+15;
					_runEndAttackBit.x = _gloabPoint.x-60;
					_attackGroupABit.x = _gloabPoint.x-60;
					_attackGroupBBit.x = _gloabPoint.x-60;
					_attackGroupCBit.x = _gloabPoint.x-60;
					_attackGroupDBit.x = _gloabPoint.x-60;
					
					_walkrange.scaleX = 1;
					_runRange.scaleX = 1;
					_auditionBitMap.scaleX = 1;
					_normaAttacklRange.scaleX = 1.1;
					_strokesRange.scaleX = 1.2;
					_hurtRange.scaleX = 1.2;
					_runEndAttackBit.scaleX = 1.2;				
					_attackGroupABit.scaleX = 1.3;
					_attackGroupBBit.scaleX = 1.3;
					_attackGroupCBit.scaleX = 1.3;
					_attackGroupDBit.scaleX = 1.3;
					_bossStrokesAttackRange.scaleX = 1.3;
					_bossStrokesAttackRange.x = _gloabPoint.x-500;
				}
				
				
				_walkrange.y = _gloabPoint.y+100;
				_runRange.y = _gloabPoint.y+100;
				_normaAttacklRange.y = _gloabPoint.y+100;
				_auditionBitMap.y = _gloabPoint.y+100;
				_strokesRange.y = _gloabPoint.y+100;
				_hurtRange.y = _gloabPoint.y+100;
				_runEndAttackBit.y = _gloabPoint.y+80;
				_attackGroupABit.y = _gloabPoint.y+100;
				_attackGroupBBit.y = _gloabPoint.y+100;
				_attackGroupCBit.y = _gloabPoint.y+100;
				_attackGroupDBit.y = _gloabPoint.y+100;
				_bossStrokesAttackRange.y = _gloabPoint.y+55;
				
				
				var bossrunAway:ObjBossrunAway = new ObjBossrunAway();
				if(_currentAnimaName == "finalBossport")
				{
					if(_mcDic[_currentAnimaName].currentFrame == 2)		
					{
						bossrunAway.heroPos = this._heroPos;
						bossrunAway.runAwayMoveType = _currentAnimaName;
						
						this.dispatchEventWith(BossEvent.BOSS_FLASH_RUN_AWAY,true,bossrunAway);
					}
				}
				
				if(_currentAnimaName == "finalBossFlashStep")
				{
					if(_mcDic[_currentAnimaName].currentFrame == 40)		
					{
						bossrunAway.heroPos = this._heroPos;
						bossrunAway.runAwayMoveType = _currentAnimaName;
						this.dispatchEventWith(BossEvent.BOSS_FLASH_RUN_AWAY,true,bossrunAway);
					}
				}
				
				//加血
				if(_currentAnimaName == "finalBosstaunt")
				{
					_attackInfo = getAttackInfoById(RoleActionEnum.BOSS_ADD_HP_MOVE);
					if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)		
					{
						_addingHp = true;
						this.addBossHp();
					}
					else
						_addingHp = false;
				}
				
				if(_currentAnimaName == "finalBossRunEndAttack")
				{
					_attackInfo = getAttackInfoById(RoleActionEnum.BOSS_RUN_END_ATTACK);
					if(_attackInfo.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						_runEndAttackBit.visible = true;
						this.checkAttackResult(_runEndAttackBit,_attackInfo);
						_isDingAttack = true;
					}
						
					else
					{
						_isDingAttack = false;
						_runEndAttackBit.visible = false;
						this.checkAttackResult(_runEndAttackBit,null);
					}
					
					
					if(_mcDic[_currentAnimaName].currentFrame == _attackInfo.releaseLab[1]&&_attackInfo.attackMoveId>0)
						this._heroStatusModel.noteShakWorld(this._faceForward,_attackInfo.attackMoveId,true);
				}
				
				if(_currentAnimaName == "finalBossAttack")
				{
					var attackInfoA:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_GROUP_ATTACK_1);
					var attackInfoB:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_GROUP_ATTACK_2);
					var attackInfoC:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_GROUP_ATTACK_3);
					var attackInfoD:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_GROUP_ATTACK_4);
					
					
					if(attackInfoA.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						_attackGroupABit.visible = true;
						this.checkAttackResult(_attackGroupABit,attackInfoA);
						
						if(_mcDic[_currentAnimaName].currentFrame == attackInfoA.releaseLab[1]&&attackInfoA.attackMoveId>0)
							this._heroStatusModel.noteShakWorld(this._faceForward,attackInfoA.attackMoveId,true);
						_isDingAttack = true;
					}			
					else
						_isDingAttack = false;
					
					if(attackInfoB.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						_attackGroupBBit.visible = true;
						this.checkAttackResult(_attackGroupBBit,attackInfoB);
						
						if(_mcDic[_currentAnimaName].currentFrame == attackInfoB.releaseLab[1]&&attackInfoB.attackMoveId>0)
							this._heroStatusModel.noteShakWorld(this._faceForward,attackInfoB.attackMoveId,true);
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					if(attackInfoC.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						_attackGroupCBit.visible = true;
						this.checkAttackResult(_attackGroupCBit,attackInfoC);
						
						if(_mcDic[_currentAnimaName].currentFrame == attackInfoC.releaseLab[1]&&attackInfoC.attackMoveId>0)
							this._heroStatusModel.noteShakWorld(this._faceForward,attackInfoC.attackMoveId,true);
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					
					if(attackInfoD.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						_attackGroupDBit.visible = true;
						this.checkAttackResult(_attackGroupDBit,attackInfoD);
						
						if(_mcDic[_currentAnimaName].currentFrame == attackInfoD.releaseLab[1]&&attackInfoD.attackMoveId>0)
							this._heroStatusModel.noteShakWorld(this._faceForward,attackInfoD.attackMoveId,true);
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
				}
				
				
				if(_currentAnimaName == "bossStrokes")
				{
					var bossStrokes_1:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_1);
					var bossStrokes_2:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_2);
					var bossStrokes_3:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_3);
					var bossStrokes_4:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_4);
					var bossStrokes_5:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_5);
					var bossStrokes_6:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_6);
					var bossStrokes_7:ObjAttackMoveConfig = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_7);
					
					
					if(bossStrokes_1.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_1);
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					
					if(bossStrokes_2.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_2);					
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					
					if(bossStrokes_3.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_3);					
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					
					if(bossStrokes_4.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_4);						
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;	
					
					
					if(bossStrokes_5.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_5);						
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
					
					
					if(bossStrokes_6.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_6);						
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;	
					
					if(bossStrokes_7.releaseLab.indexOf(_mcDic[_currentAnimaName].currentFrame)>-1)			
					{
						this.checkAttackResult(_bossStrokesAttackRange,bossStrokes_7);						
						_isDingAttack = true;
					}
					else
						_isDingAttack = false;
				}
			}			
			else
				this.dofianlBossIdel();
			
			this.noteStatus();
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				if(_currentAnimaName == "finalBossAttack")
				{
					if(_mcDic[_currentAnimaName].currentFrame <5 )
					{
						soundExpressions.playActionSound("finalBossAttack",_mcDic[_currentAnimaName].currentFrame);
					}
					if(_mcDic[_currentAnimaName].currentFrame >30 )
					{
						soundExpressions.playActionSound("finalBossAttack_1",_mcDic[_currentAnimaName].currentFrame);
					}
					
					if(_mcDic[_currentAnimaName].currentFrame <19 &&_mcDic[_currentAnimaName].currentFrame >5)
					{
						soundExpressions.playActionSound("finalBossAttack_2",_mcDic[_currentAnimaName].currentFrame);
					}
					
					
					if(_mcDic[_currentAnimaName].currentFrame >19 &&_mcDic[_currentAnimaName].currentFrame <30)
					{
						soundExpressions.playActionSound("finalBossAttack_3",_mcDic[_currentAnimaName].currentFrame);
					}
				}
				
				else if(_currentAnimaName == "finalBossFlashStep")
				{
					if(_mcDic[_currentAnimaName].currentFrame >40)
					{
						soundExpressions.playActionSound("finalBossFlashStep_1",_mcDic[_currentAnimaName].currentFrame);
					}
					else
						soundExpressions.playActionSound("finalBossFlashStep",_mcDic[_currentAnimaName].currentFrame);
				}
				else
					soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
				
			}
		}
		
		override public function dispose():void
		{	
			while(_manAnima.numChildren>0)
			{
				_manAnima.removeChildAt(0,true);
			}
			_manAnima.removeAllAnimations();			
			_manAnima.dispose();			
			_manAnima = null;
			
			_heroStatusModel.unRegister(this);
			_heroStatusModel = null;
			
			_sttausInfoModel.removeEnemyInfo(_enemyInfo);
			_sttausInfoModel = null;
			
			Const.collideLayer.removeChild(_runEndAttackBit);
			Const.collideLayer.removeChild(_attackGroupABit);
			Const.collideLayer.removeChild(_attackGroupBBit);
			Const.collideLayer.removeChild(_attackGroupCBit);
			Const.collideLayer.removeChild(_attackGroupDBit);
			Const.collideLayer.removeChild(_bossStrokesAttackRange);
			_runEndAttackBit.bitmapData.dispose();
			_runEndAttackBit = null;
			_attackGroupABit.bitmapData.dispose();
			_attackGroupABit = null;
			_attackGroupBBit.bitmapData.dispose();
			_attackGroupBBit = null;
			
			_attackGroupCBit.bitmapData.dispose();
			_attackGroupCBit = null;
			_attackGroupDBit.bitmapData.dispose();
			_attackGroupDBit = null;
			_bossStrokesAttackRange.bitmapData.dispose();
			_bossStrokesAttackRange = null;
			if(_manAnima)
				_manAnima.dispose();
			_manAnima = null;
			_mcDic = null;
			_currentAnimaName = "";
			if(_walkrange)
				_walkrange.bitmapData.dispose();
			_walkrange = null;
			_runRange.bitmapData.dispose();
			_runRange = null;
			if(_auditionBitMap)
				_auditionBitMap.bitmapData.dispose();
			_auditionBitMap = null;
			if(_normaAttacklRange)
				_normaAttacklRange.bitmapData.dispose();
			_normaAttacklRange = null;
			if(_strokesRange)
				_strokesRange.bitmapData.dispose();
			_strokesRange = null;
			
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(this._currentHp>0)
			{
				if(msgName == MsgTypeEnum.HERO_ATTACK)
				{
					_enemyHitInfo = data as ObjHitInfo;
					if(_enemyHitInfo.attackHurtValue == 0)
						_enemyHitInfo = null;
					if(_enemyHitInfo)
						this.checkEnemyAttact(_enemyHitInfo);
				}
				
				
				if(msgName == MsgTypeEnum.HERO_POS_UPDATE)
				{
					_heroPos = data as Point;				
				}
				
				if(msgName == MsgTypeEnum.HERO_ATTACKRANGE_UPDATE)
					this._heroAttackRange = data as Bitmap;
				
				if(msgName == MsgTypeEnum.AVOID_HERO_ATTACK)
				{
					checkBossAvoidRunAway();
				}
				
				if(msgName == MsgTypeEnum.HERO_HP_UPDATE)
				{
					var heroHpRatioValue:Number = data as Number;
					_heroHpRatio = Math.floor(heroHpRatioValue*100);
				}
				
				if(msgName == MsgTypeEnum.BOSS_HP_RECOVER && this._currentHp>0)
				{
					this._currentHp	+= data as Number;
					if(this._currentHp > this._maxHp)
						this._currentHp = this._maxHp;
				}
				
				if(msgName == MsgTypeEnum.BOSS_MP_RECOVER && this._currentHp>0)
				{
					this._currentMp	+= data as Number;
					if(this._currentMp > this._maxMp)
						this._currentMp = this._maxMp;
				}
			}
		}
		
		public function setConfigInfo(configInfo:ObjRoleConfigInfo,name:String):void
		{
			_configInfo = configInfo;
//			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS)
//			{
//				this._maxHp = configInfo.maxHp-50;
//				_currentHp = configInfo.maxHp-50;
//			}
//			
//			else
//			{
				this._maxHp = configInfo.maxHp;
				_currentHp = configInfo.maxHp;
//			}
			
			this._maxMp = configInfo.maxMp;
			this._currentMp = configInfo.maxMp;
			
			_name = name;
		}
		
		public function checkHeroTrail(trail:Bitmap):String
		{
			_heroHurtRange = trail;
			var scensorType:String = "";
			if(HitTest.complexHitTestObject(trail,_auditionBitMap) && _delayFlag)
				scensorType = SensorEnum.AUDITION;
		
			if(HitTest.complexHitTestObject(trail,_walkrange))			
				scensorType =  SensorEnum.BOSS_WALKER_RANGE;			
			
			if(HitTest.complexHitTestObject(trail,_runRange))			
				scensorType =  SensorEnum.BOSS_RUN_RANGE;
			
			if(HitTest.complexHitTestObject(trail,_normaAttacklRange))			
				scensorType =  SensorEnum.BOSS_NORMAL_ATTACK_RANGE;	
			
			return scensorType;
		}
		
		public function startWalk():void
		{
			if(!this._isMoving)
				this.dofinalBossWalkStart();
		}
		
		public function idelStatus():void
		{
			if(this._isMoving && !_doAction)
				this.dofianlBossIdel();
		}
		
		public function startRun():void
		{
			if(!_doAction)
				this.dofinalBossRunLoop();
		}
		
		public function startAttack():void
		{
			if(!_doAction)				
			{
				if(_currentAnimaName == "finalBossRunLoop")
					this.dofinalBossRunEndAttack();
				else
					this.dofinalBossAttack();
			}
		}
			
		private function initAnimaView():void
		{
			_bodyBounds = new Shape();
			this.addChild(_bodyBounds);
			
			var animaName:Array = ["fianlBossIdel","finalBossAttack","finalBossDeath","finalBossFlashStep","finalBossHurt","finalBossport","finalBossRunEndAttack","finalBossRunLoop","bossStrokes","finalBossStrokesStart","finalBosstaunt","finalBossWalkLoop","finalBossWalkStart"];
			_manAnima = new AnimationSequence(assetManager.getTextureAtlas("finalBoss"),animaName,"fianlBossIdel",Const.GAME_ANIMA_FRAMERATE,false);
			_manAnima.touchable = false;
			_manAnima.pivotX = _manAnima.width/2;
			_mcDic = _manAnima.mcSequences;
			_bodyBounds.addChild(_manAnima);
			this.dofianlBossIdel();				
			this.initRoleSensor();
		}
		
		private function initModel():void
		{
			_sttausInfoModel = EnemyGuiInfoDataModel.instance;
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_bossDataModel = BossDataModel.instance;
			_bossDataModel.register(this);
		}
		
		private function initRoleSensor():void
		{
			 _walkrange = new Bitmap();
			 _walkrange.bitmapData = assetManager.getBitmapForHitByName("bossWalkRange");
			Const.collideLayer.addChild(_walkrange);
			
			_runRange = new Bitmap();
			_runRange.bitmapData = assetManager.getBitmapForHitByName("bossRunRange");
			Const.collideLayer.addChild(_runRange);
			
			_auditionBitMap = new Bitmap();
			_auditionBitMap.bitmapData = assetManager.getBitmapForHitByName("bossHearRange");
			Const.collideLayer.addChild(_auditionBitMap);
			
			_normaAttacklRange = new Bitmap();
			_normaAttacklRange.bitmapData = assetManager.getBitmapForHitByName("bossNormalAttackRange");
			Const.collideLayer.addChild(_normaAttacklRange);
			
			
			_strokesRange = new Bitmap();
			_strokesRange.bitmapData = assetManager.getBitmapForHitByName("bossStrokesAttackRange");
			Const.collideLayer.addChild(_strokesRange);
			
			_hurtRange = new Bitmap();
			_hurtRange.bitmapData = assetManager.getBitmapForHitByName("bossHurtRange");
			Const.collideLayer.addChild(_hurtRange);
			
			_runEndAttackBit = new Bitmap();
			_runEndAttackBit.bitmapData = assetManager.getBitmapForHitByName("bossRunEndArrack");
			
			_attackGroupABit = new Bitmap();
			_attackGroupABit.bitmapData = assetManager.getBitmapForHitByName("bossAttackGoupA");
			_attackGroupBBit = new Bitmap();
			_attackGroupBBit.bitmapData = assetManager.getBitmapForHitByName("bossAttackGroupB");
			_attackGroupCBit = new Bitmap();
			_attackGroupCBit.bitmapData = assetManager.getBitmapForHitByName("bossAttackgroupC");
			_attackGroupDBit = new Bitmap();
			_attackGroupDBit.bitmapData = assetManager.getBitmapForHitByName("bossAttackGroupD");
			
			_bossStrokesAttackRange = new Bitmap();
			_bossStrokesAttackRange.bitmapData = assetManager.getBitmapForHitByName("strokesHit");
			
			_runEndAttackBit.visible = false;
			Const.collideLayer.addChild(_runEndAttackBit);
			Const.collideLayer.addChild(_attackGroupABit);
			Const.collideLayer.addChild(_attackGroupBBit);
			Const.collideLayer.addChild(_attackGroupCBit);
			Const.collideLayer.addChild(_attackGroupDBit);
			Const.collideLayer.addChild(_bossStrokesAttackRange);
		}
		
		private function dofianlBossIdel():void
		{
			if(_currentAnimaName != "fianlBossIdel")
			{
				_doAction = false;
				_manAnima.y = -1;
				_manAnima.x = 0;
				_manAnima.changeAnimation("fianlBossIdel", true);
				_currentAnimaName = "fianlBossIdel";
				this._isMoving = false;
			}
		}
		
		private function dofinalBossWalkLoop():void
		{
			if(_currentAnimaName != "finalBossWalkLoop" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = 0;
				_manAnima.x = -3;
				_manAnima.changeAnimation("finalBossWalkLoop", true);
				_currentAnimaName = "finalBossWalkLoop";
				this._isMoving = true;
			}
		}
		
		/**
		 * 嘲笑/加血 
		 * 
		 */		
		private function dofinalBosstaunt():void
		{
			if(_currentAnimaName != "finalBosstaunt" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -60;
				if(this._faceForward)
					_manAnima.x = 190;
				else
					_manAnima.x = -190;
				trace("from :" + _currentAnimaName);
				trace("_faceForward :" + _faceForward);
				
				_manAnima.changeAnimation("finalBosstaunt", false);
				_currentAnimaName = "finalBosstaunt";
				this._isMoving = false;
				_attackInfo = this.getAttackInfoById(RoleActionEnum.BOSS_ADD_HP_MOVE);
				this.consumeMp();
			}
		}
		
		private function dofinalBossAttack():void
		{
			if(_currentAnimaName != "finalBossAttack" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = 0;
				if(this._faceForward)
					_manAnima.x = 50;
				else
					_manAnima.x = -27;
				_manAnima.changeAnimation("finalBossAttack", true);
				_currentAnimaName = "finalBossAttack";
				this._isMoving = false;
			}
		}
		
		
		private function dofinalBossDeath():void
		{
			if(_currentAnimaName != "finalBossDeath")
			{
				_doAction = true;
				_manAnima.y = 10;
				_manAnima.x = 0;
				_manAnima.changeAnimation("finalBossDeath", false);
				_currentAnimaName = "finalBossDeath";
				this._isMoving = false;
				this.dispatchEventWith(EnemyEvent.ENMY_DEATH_NOTE);
				
				_heroStatusModel.unRegister(this);
				_bossDataModel.unRegister(this);
			}
		}
		
		private function dofinalBossFlashStep():void
		{
			if(_currentAnimaName != "finalBossFlashStep" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -48;
				_manAnima.x = 0;
				_manAnima.changeAnimation("finalBossFlashStep", false);
				_currentAnimaName = "finalBossFlashStep";
				this._isMoving = false;
				
				_attackInfo = this.getAttackInfoById(RoleActionEnum.BOSS_FLAH_STEP_MOVE);
				this.consumeMp();
			}
		}
		
		private function dofinalBossHurt():void
		{
			if(_currentAnimaName != "finalBossHurt" && this._currentHp>=0)
			{				
				_doAction = true;
				_manAnima.y = 0;
				_manAnima.x = 15;
				_manAnima.changeAnimation("finalBossHurt", false);
				_currentAnimaName = "finalBossHurt";
				this._isMoving = false;
			}
		}
		
		private function dofinalBossport():void
		{
			if(_currentAnimaName != "finalBossport" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -73;
				_manAnima.x = 0;
				_manAnima.changeAnimation("finalBossport", true);
				_currentAnimaName = "finalBossport";
				this._isMoving = false;
				_attackInfo = this.getAttackInfoById(RoleActionEnum.BOSS_FLAH_STEP_MOVE);
				this.consumeMp();
			}
		}
		
		
		private function dofinalBossRunEndAttack():void
		{
			if(_currentAnimaName != "finalBossRunEndAttack" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -18;
				if(this._faceForward)
					_manAnima.x = 50;
				else
					_manAnima.x = -35;
				_manAnima.changeAnimation("finalBossRunEndAttack", false);
				_currentAnimaName = "finalBossRunEndAttack";
				this._isMoving = false;
			}
		}
		
		private function dofinalBossRunLoop():void
		{
			if(_currentAnimaName != "finalBossRunLoop" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = 10;
				_manAnima.x = 0;
				_manAnima.changeAnimation("finalBossRunLoop", true);
				_currentAnimaName = "finalBossRunLoop";
				this._isMoving = true;
			}
		}
		
		
		private function dobossStrokes():void
		{
			if(_currentAnimaName != "bossStrokes" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = 0;
				_manAnima.x = -5;
				_manAnima.changeAnimation("bossStrokes", false);
				_currentAnimaName = "bossStrokes";
				this._isMoving = false;
				this.addStrokesStartEffect();
				this.addStrokesEffect();
			}
		}
		
		private function dofinalBossStrokesStart():void
		{
			if(_currentAnimaName != "finalBossStrokesStart" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -65;
				
				if(this._faceForward)
					_manAnima.x = 20;
				else
					_manAnima.x = -20;
				
				_manAnima.changeAnimation("finalBossStrokesStart", false);
				_currentAnimaName = "finalBossStrokesStart";
				this._isMoving = false;
				_attackInfo = this.getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_READY);
				this.consumeMp();
			}
		}		
		
		private function dofinalBossWalkStart():void
		{
			if(_currentAnimaName != "finalBossWalkStart" && !_doAction)
			{
				_doAction = true;
				_manAnima.y = -1;
				_manAnima.x = 0;
				_manAnima.changeAnimation("finalBossWalkStart", false);
				_currentAnimaName = "finalBossWalkStart";
				this._isMoving = true;
			}
		}
		
		private function addStrokesStartEffect():void
		{
			if(!_isShowEffect)
			{
				var animaName:Array = ["dazhaoReady"];
				_strokesAnima = new AnimationSequence(assetManager.getTextureAtlas("finalBossEffect"),animaName,"dazhaoReady",Const.GAME_ANIMA_FRAMERATE,false);
				this.addChild(_strokesAnima);
				if(!this._faceForward)
				{
					_strokesAnima.x = -100;
					_strokesAnima.scaleX = 1;
				}
				else
				{
					_strokesAnima.x = 100;
					_strokesAnima.scaleX = -1;
				}
				_strokesAnima.y = -150;
				_strokesAnima.onAnimationComplete.add(effectAnimaComplete);
			}
		}
		
		
		private function addStrokesEffect():void
		{
			if(!_isShowEffect)
			{
				var animaName:Array = ["dazhaoEffect"];
				_strokesEffectAnima = new AnimationSequence(assetManager.getTextureAtlas("bossFinaAttack"),animaName,"dazhaoEffect",Const.GAME_ANIMA_FRAMERATE,false);
				_strokesEffectAnima.pivotX = _strokesEffectAnima.width>>1;
				
				this.addChild(_strokesEffectAnima);
				_isShowEffect = true;
				if(!this._faceForward)
				{
					_strokesEffectAnima.x = -350;	
					_strokesEffectAnima.scaleX = 1.5;
				}
				else
				{
					_strokesEffectAnima.x = 350;	
					_strokesEffectAnima.scaleX = -1.5;
				
				}
				_strokesEffectAnima.y = -300;
				_strokesEffectAnima.scaleY = 1.5;
				
				_strokesEffectAnima.onAnimationComplete.add(strokesEffectAnimaComplete);
			}
		}
		
		private function addListeners():void
		{
			_manAnima.onAnimationComplete.add(animaComplete);
		}
		
		private function effectAnimaComplete(name:String):void
		{
			this.removeChild(_strokesAnima);
			_strokesAnima.removeAllAnimations();
			_strokesAnima = null;
			
		}
		
		private function strokesEffectAnimaComplete(name:String):void
		{
			_isShowEffect = false;
			this.removeChild(_strokesEffectAnima);
			_strokesEffectAnima.removeAllAnimations();
			_strokesEffectAnima = null;
		}
		
		
		private function animaComplete(name:String):void
		{
			_doAction = false;
			if(_heroStatusModel.isDead)
			{
				this.dofianlBossIdel();
			}
			else
			{
				//不受受ai影响
				if(this._currentAnimaName == "finalBossDeath" )	
				{
					_heroStatusModel.unRegister(this);
					setTimeout(gameEndhandler,3000);
				}
				else if(!_isGameEnd)
				{
					if(this._currentAnimaName == "finalBossWalkStart")			
						this.dofinalBossWalkLoop();
					if(this._currentAnimaName == "bossStrokes")			
						_strokesReady = false;
					
					if(this._currentAnimaName == "finalBossStrokesStart")			
						this.dobossStrokes();
					
					if(this._currentAnimaName == "finalBossWalkStart")	
					{
						if(this._strokesReady)
							finalBossStrokes();
						else if(HitTest.complexHitTestObject(this._heroHurtRange,_walkrange))	
							this.dofinalBossWalkLoop();
					}
					if(this._currentAnimaName == "finalBossHurt")
					{
						if(this._currentHp>0)
							this.bossDoAttackCompleteAijudge();
						else
							this.dofinalBossDeath();
					}
					
					//受ai影响
					if(this._currentAnimaName == "finalBossAttack"
						
						||this._currentAnimaName == "finalBossRunEndAttack"
					)
					{
						this.bossDoAttackCompleteAijudge();
					}			
					//受ai影响
					if(this._currentAnimaName == "finalBossFlashStep"
						||this._currentAnimaName == "finalBossport"				
					)
					{
						this.bossDoRunAwayCompleteAijudge();
					}
				}
			}
		}
		
		/**
		 * boss攻击动作结束ai判定 
		 * 
		 */		
		private function bossDoAttackCompleteAijudge():void
		{
			_bossAiConfigInfo = this.getFianleBossAiConfig();
			if(_bossAiConfigInfo)
			{
				var avoidProba:Number = _bossAiConfigInfo.avoidProba;
				_romnum = Math.random();			
				if(_romnum < avoidProba)
					this.finalBossDoRunAway();
				else
					this.dofinalBossAttack();
			}
		}
		
		/**
		 * 不能被打断招数 
		 * 
		 */		
		private function checkcantbreakMove():void
		{
			if(!_heroStatusModel.isDead)
			{
				if(_attackInfo)
				{
					if(_attackInfo.unconquerableLabMin>0)
					{
						if(_mcDic[_currentAnimaName].currentFrame >= _attackInfo.unconquerableLabMin
							&&_mcDic[_currentAnimaName].currentFrame<_attackInfo.unconquerableLabMax)
							this._canNotBeHit = true;
						else
							this._canNotBeHit = false;
					}
					else
						this._canNotBeHit = false;
				}
			}
			else
				this._canNotBeHit = false;
		}
		
		/**
		 * boss闪避结束ai判定 
		 * 
		 */		
		private function bossDoRunAwayCompleteAijudge():void
		{
			_bossAiConfigInfo = this.getFianleBossAiConfig();
			var addHpProba:Number = _bossAiConfigInfo.addHpMoveProba;
			_romnum = Math.random();
			if(_romnum < addHpProba)
				this.dofinalBosstaunt();
			else
				this.finalBossStrokes();
		}
		
		/**
		 * boss躲避攻击ai判定 
		 * 
		 */		
		private function bossAvoidAttackAijudge():void
		{
			_bossAiConfigInfo = this.getFianleBossAiConfig();
			var roundNum:Number = Math.random();
			if(roundNum<_bossAiConfigInfo.avoidProba)
				dofinalBossport();
		}
		
		/**
		 * boss放大招 
		 * 
		 */		
		private function finalBossStrokes():void
		{
			this._attackInfo = getAttackInfoById(RoleActionEnum.BOSS_STROKES_ATTACK_READY);				
			if(this._currentMp - this._attackInfo.costMp >= 0)
			{
				this.dofinalBossStrokesStart();
			}
			else
				this.dofianlBossIdel();
		}
		
		
		/**
		 * 检查英雄躲避攻击 
		 * 
		 */		
		private function checkBossAvoidRunAway():void
		{
			if(HitTest.complexHitTestObject(_hurtRange,_heroAttackRange))
			{
				this.bossAvoidAttackAijudge();
			}		
		}
		
		private function finalBossDoRunAway():void
		{
			var randomNum:Number = Math.random();
			if(randomNum>0.6)
				dofinalBossFlashStep();
			else
				this.dofinalBossport();	
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(HitTest.complexHitTestObject(_hurtRange,hitInfo.hitBounds))
			{					
				if(!this._canNotBeHit)
				{
					_currentHp -= hitInfo.attackHurtValue;
					this.dofinalBossHurt();
				}
			}
		}
		
		/**
		 * 魔法消耗 
		 * @param moveId
		 * 
		 */		
		private function consumeMp():void
		{
			this._currentMp	-= _attackInfo.costMp;
			if(this._currentMp<0)
				this._currentMp = 0;
		}
		
		/**
		 * 回血 
		 * 
		 */		
		private function addBossHp():void			
		{
			if(_addingHp)
			{
				_addingHp = false;
				this._currentHp	+= _attackInfo.addHp;
				if(this._currentHp>this._maxHp)
					this._currentHp = this._maxHp;
			}
		}
		
		
		private function checkAttackResult(hitBmap:Bitmap,moveAttackConfig:ObjAttackMoveConfig):void
		{
			if(!_isDingAttack)
				_heroStatusModel.enemyHitMove(hitBmap,moveAttackConfig, this._faceForward);
			
			if(moveAttackConfig&&moveAttackConfig.costMp>0)
				this.consumeMp();
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
		 * 获取最终boss Ai配置信息  
		 * @return 
		 * 
		 */		
		private function getFianleBossAiConfig():ObjfinalBossAiConfig
		{
			if(_heroHpRatio==0)
				_heroHpRatio = this._heroStatusModel.getHeroHpRatio();
			var bossMpKey:String = BossAiKeyMapUtil.getbossMpKey(_currentMp/this._maxMp);
			var bossHpKey:String = BossAiKeyMapUtil.getbossHpKey(_currentHp/this._maxHp);
			var heroHpKey:String = BossAiKeyMapUtil.getHeroHpKey(this._heroHpRatio);
		
			return DicManager.instance.getfinalBossAiConfigInfo(bossMpKey,bossHpKey,heroHpKey);
		}
		
		private function gameEndhandler():void
		{
			this._currentAnimaName = "";		
			_heroStatusModel.unRegister(this);
			this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE,true,this._currentHp);
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
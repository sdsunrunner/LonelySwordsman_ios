package game.view.models
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import enum.GameRoleEnum;
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	import game.manager.dicManager.DicManager;
	
	import vo.ObjShakWorldInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 英雄状态 数据模型  
	 * @author admin
	 * 
	 */	
	public class HeroStatusModel extends MessageCenter 
	{
		private static var _instance:HeroStatusModel = null;
		
		private var _heroPos:Point = new Point();
		private var _heroMaxHp:Number = -100;		
		private var _heroCurrentHp:Number = -100;
		
		private var _heroMaxMp:Number = -100;		
		private var _heroCurrentMp:Number = -100;
		
		private var _dicManager:DicManager = null;
		private var _isDead:Boolean = false;
		
		private var _heroLifeCount:Number = 0;
		
		public function HeroStatusModel(code:$)
		{
			_dicManager = DicManager.instance;
			super();
		}
		
		public function get heroLifeCount():Number
		{
			if(_heroLifeCount<0)
				_heroLifeCount = 0;
			return _heroLifeCount;
		}

		public function heroReborn():void
		{
//			this.heroLifeCount = this._heroLifeCount-1;
		}
		
		public function set heroLifeCount(value:Number):void
		{
			if( value < 0 )
				value = 0;
			_heroLifeCount = value;
			this.msgName =  MsgTypeEnum.HERO_LIFE_COUNT_UPDATE;
			this.msg = _heroLifeCount;
			this.notify();		
		}

		public function set heroCurrentHp(value:Number):void
		{
			_heroCurrentHp = value;
			if(_heroCurrentHp <= 0)
				this._isDead = true;
			this.msgName =  MsgTypeEnum.HERO_HP_UPDATE;
			this.msg = _heroCurrentHp/this._heroMaxHp;
			this.notify();
		}

		public function set heroCurrentMp(value:Number):void
		{
			_heroCurrentMp = value;
			this.msgName =  MsgTypeEnum.HERO_MP_UPDATE;
			this.msg = _heroCurrentMp/this._heroMaxMp;
			this.notify();
		}

		public function get heroCurrentMp():Number
		{
			return _heroCurrentMp;
		}

		public function get heroCurrentHp():Number
		{
			return _heroCurrentHp;
		}

		/**
		 * 对决模式和生存模式英雄状态加满 
		 * 
		 */		
		public function setHeroStatusFull():void
		{
			var heroConfigInfo:ObjRoleConfigInfo = this.getBaseHeroConfigInfo();
			
			_isDead = false;
			this._heroCurrentHp = heroConfigInfo.maxHp;
			this._heroCurrentMp = heroConfigInfo.maxMp;
			
			this.msgName =  MsgTypeEnum.HERO_HP_ADD_UPDATE;
			this.msg = _heroCurrentHp/this._heroMaxHp;
			this.notify();	
			
			this.msgName =  MsgTypeEnum.HERO_MP_UPDATE;
			this.msg = _heroCurrentMp/this._heroMaxMp;
			this.notify();	
		}

		public function addHp(value:Number):void
		{
			this._heroCurrentHp += value;
			if(this._heroCurrentHp >= _heroMaxHp)
				this._heroCurrentHp = _heroMaxHp;
			
			this.msgName =  MsgTypeEnum.HERO_HP_ADD_UPDATE;
			this.msg = _heroCurrentHp/this._heroMaxHp;
			this.notify();			
		}
		
		public function addMp(value:Number):void
		{			
			this._heroCurrentMp += value;
			if(this._heroCurrentMp >= _heroMaxMp)
				this._heroCurrentMp = _heroMaxMp;
			
			this.msgName =  MsgTypeEnum.HERO_MP_UPDATE;
			this.msg = _heroCurrentMp/this._heroMaxMp;
			this.notify();
		}
		
		public function setHeroMaxHp(heroHp:Number):void
		{
			if(_heroMaxHp == -100)
			{
				_heroMaxHp = heroHp;
				_heroCurrentHp = _heroMaxHp;
			}
		}
		
		public function setHeroMaxMp(heroMp:Number):void
		{
			if(_heroMaxMp == -100)
			{
				_heroMaxMp = heroMp;
				_heroCurrentMp = heroMp;
			}
		}
		
		public function gameEndResetGameLev():void
		{
			_heroCurrentMp += 10;
			if(_heroCurrentMp >= _heroMaxMp)
				_heroCurrentMp = _heroMaxMp;
			
			_heroCurrentHp = _heroMaxHp;
			
			this.msgName =  MsgTypeEnum.HERO_HP_UPDATE;
			this.msg = _heroCurrentHp/this._heroMaxHp;
			this.notify();
		}
		
		/**
		 *  
		 * @param willCost
		 * @return 
		 * 
		 */		
		public function checkHeroCanUseMagicAttack(attackMoveId:Number):Boolean
		{
			var moveInfo:ObjAttackMoveConfig = this.getAttackInfoById(attackMoveId);
			if(moveInfo)
				return (_heroCurrentMp-moveInfo.costMp) >= 0;
			return false;
		}
		
		
		public function get isDead():Boolean
		{
			return _heroCurrentHp <= 0;
		}

		public function getHeroHpRatio():Number
		{
			return this._heroCurrentHp/_heroMaxHp;
		}
		
		public static function get instance():HeroStatusModel
		{
			return _instance ||= new HeroStatusModel(new $);
		}
		
		public function checkCanUseHpPro():Boolean
		{
			return this._heroCurrentHp < this._heroMaxHp-10 ;
		}
		
		public function checkCanUseMHpPro():Boolean
		{
			return this._heroCurrentMp < this._heroMaxMp-10 ;
		}
		
		/**
		 * 攻击按钮tap 
		 * 
		 */		
		public function noteMoveBtnTap(actionType:String):void
		{
			this.msgName = actionType;
			this.notify();
		}
		
		/**
		 * 英雄攻击预备（敌人有几率躲避） 
		 * @param moviId
		 * 
		 */		
		public function noteHeroAtack(moviId:Number):void
		{
			this.msgName = MsgTypeEnum.AVOID_HERO_ATTACK;
			this.msg = moviId;
			this.notify();
		}
		
		/**
		 * 更新英雄坐标信息 
		 * @param pox
		 * @param poy
		 * 
		 */		
		public function noteHeroPosUpdate(pox:Number, poy:Number):void
		{
			_heroPos.x = pox;
			_heroPos.y = poy;
			this.msgName = MsgTypeEnum.HERO_POS_UPDATE;
			this.msg = _heroPos;
			
			this.notify();
		}
		
		/**
		 * 英雄是否在爬梯子 
		 * @param isClimb
		 * 
		 */		
		public function noteHeroIsclimb(isClimb:Boolean):void
		{
			this.msgName = MsgTypeEnum.HERO_IS_CLIMB;
			this.msg = isClimb;
			
			this.notify();
		}
		
		/**
		 * 震动 
		 * @param faceForward
		 * @param attackMoveId
		 * 
		 */		
		public function noteShakWorld(faceForward:Boolean, attackMoveId:Number,isHit:Boolean = false):void
		{
			var shakWorldInfo:ObjShakWorldInfo = new ObjShakWorldInfo();
			shakWorldInfo.faceForward = faceForward;
			shakWorldInfo.attackMoveId = attackMoveId;
			shakWorldInfo.isHit = isHit;
			this.msgName = MsgTypeEnum.SHAK_WORLD;
			this.msg = shakWorldInfo;
			
			this.notify();
		}
		
		
		/**
		 * 广播英雄攻击范围 
		 * @param attackRange
		 * 
		 */		
		public function noteHeroAttackRange(attackRange:Bitmap):void
		{
			this.msgName = MsgTypeEnum.HERO_ATTACKRANGE_UPDATE;
			this.msg = attackRange;
			
			this.notify();
		}
		
		/**
		 * 告知英雄踪迹 
		 * @param heroTrailBmp
		 * 
		 */		
		public function noteHeroTrail(heroTrailBmp:Bitmap):void
		{
			this.msgName = MsgTypeEnum.HERO_TRAIL_UPDATE;
			this.msg = heroTrailBmp;
			this.notify();
		}
		
		/**
		 * 敌人攻击检测 
		 * @param hitBounds
		 * @param attackMoveId
		 * 
		 */		
		public function enemyHitMove(hitBounds:Bitmap, moveAttackConfig:ObjAttackMoveConfig, faceForward:Boolean):void
		{
			if(moveAttackConfig)
			{
				this.msgName = MsgTypeEnum.HERO_ENEMY_ATTACK_HIT;
				
				var hitInfo:ObjHitInfo = new ObjHitInfo();
				hitInfo.hitBounds = hitBounds;				
				hitInfo.attackMoveId = moveAttackConfig.attackMoveId;
				hitInfo.targetBeenHitMove = moveAttackConfig.targetPosMove;
				hitInfo.attackHurtValue = moveAttackConfig.hitValue;
				hitInfo.faceForward = faceForward;
				if(hitInfo.attackHurtValue>0)
				{
					this.msg = hitInfo;
					this.notify();
				}
				
				
			}			
		}
		
		/**
		 * 英雄受伤消息  
		 * @param hurtValue
		 * 
		 */		
		public function heroHurt(hurtValue:Number):void
		{
			_heroCurrentHp -= hurtValue;
			if(_heroMaxHp <= 0)
				this._isDead = true;
			this.msgName =  MsgTypeEnum.HERO_HP_UPDATE;
			this.msg = _heroCurrentHp/this._heroMaxHp;
			this.notify();
		}
		
		/**
		 * 英雄消耗mp 
		 * @param costValue
		 * 
		 */		
		public function heroMpUpdate(costValue:Number):void
		{
			_heroCurrentMp -= costValue;
			this.msgName =  MsgTypeEnum.HERO_MP_UPDATE;
			this.msg = _heroCurrentMp/this._heroMaxMp;
			this.notify();
		}
		
		
		/**
		 * 英雄攻击  
		 * @param moveId
		 * @param attackRange
		 * 
		 */		
		public function heroAttack(attackRange:Bitmap,attackInfo:ObjAttackMoveConfig, faceForward:Boolean):void
		{
			var hitInfo:ObjHitInfo = new ObjHitInfo();
			hitInfo.hitBounds = attackRange;
			hitInfo.faceForward = faceForward;
			if(attackInfo)
			{
				hitInfo.targetBeenHitMove = attackInfo.targetPosMove;
				hitInfo.targetBeenHitMoveY = attackInfo.targetPosMoveY;
				hitInfo.attackHurtValue = attackInfo.hitValue;
			}	
			else
			{
				hitInfo.attackHurtValue = 0;
				hitInfo.attackHurtValue = 0;
			}		
			hitInfo.faceForward = faceForward;
			hitInfo.attackMoveId = attackInfo.attackMoveId;
			this.msgName =  MsgTypeEnum.HERO_ATTACK;
			this.msg = hitInfo;
			this.notify();
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
		
		private function getBaseHeroConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.BASE_HERO_CONFIG_ID);
		}
	}
}

class ${}
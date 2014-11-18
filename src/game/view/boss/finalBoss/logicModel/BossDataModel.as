package game.view.boss.finalBoss.logicModel
{
	import flash.display.Bitmap;
	
	import enum.MsgTypeEnum;
	
	import frame.view.IObserver;
	import frame.view.viewModel.MessageCenter;
	
	import game.dataProxy.AutoRecoverCenter;
	
	import vo.attackInfo.ObjAttackMoveConfig;
	import vo.attackInfo.ObjHitInfo;
	
	/**
	 * 最终boss数据模型 
	 * @author admin
	 * 
	 */	
	public class BossDataModel extends MessageCenter implements IObserver
	{
		private static var _instance:BossDataModel = null;
		
		private var _autoRecover:AutoRecoverCenter = null;
		
		public function BossDataModel(code:$)
		{
			super();
			
			_autoRecover = AutoRecoverCenter.instance;
			_autoRecover.register(this);
		}
		
		
		public static function get instance():BossDataModel
		{
			return _instance ||= new BossDataModel(new $);
		}
		
		public function addHp(value:Number):void
		{
			this.msgName =  MsgTypeEnum.BOSS_HP_RECOVER;
			this.msg = value;
			this.notify()
		}
		
		public function addMp(value:Number):void
		{
			this.msgName =  MsgTypeEnum.BOSS_MP_RECOVER;
			this.msg = value;
			this.notify();
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			
		}
		
		public function dispose():void
		{
			
		}
		
		/**
		 * 最终boss攻击 
		 * @param attackRange
		 * @param attackInfo
		 * 
		 */		
		public function bossAttack(attackRange:Bitmap, attackInfo:ObjAttackMoveConfig, faceforward:Boolean):void
		{
			var hitInfo:ObjHitInfo = new ObjHitInfo();
			hitInfo.hitBounds = attackRange;
			if(attackInfo)
				hitInfo.attackHurtValue = attackInfo.hitValue;
			else
				hitInfo.attackHurtValue = 0;
			this.msgName =  MsgTypeEnum.BOSS_ATTACK;
			this.msg = hitInfo;
			this.notify();
		}
	}
}

class ${}
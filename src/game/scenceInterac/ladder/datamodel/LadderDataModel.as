package game.scenceInterac.ladder.datamodel
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;

	/**
	 * 梯子数据模型 
	 * @author admin
	 * 
	 */	
	public class LadderDataModel extends MessageCenter
	{
		private static var _instance:LadderDataModel = null;	
		
		public function LadderDataModel(code:$)
		{
			
		}

		public static function get instance():LadderDataModel
		{
			return _instance ||= new LadderDataModel(new $);
		}
		
		public function noteLadderPosX(ladderPosX:Number):void
		{
			this.msgName = MsgTypeEnum.NOTE_LADDER_POSX;
			this.msg = ladderPosX;
			this.notify();
		}
		
		/**
		 * 发送英雄是否碰到梯子 
		 * @param isTouchLadder
		 * 
		 */		
		public function noteHeroIsTouchLadder(isTouchLadder:Boolean):void
		{
			this.msgName = MsgTypeEnum.HERO_TOUCH_LADDER;
			this.msg  = isTouchLadder;
			this.notify();
		}
		
		public function updateLadderPlatStatus(isActive:Boolean):void
		{
			this.msgName = MsgTypeEnum.LADDER_PLAT_MOVE;
			this.msg = isActive;
			this.notify();
		}

	}
}


class ${};
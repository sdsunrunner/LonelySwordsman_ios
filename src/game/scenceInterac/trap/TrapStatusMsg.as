package game.scenceInterac.trap
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	/**
	 * 陷阱状态 
	 * @author admin
	 * 
	 */	
	public class TrapStatusMsg extends MessageCenter
	{
		private static var _instance:TrapStatusMsg = null;
		public function TrapStatusMsg(code:$)
		{
			super();
		}
		
		public static function get instance():TrapStatusMsg
		{
			return _instance ||= new TrapStatusMsg(new $);
		}
		
		public function noteScensorActive(sensorName:String):void
		{
			this.msg = sensorName;
			this.msgName = MsgTypeEnum.TRAP_SECSOR_ACTIVE;
			this.notify();
		}
	}
}

class ${}
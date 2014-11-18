package game.scenceInterac.fallRockMaker.statusModel
{
	import flash.display.Bitmap;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	import vo.ObjFallRockInfo;
	
	/**
	 * 落石系统数据模型 
	 * @author admin
	 * 
	 */	
	public class RockStatusModel extends MessageCenter
	{
		private static var _instance:RockStatusModel = null;
		
		public function RockStatusModel(code:$)
		{
			super();
		}
		
		public static function get instance():RockStatusModel
		{
			return _instance ||= new RockStatusModel(new $);
		}
		
		public function noteScensorActive(sensorName:String):void
		{
			this.msg = sensorName;
			this.msgName = MsgTypeEnum.FALLROCK_SECSOR_ACTIVE;
			this.notify();
		}
		
		public function noteRockPosUpdate(rockName:String,rockScensor:Bitmap):void
		{
			var info:ObjFallRockInfo = new ObjFallRockInfo();
			info.rockName = rockName;
			info.rockCheckBitMap = rockScensor;
			this.msg = info;
			this.msgName = MsgTypeEnum.ROCK_FALL_END;
			this.notify();
		}
		
		public function noteRemoveRockPos(rockName:String):void
		{
			this.msg = rockName;
			this.msgName = MsgTypeEnum.REMOVE_FALL_ROCK;
			this.notify();
		}
		
	}
}

class ${}
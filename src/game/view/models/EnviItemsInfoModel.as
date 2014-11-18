package game.view.models
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	import game.scenceInterac.fallRockMaker.statusModel.RockStatusModel;
	
	import vo.attackInfo.ObjEnviHitInfo;
	
	/**
	 * 环境交互数据模型 
	 * @author admin
	 * 
	 */	
	public class EnviItemsInfoModel extends MessageCenter
	{
		private static var _instance:EnviItemsInfoModel = null;
		private var _rockStatusModel:RockStatusModel = null;
		public function EnviItemsInfoModel(code:$)
		{
			_rockStatusModel = RockStatusModel.instance;
			super();
		}
		
		public static function get instance():EnviItemsInfoModel
		{
			return _instance ||= new EnviItemsInfoModel(new $);
		}
		
		public function noteHitRange(enviHitInfo:ObjEnviHitInfo):void
		{
			this.msg = enviHitInfo;
			this.msgName = MsgTypeEnum.ENVI_HIT;
			this.notify();
		}
		
		public function noteEnviHitdone(enviHitItemName:String):void
		{
			_rockStatusModel.noteRemoveRockPos(enviHitItemName);
		}
		
	}
}

class ${}
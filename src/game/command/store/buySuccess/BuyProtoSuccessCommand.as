package game.command.store.buySuccess
{
	import enum.ProcuctIdEnum;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	
	import playerData.GamePlayerDataProxy;
	
	import utils.console.infoCh;
	
	/**
	 * 购买消耗道具成功处理 
	 * @author admin
	 * 
	 */	
	public class BuyProtoSuccessCommand extends GameBaseCommand
	{
		private var _dataInfoModel:ProtoDataInfoModel = ProtoDataInfoModel.instance;
		override public function excute(note:INotification):void
		{
			var protoName:String = note.data as String;
			var value:Number = 0;
			infoCh("buy success handler","BuyProtoSuccessCommand");
			switch(protoName)
			{
				case ProcuctIdEnum.hp_recover_10:
					value = _dataInfoModel.hpProtoCount+10;
					_dataInfoModel.hpProtoCount = value;
					break;
				
				case ProcuctIdEnum.hp_recover_50:
					value = _dataInfoModel.hpProtoCount+50;
					_dataInfoModel.hpProtoCount = value;
					
					break;
				
				case ProcuctIdEnum.mp_recover_5:
					value = _dataInfoModel.mpProtoCount+5;
					_dataInfoModel.mpProtoCount = value;
					break;
				
				case ProcuctIdEnum.mp_recover_30:
					value = _dataInfoModel.mpProtoCount+30;
					_dataInfoModel.mpProtoCount = value;
					break;
			}
			
			this.saveData();
			this.refershView();
		}
		
		private function saveData():void
		{
			GamePlayerDataProxy.instance.saveGamelLevInfo();
		}
		
		private function refershView():void
		{
			var hpCount:Number = _dataInfoModel.hpProtoCount;
			var mpCount:Number = _dataInfoModel.mpProtoCount;
			
			if(uiDelegate.controlViewController)
				uiDelegate.controlViewController.refershProtoCount(hpCount,mpCount)
		}
	}
}
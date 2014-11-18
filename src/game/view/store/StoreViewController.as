package game.view.store
{
	import enum.ProcuctIdEnum;
	
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.command.share.ShareTypeEnum;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.event.MainScenceEvent;
	import game.view.event.NoteEvent;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * 商店视图 
	 * @author admin
	 * 
	 */	
	public class StoreViewController extends BaseViewerController
	{
		private var _view:StoreView = null;
		public function StoreViewController()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function dispose():void
		{
			_view.dispose();
			
		}
		public function showBuyresultNote(protoId:String):void
		{
			this.sendNotification(CommandViewType.INFO_ALERT_VIEW,protoId);
		}
		
		private function initView():void
		{
			_view = new StoreView();	
		}
		
		private function addListeners():void
		{
			_view.addEventListener(MainScenceEvent.STORE_CLOSE_BTN_CLICK, closeStoreView);
			_view.addEventListener(NoteEvent.BUY_HERO_PH_HANDLER, buyHeroPhReqHandler);
			_view.addEventListener(NoteEvent.BUY_BOSS_HANDLER, buyBossReqHandler);
			_view.addEventListener(NoteEvent.BUY_PROTO_HANDLER, buyGoodsReqHandler);
			_view.addEventListener(NoteEvent.SHARE_BOSS_UNCLOCK, shareBossunlockHandler);
			_view.addEventListener(NoteEvent.SHARE_SURVER_MODEL_SCORE, shareSuverModelScoreHandler);
		}
		
		private function buyGoodsReqHandler(evt:Event = null):void
		{
			var protoId:String = evt.data as String;
			// TODO Auto Generated method stub		
			this.sendNotification(CommandInteracType.BUY_GOODS_REQ,protoId);
//			this.sendNotification(CommandInteracType.BUY_PROTO_SUCCESS,protoId);
		}
		
		private function buyBossReqHandler():void
		{
			// TODO Auto Generated method stub
//			this.sendNotification(CommandInteracType.BUY_GOODS_REQ,ProcuctIdEnum.boss_un_lock);
//			this.sendNotification(CommandInteracType.BUY_BOSS_SUCCESS);
		}
		
		private function buyHeroPhReqHandler():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandInteracType.BUY_GOODS_REQ,ProcuctIdEnum.life_ph_3);
//			this.sendNotification(CommandInteracType.BUY_HERO_PH_SUCCESS);
		}
		
		private function closeStoreView():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandViewType.CLOSE_STORE_VIEW);
		}
		
		private function shareBossunlockHandler():void
		{
//			this.sendNotification(CommandInteracType.STARE_IMAGE_TO_WEIXIN,ShareTypeEnum.SHARE_BOSS_UNLOCK);
		}
		
		private function shareSuverModelScoreHandler():void
		{
			this.sendNotification(CommandInteracType.SHARE_IMAGE_TO_WEIXIN,ShareTypeEnum.SHARE_SURVER_MODEL_SCORE);
		}
		
	}
}
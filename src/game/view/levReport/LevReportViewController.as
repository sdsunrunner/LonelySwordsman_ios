package game.view.levReport
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandViewType;
	import game.view.event.NoteEvent;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * 关卡 结算视图控制器
	 * @author admin
	 * 
	 */	
	public class LevReportViewController extends BaseViewerController
	{
		private var _view:LevReportView = null;
		
		public function LevReportViewController()
		{
			super();
			initView();
			addListeners();
		}
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function dispose():void
		{
			_view.dispose();
			_view = null;
		}
		
		public function refershProtoCount(hpCount:Number,mpCount:Number,liftCount:Number):void
		{
			_view.refershProtoCount(hpCount,mpCount,liftCount);
		}
		
		
		private function initView():void
		{
			_view = new LevReportView();
		}
		
		private function addListeners():void
		{
			_view.addEventListener(NoteEvent.SHOW_STORE,showStoreView);
			_view.addEventListener(NoteEvent.SHOW_NEXT_LEV,showNextLev);
		}
		
		private function showStoreView(evt:Event):void
		{
			this.sendNotification(CommandViewType.PRODUCT_STORE_VIEW);
		}
		
		private function showNextLev(evt:Event):void
		{
			this.sendNotification(CommandViewType.CLOSE_GAME_LEV_END_REPORT_VIEW);
			this.sendNotification(CommandViewType.GAME_LEVEL_VIEW);
		}
	}
}
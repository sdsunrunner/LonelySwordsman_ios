package game.view.controlView
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandInteracType;
	import game.view.event.ControlleEvent;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * 控制视图控制器 
	 * @author songdu
	 * 
	 */	
	public class ControlViewController extends BaseViewerController
	{
		private var _view:ControlView = null;
		
		public function ControlViewController()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		public function activeControl(isActive:Boolean):void
		{		
			_view.activeControl(isActive);
			_view.touchable = isActive;
		}
		
		public function canUseProto(canUse:Boolean):void
		{
			_view.canUseProto(canUse);
		}
		
		public function refershProtoCount(hpCount:Number,mpCount:Number):void
		{
			_view.refershProtoCount(hpCount,mpCount);
		}		
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function  dispose():void
		{
			_view.dispose();
			_view = null;
		}
		
		private function initView():void			
		{
			_view = new ControlView();
		}
		
		private function addListeners():void
		{
//			_view.addEventListener(ControlleEvent.SHOW_STORE, showStoreHandler);
		}
		
		private function showStoreHandler():void
		{
			// TODO Auto Generated method stub
			this.sendNotification(CommandInteracType.GAME_PAUSE_SHOW_STORE);
		}
	}
	
}
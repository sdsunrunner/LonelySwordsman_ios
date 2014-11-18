package game.view.storyCg
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.event.MainScenceEvent;
	
	import starling.display.DisplayObjectContainer;
	
	import utils.console.infoCh;
	
	/**
	 * 剧情cg视图控制器 
	 * @author admin
	 * 
	 */	
	public class StoryCgViewController extends BaseViewerController
	{
		private var _view:StoryCgView = null;
		
		public function StoryCgViewController()
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
			_view = null;
		}
		
		/**
		 * 显示cg 
		 * @param type
		 * 
		 */		
		public function showStoryCg(type:String):void
		{
			_view.showCgView(type);	
			this.sendNotification(CommandViewType.CLOSE_SCENCE_MASK);
		}
		
		private function initView():void
		{
			_view = new StoryCgView();
		}
		
		private function addListeners():void
		{
			_view.addEventListener(MainScenceEvent.CG_SCENCE_END, cgScenceEndHandler);
			_view.addEventListener(MainScenceEvent.GAME_END, gameEndHandler);
			
		}
		
		private function cgScenceEndHandler():void
		{
			infoCh("note switch lev","StoryCgViewController");
			this.sendNotification(CommandInteracType.GAME_LEV_END_SENSOR_ACTIVE);
			this.sendNotification(CommandViewType.GAME_LEVEL_VIEW);
		}
		
		private function gameEndHandler():void
		{
			this.sendNotification(CommandInteracType.GAME_END_HANDLER);
		}
		
		
	}
}
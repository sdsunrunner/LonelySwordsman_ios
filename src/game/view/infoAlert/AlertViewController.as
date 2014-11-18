package game.view.infoAlert
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * alter视图控制器 
	 * @author admin
	 * 
	 */	
	public class AlertViewController extends BaseViewerController
	{
		private var _view:AlertView = null;
		
		public function AlertViewController()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		/**
		 * 显示提示信息 
		 * @param noteType
		 * 
		 */		
		public function setNoteType(noteType:String):void
		{
			_view.setNoteType(noteType);
		}
		
		override public function get viewer():DisplayObjectContainer
		{
			return _view;
		}
		
		override public function dispose():void
		{
			_view.dispose();
		}
		
		private function initView():void
		{
			_view = new AlertView();
		}
		
		private function addListeners():void
		{
			
		}
	}
}
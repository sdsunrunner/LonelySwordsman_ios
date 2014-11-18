package game.view.guiLayer
{
	import frame.view.viewDelegate.BaseViewerController;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * gui视图控制器 
	 * @author admin
	 * 
	 */	
	public class GuiViewController extends BaseViewerController
	{
		private var _view:GuiView = null;
		
		public function GuiViewController()
		{
			super();
			this.initView();
		}
		
		public function activeGui(value:Boolean):void
		{
			this.viewer.visible = value;
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
		
		private function initView():void
		{
			_view = new GuiView();
		}
	}
}
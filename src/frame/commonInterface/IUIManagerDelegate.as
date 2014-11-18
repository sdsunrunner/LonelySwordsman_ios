package  frame.commonInterface
{
	import frame.view.viewInterface.IViewerController;
	

	/**
	 * ui管理器接口 
	 * @author songdu.greg
	 * 
	 */	
	public interface IUIManagerDelegate extends IDelegate
	{
		/**
		 * 显示浮动面板
		 * @param	viewerController	IViewerController	面板控制器
		 * @param	type	String	面板类型
		 */
		function addPanel(viewerController:IViewerController, type:String):void;
		
		/**
		 * 生成浮动面板 
		 * @param	viewerController	IViewerController	面板控制器
		 * @param	type	String	面板类型
		 */	
		function createPanel(viewerController:IViewerController, type:String):void;
		
		/**
		 * 移除浮动面板
		 * @param	viewerController	IViewerController	面板控制器
		 * @param	type	String	面板类型
		 */
		function removePanel(viewerController:IViewerController, type:String):void;
	}
}
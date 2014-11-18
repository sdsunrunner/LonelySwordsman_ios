package frame.view.viewInterface
{
	import frame.commonInterface.IDispose;
	import frame.commonInterface.INotifier;
	
	import starling.display.DisplayObjectContainer;

	/**
	 * 控制器接口 
	 * @author songdu.greg
	 * 
	 */	
	public interface IViewerController extends IDispose, INotifier
	{
		/**
		 * 获取viewer 
		 * @return 
		 * 
		 */		
		function get viewer():DisplayObjectContainer;
		
		/**
		 * 设置ui加载状态 
		 * @param isReady
		 * 
		 */		
		function setReady(isReady:Boolean):void;
		
	}
}
package frame.view.viewInterface
{
	import frame.view.IObserver;
	
	/**
	 * viewer 接口 
	 * @author songdu.greg
	 * 
	 */	
	public interface IViewer extends IObserver
	{
		/**
		 * 初始化 model
		 * 
		 */		
		function initModel():void;
	}
}
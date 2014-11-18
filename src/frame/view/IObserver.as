package frame.view
{
	import frame.commonInterface.IDispose;

	/**
	 * 观察者接口 
	 * @author songdu.greg
	 * 
	 */	
	public interface IObserver extends IDispose
	{
		function infoUpdate(data:Object, msgName:String):void;
	}
}

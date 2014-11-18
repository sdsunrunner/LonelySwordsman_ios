package frame.command
{
	import frame.command.cmdInterface.INotification;
	
	/**
	 * Notification 基类 
	 * @author songdu.greg
	 * 
	 */	
	public class BaseNotification implements INotification
	{
		private var _data:Object = null;
//==============================================================================
// Public Functions
//==============================================================================
		
		public function set data(data:Object):void
		{
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}
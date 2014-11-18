package frame.view.viewModel
{
	import flash.utils.Dictionary;
	import frame.view.IObserver;
	import frame.view.viewInterface.IMessageCenter;

	/**
	 * 消息中心（观察者模式）
	 * @author songdu.greg
	 *
	 */
	public class MessageCenter implements IMessageCenter
	{
		protected var msg:Object=null;
		protected var observerDic:Dictionary=null;
		protected var msgName:String="";

//==============================================================================
// Public Functions
//==============================================================================

		public function register(ob:IObserver):void
		{
			if (null == observerDic)
				observerDic = new Dictionary(false);
			observerDic[ob] = null;
		}

		public function unRegister(ob:IObserver):void
		{
			if(observerDic)
				delete observerDic[ob];
		}

		public function unRegisterAll():void
		{
			observerDic=null;
		}

		public function notify():void
		{
			for (var key:* in observerDic)
			{
				var observer:IObserver=key;
				observer.infoUpdate(msg, msgName);
			}
		}
	}
}

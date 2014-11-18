package  frame.utils.load.loadQueue
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 资源加载队列, 控制同时加载资源的总量为指定值之下
	 *
	 */
	public class ResourceLoadQueue extends EventDispatcher
	{
		private static var _instance:ResourceLoadQueue=null;
		//同时加载的上限
		private static const LOADING_LIMIT:Number=15;
		//加载队列
		private var _queue:Array=new Array() /* SimpleResourceLoadUtility */;
		//当前同时加载的数量
		private var _loadingCount:Number=0;

		public function ResourceLoadQueue(code:$)
		{
			
		}
		
		public static function getInstance():ResourceLoadQueue
		{
			return _instance ||= new ResourceLoadQueue(new $);
		}

		public function addLoadItem(simpleResourceLoadUtility:SimpleResourceLoadUtility):void
		{
			simpleResourceLoadUtility.addEventListener(LoadEvent.LOAD_SUC, loadSucHandle);
			simpleResourceLoadUtility.addEventListener(LoadEvent.LOAD_ERR, loadErrHandle);

			this._queue.push(simpleResourceLoadUtility);

			this.loadNextItem();
		}

		private function loadNextItem():void
		{
			if (this._loadingCount < LOADING_LIMIT)
			{
				var simpleResourceLoadUtility:SimpleResourceLoadUtility=this._queue.shift();
				if (null != simpleResourceLoadUtility)
				{
					this._loadingCount++;
					simpleResourceLoadUtility.startLoad();
				}
			}
		}

		private function itemComplete(item:SimpleResourceLoadUtility):void
		{
			item.removeEventListener(LoadEvent.LOAD_SUC, loadSucHandle);
			item.removeEventListener(LoadEvent.LOAD_ERR, loadErrHandle);

			this._loadingCount--;
			this.loadNextItem();
			
			if(0 == this._loadingCount)
				this.dispatchEvent(new Event(Event.COMPLETE));
		}

		private function loadSucHandle(event:LoadEvent):void
		{
			itemComplete(event.currentTarget as SimpleResourceLoadUtility);
		}

		private function loadErrHandle(event:LoadEvent):void
		{
			itemComplete(event.currentTarget as SimpleResourceLoadUtility);
		}
	}
}

class ${}
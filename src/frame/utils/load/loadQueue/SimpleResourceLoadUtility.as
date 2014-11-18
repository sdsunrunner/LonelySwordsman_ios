package  frame.utils.load.loadQueue
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * 简易资源加载工具，主要是加载 PNG, JPG图片 ，只做加载，除回调函数外不带任何参数
	 */
	public class SimpleResourceLoadUtility extends EventDispatcher
	{
		private var _loader:Loader=null; // URLLoader for load resource file

		// the call back function when res load completed
		private var _callBackFunction:Function=null;

		private var _resourceURL:String="";

//==================================================================================================
// Public Functions
//==================================================================================================

		/**
		 * 设置获取资源文件的相关设定，此时并未开始加载
		 * @param resourceURL 资源文件地址
		 * @param callBackFunction 回调函数
		 *
		 */
		public function loadResFile(resourceURL:String, callBackFunction:Function):void
		{
			this._resourceURL = resourceURL;

			this._callBackFunction=callBackFunction;
			this._loader=new Loader();
			
			this.addListeners(this._loader.contentLoaderInfo);
		}

		/**
		 * 开始加载
		 */
		public function startLoad():void
		{
			this._loader.load(new URLRequest(this._resourceURL), new LoaderContext(false));
		}

		/**
		 * 获取 Loader
		 */
		public function get loader():Loader
		{
			return this._loader;
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		private function addListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}

		private function removeListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(Event.INIT, initHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.removeEventListener(Event.OPEN, openHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(Event.UNLOAD, unLoadHandler);
		}

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

		private function completeHandler(event:Event):void
		{
			//trace("completeHandler: " + event);

			try
			{
				var loaderInfo:LoaderInfo=event.target as LoaderInfo;

				// remove event listener
				this.removeListeners(loaderInfo);
				//trace("99 completeHandler, loaderInfo.url: " + loaderInfo.url);
				var argArray:Array=new Array();
				argArray.push(loaderInfo.loader);

				// call back function invoked
				//呼叫返回方法调用
				this._callBackFunction.apply(null, argArray);

				// clear the call back function in memory
				this._callBackFunction=null;

				// dispatch event
				this.dispatchEvent(new LoadEvent(LoadEvent.LOAD_SUC));

			}
			catch (event:TypeError)
			{
				//trace("res file format error");
				//trace(event.getStackTrace());
				throw event;
			}

		}

		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
			//trace("httpStatusHandler: " + event);
		}

		private function initHandler(event:Event):void
		{
			//trace("initHandler: " + event);
		}

		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("ioErrorHandler: " + this._resourceURL);
			// dispatch event
			this.dispatchEvent(new LoadEvent(LoadEvent.LOAD_ERR));
		}

		private function openHandler(event:Event):void
		{
			//trace("openHandler: " + event);
		}

		private function progressHandler(event:ProgressEvent):void
		{
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);

		}

		private function unLoadHandler(event:Event):void
		{
			//trace("unLoadHandler: " + event);
		}
	}
}
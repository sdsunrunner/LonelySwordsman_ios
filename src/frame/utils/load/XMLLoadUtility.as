////////////////////////////////////////////////////////////////////////////////
//
//  Utility to load XML file.
//
////////////////////////////////////////////////////////////////////////////////

package frame.utils.load
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	/**
	 * 有效加载xml文件
	 * Utility to load XML file.
	 */
	public class XMLLoadUtility
	{
		private var _loader:URLLoader=new URLLoader(); // URLLoader for load xml file

		// the call back function when xml load completed
		private var _callBackFunction:Function=null;

		// the call back function will not apply, when xml load completed, it will be a parameter
		private var _callBackFunction2:Function=null;

		// 是否是XML格式，如果是，将强制转为 XML 这种类型 ；否则，则强制为 String格式
		private var _isXMLFormat:Boolean=true;

		private var _xmlFilePath:String="";

//==============================================================================
// Public Functions
//==============================================================================

		/**
		 * Load a external XML file, and set the call back function for load complete.
		 *
		 * @param xmlFilePath the path of the external XML file
		 * @param callBackFunction the call back function for load complete
		 *
		 */
		public function loadXMLFile(xmlFilePath:String, callBackFunction:Function, isXMLFormat:Boolean=true):void
		{

			this._callBackFunction=callBackFunction;
			this._isXMLFormat=isXMLFormat;
			this._xmlFilePath=xmlFilePath;

			this._loader.dataFormat=URLLoaderDataFormat.TEXT;
			this._loader.addEventListener(Event.COMPLETE, xmlLoadCompleteHandle);

			this._loader.load(new URLRequest(xmlFilePath));
		}

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

		/**
		 * When the xml file is load complete, get the xml data. <br>
		 * Then call the call back function.<br>
		 * Finally clear the call back function in memory.<br>
		 *
		 * @param evt the COMPLETE event
		 *
		 */
		private function xmlLoadCompleteHandle(evt:Event):void
		{
			try
			{
				var urlLoader:URLLoader=evt.target as URLLoader;

				// remove event listener
				urlLoader.removeEventListener(Event.COMPLETE, xmlLoadCompleteHandle);

				if (this._isXMLFormat)
				{
					// xml 格式

					// get xml data
					var xmlData:XML=new XML(urlLoader.data);

					// call back function invoked
					this._callBackFunction.apply(null, [this._xmlFilePath, xmlData]);
				}
				else
				{
					// 纯文本格式，为 String 类型

					// get txt data
					var txtData:String=urlLoader.data as String;

					// call back function invoked
					this._callBackFunction.apply(null, [this._xmlFilePath, txtData]);
				}

				// clear the call back function in memory
				this._callBackFunction=null;

			}
			catch (event:TypeError)
			{
				trace("xml file format error" + this._xmlFilePath);

				trace(event.getStackTrace());
//				throw event;
			}
		}

	}

}
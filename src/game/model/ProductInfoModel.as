package game.model
{
	import frame.view.viewModel.MessageCenter;
	
	/**
	 * 商店信息模型 
	 * @author admin
	 * 
	 */	
	public class ProductInfoModel extends MessageCenter
	{
		private static var _instance:ProductInfoModel = null;
		private var _isAvailable:Boolean = false;
		
		private var _productList:String = "";
		
		public function ProductInfoModel(code:$)
		{
			super();
		}
		
		public function get productList():String
		{
			return _productList;
		}

		public function set productList(value:String):void
		{
			_productList = value;
		}

		public function get isAvailable():Boolean
		{
			return _isAvailable;
		}

		public function set isAvailable(value:Boolean):void
		{
			_isAvailable = value;
		}

		public static function get instance():ProductInfoModel 
		{
			return _instance ||= new ProductInfoModel(new $);
		}
		
		
	}
}

class ${}
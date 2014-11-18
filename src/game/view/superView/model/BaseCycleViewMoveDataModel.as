package game.view.superView.model
{
	import frame.view.viewModel.MessageCenter;

	/**
	 * 循环视图移动数据模型 
	 * @author songdu.greg
	 * 
	 */	
	public class BaseCycleViewMoveDataModel extends MessageCenter
	{
		private static var _instance:BaseCycleViewMoveDataModel = null;
		
		private var _moveType:String = BaseCycleViewMoveTypeEnum.WELCOME_SCENCE_MOVE;
		
		public function BaseCycleViewMoveDataModel(code:$)
		{
			
		}
		
		public function set moveType(value:String):void
		{
			_moveType = value;
		}

		public function get moveType():String
		{
			return _moveType;
		}
		

		public static function get instance():BaseCycleViewMoveDataModel
		{
			return _instance ||= new BaseCycleViewMoveDataModel(new $);
		}
	}
}

class ${}
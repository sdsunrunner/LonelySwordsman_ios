package game.view.models
{
	import frame.view.viewModel.MessageCenter;
	
	import starling.events.TouchPhase;
	
	/**
	 * 控制按钮数据模型 
	 * @author admin
	 * 
	 */	
	public class ControlleBarStatusModel extends MessageCenter
	{
		private static var _instance:ControlleBarStatusModel = null;
		
		private var _mainBtnTouchPhase:String = "";
		private var _heavyAttackTouchPhase:String = "";
		private var _blockTouchPhase:String = "";
		
		private var _isReadyToAction:Boolean = false;
		
		public function ControlleBarStatusModel(code:$)
		{
			super();
		}
		
		public function get isReadyToAction():Boolean
		{
			return _isReadyToAction;
		}

		public function set isReadyToAction(value:Boolean):void
		{
			_isReadyToAction = value;
		}

		public static function get instance():ControlleBarStatusModel
		{
			return _instance ||= new ControlleBarStatusModel(new $);
		}
		
		/**
		 * 设置主攻击动作状态  
		 * @param touchPhase
		 * 
		 */		
		public function setMainBtnTouchPhase(touchPhase:String):void
		{
			_mainBtnTouchPhase = touchPhase;
		}
		
		/**
		 * 设置重击动作状态 
		 * @param touchPhase
		 * 
		 */		
		public function setHeavyAttackBtnTouchPhase(touchPhase:String):void
		{
			_heavyAttackTouchPhase = touchPhase;
		}
		
		/**
		 * 设置格挡动作状态 
		 * @param touchPhase
		 * 
		 */		
		public function setBlockBtnTouchPhase(touchPhase:String):void
		{
			_blockTouchPhase = touchPhase;
		}
		
		
		/**
		 * 检查主攻击状态是否释放 
		 * @return 
		 * 
		 */		
		public function checkMainAttackRelease():Boolean
		{
			return _mainBtnTouchPhase == TouchPhase.ENDED;
		}
		
		/**
		 * 检查重击释放释放 
		 * @return 
		 * 
		 */		
		public function checkHeavyAttackRelease():Boolean
		{
			return _heavyAttackTouchPhase == TouchPhase.ENDED;
		}
		
		/**
		 * 使用道具 
		 * @param propType
		 * 
		 */		
		public function noteUseProp(propType:String):void
		{
			this.msgName = propType;
			this.notify();
		}
		
		public function notParryBack():void
		{
			this.msgName = "parry";
			this.notify();
		}
		
		/**
		 * 攻击按钮tap 
		 * 
		 */		
		public function noteMoveBtnTap(actionType:String):void
		{
			this.msgName = actionType;
			this.notify();
		}
	}
}

class ${}
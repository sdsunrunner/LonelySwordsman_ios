package game.view.controlView
{
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.controlView.JoyStick.ControllerJoyStickView;
	import game.view.controlView.movesBarView.MovesBarView;
	
	/**
	 * 控制 视图
	 * @author songdu
	 * 
	 */	
	public class ControlView extends BaseViewer
	{
		
		private var _joyStickView:ControllerJoyStickView = null;
		private var _movesBarView:MovesBarView = null;			
		public function ControlView()
		{
			super();
			this.initView();
//			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function activeControl(active:Boolean):void
		{
			_movesBarView.visible = active;			
			_joyStickView.activeController(active);
		}
		
		public function canUseProto(canUse:Boolean):void
		{
			_movesBarView.canUseProto(canUse);
		}
		
		public function refershProtoCount(hpCount:Number,mpCount:Number):void
		{
			_movesBarView.refershHpPtotoCount(hpCount);
			_movesBarView.refershMpPtotoCount(mpCount);
		}
		
		override public function dispose():void
		{			
			_joyStickView.dispose();
			_joyStickView = null;
			_movesBarView.dispose();
			_movesBarView = null;
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		private function initView():void
		{			
			_joyStickView = new ControllerJoyStickView();
		
			_movesBarView = new MovesBarView();
			_movesBarView.x = Const.STAGE_WIDTH - _movesBarView.width;
			_movesBarView.y = Const.STAGE_HEIGHT - _movesBarView.height - 50;
			this.addChild(_movesBarView);
			_movesBarView.alpha = 0.8;

			
		}	
		
//		private function onTouch(event:TouchEvent):void
//		{
//			//得到触碰并且正在移动的点（1个或多个）
//			var hoverTouches:Vector.<Touch> = event.getTouches(this, TouchPhase.HOVER);
//			//如果只有一个点在移动，是单点触碰
//			
//			var btnTouches:Vector.<Touch> = event.getTouches(this, TouchPhase.BEGAN);
//			if (btnTouches.length == 1)
//			{
//				errorCh("controller","btn touch");
//			}
//			
//		}
	}
}
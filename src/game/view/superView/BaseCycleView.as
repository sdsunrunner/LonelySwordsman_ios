package game.view.superView
{
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.superView.model.BaseCycleViewMoveDataModel;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * 循环视图超类 
	 * @author songdu.greg
	 * 
	 */	
	public class BaseCycleView extends BaseViewer
	{
		protected var _bgLeft:Image = null;
		protected var _bgRight:Image = null;
		protected var _dataModel:BaseCycleViewMoveDataModel = null;
		
		private var _bound:Number = 0;
		
		public function BaseCycleView()
		{
			super();
			_dataModel = BaseCycleViewMoveDataModel.instance;
			_dataModel.register(this);
			
			
				_bound = BaseCycleViewMoveTypeEnum.MOUNTAIN_TILD_WIDTH;
		}
		
		public function reset():void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function updateScencePos(value:Number):void
		{
			this._bgLeft.x += value;
			this._bgRight.x += value;
			
			if(value < 0)
			{
				if(this._bgLeft.x < -1*_bound)
					this._bgLeft.x = _bound;
				
				if(this._bgRight.x < -1*_bound)
					this._bgRight.x = _bound;
			}
			else if(value > 0)
			{
				if(this._bgRight.x > _bound)
					this._bgRight.x = -1*_bound;
				
				if(this._bgLeft.x > _bound)
					this._bgLeft.x = -1*_bound;
			}
		}
		
		public function setMoveStatus():void
		{
			if(_dataModel.moveType == BaseCycleViewMoveTypeEnum.WELCOME_SCENCE_MOVE)
			{
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		public function enterFrameHandler(evt:Event):void
		{
			
		}
	}
}
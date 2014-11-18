package game.view.superView.baseScenceView
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.models.HeroMoveStepModel;
	import game.view.models.HeroStatusModel;
	
	/**
	 * 近景装饰层 
	 * @author songdu
	 * 
	 */	
	public class BaseScenceCloseShotOrnamentView extends BaseViewer
	{
		private var _model:HeroMoveStepModel = null;
		private var _heroStatusModel:HeroStatusModel = null;
		public function BaseScenceCloseShotOrnamentView()
		{
			super();
			this.initModel();
			this.alpha = 0.9;
			this.flatten();
			this.touchable = false;
		}
		
		override public function initModel():void
		{
			_model = HeroMoveStepModel.instance;
			_model.register(this);
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName ==  MsgTypeEnum.HERO_MOVE)
			{
				this.x += (data as Number)*Const.GAME_SCENCE_CLOSESHOT_MOVE_RATIO;
			}
			
			if(msgName ==   MsgTypeEnum.HERO_POS_UPDATE)
			{

			}			
		}
	}
}
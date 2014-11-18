package game.view.superView.baseScenceView
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.models.HeroMoveStepModel;
	import game.view.models.HeroStatusModel;
	
	/**
	 * 场景地图 
	 * @author songdu
	 * 
	 */	
	public class BaseScenceMapOrnamentView extends BaseViewer
	{
		private var _model:HeroMoveStepModel = null;
		private var _heroStatusModel:HeroStatusModel = null;
		
		public function BaseScenceMapOrnamentView()
		{
			super();
			this.initModel();
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
//				this.x += (data as Number)*Const.GAME_SCENCE_MAP_MOVE_RATIO;
			}
			
			if(msgName ==   MsgTypeEnum.HERO_POS_UPDATE)
			{
				
			}			
		}
		
		
	}
}
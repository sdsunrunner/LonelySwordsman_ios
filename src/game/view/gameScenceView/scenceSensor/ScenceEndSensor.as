package game.view.gameScenceView.scenceSensor
{
	import frame.commonInterface.IDispose;
	
	import game.basewidget.ScenceBaseSensor;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.view.gameScenceView.event.ScenceEvent;
	
	import starling.events.Event;
	
	import utils.console.infoCh;
	
	/**
	 * 场景结束探测器 
	 * @author admin
	 * 
	 */	
	public class ScenceEndSensor extends ScenceBaseSensor implements IDispose
	{
		private var _senceEndSensorView:SenceEndSensorView = null;
		
		public function ScenceEndSensor(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_senceEndSensorView = new SenceEndSensorView();
					params.view = _senceEndSensorView;
				}
			}
			super(name, params);
			this.addListeners();
		}
		
		private function addListeners():void
		{
			_senceEndSensorView.addEventListener(ScenceEvent.GAME_SCENCE_END,scenceEndhander);
			_senceEndSensorView.addEventListener(Event.ADDED_TO_STAGE,addToStagehandler);
		}
		
		public function dispose():void
		{	
			if(_senceEndSensorView)
				_senceEndSensorView.dispose();
			_senceEndSensorView = null;
			_ce.state.remove(this);
		}
		
		private function addToStagehandler(obj:Event):void
		{	
			_senceEndSensorView.initPos(this.x, this.y);
		
		}
		
		private function scenceEndhander(obj:Event):void
		{	
			infoCh("note switch lev","ScenceEndSensor");
			this.sendNotification(CommandViewType.GAME_LEV_END_VIEW);
			this.sendNotification(CommandInteracType.GAME_LEV_END_SENSOR_ACTIVE);
//			this.sendNotification(CommandViewType.GAME_LEVEL_VIEW);
		}
	}
}
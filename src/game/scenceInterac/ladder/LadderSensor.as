package game.scenceInterac.ladder
{
	import frame.commonInterface.IDispose;
	
	import game.basewidget.ScenceBaseSensor;
	
	/**
	 * 梯子传感器 
	 * @author admin
	 * 
	 */	
	public class LadderSensor extends ScenceBaseSensor implements IDispose
	{
		private var _ladderSensorView:LadderSensorView = null;
		public function LadderSensor(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_ladderSensorView = new LadderSensorView();
					params.view = _ladderSensorView;
				}
			}
			super(name, params);
			
		}
		override public function update(timeDelta:Number):void 
		{			
			super.update(timeDelta);
			_ladderSensorView.track(null,"");
		}
		
		public function dispose():void
		{
			_ladderSensorView.dispose();
			_ladderSensorView = null;
		}		
	}
}
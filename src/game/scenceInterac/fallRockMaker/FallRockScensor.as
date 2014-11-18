package game.scenceInterac.fallRockMaker
{
	import frame.commonInterface.IDispose;
	
	import game.basewidget.ScenceBaseSensor;
	import game.scenceInterac.fallRockMaker.rockSysView.FallRockSensorView;
	
	/**
	 * 落石触发探测器 
	 * @author admin
	 * 
	 */	
	public class FallRockScensor extends ScenceBaseSensor implements IDispose
	{
		private var _sensorView:FallRockSensorView = null;
		public function FallRockScensor(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_sensorView = new FallRockSensorView();
					params.view = _sensorView;
				}
			}
			super(name, params);
			_sensorView.itemName = this.name;
		}
		
		public function dispose():void
		{			
			_sensorView = null;
		}	
	}
}
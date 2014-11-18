package game.scenceInterac.trap
{
	import frame.commonInterface.IDispose;
	
	import game.basewidget.ScenceBaseSensor;
	
	/**
	 * 陷阱探测器 
	 * @author admin
	 * 
	 */	
	public class TrapScensor extends ScenceBaseSensor implements IDispose
	{
		private var _sensorView:TrapScensorView = null;
		public function TrapScensor(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_sensorView = new TrapScensorView();
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
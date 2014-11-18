package game.scenceInterac.trap
{
	import frame.commonInterface.IDispose;
	
	import game.basewidget.ScenceBaseSensor;
	import game.view.enemySoldiers.EnemyEvent;
	
	import starling.events.Event;
	
	/**
	 * 可爆炸的探测器 
	 * @author admin
	 * 
	 */	
	public class ExplodeTrapScensor extends ScenceBaseSensor implements IDispose
	{
		private var _sensorView:ExplodeTrapScensorView = null;
		public function ExplodeTrapScensor(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_sensorView = new ExplodeTrapScensorView();
					params.view = _sensorView;
				}
			}
			super(name, params);
			_sensorView.itemName = this.name;
			addListeners();
		}
		
		public function dispose():void
		{
			if(_sensorView)
				_sensorView.dispose();
			_sensorView = null;
		}	
		
		private function addListeners():void
		{
			_view.addEventListener(EnemyEvent.REMOVE_ENMY_NOTE,removeEnemyHandler);
		}
		
		private function removeEnemyHandler(evt:Event):void
		{
			this.dispose();
		}
	}
}
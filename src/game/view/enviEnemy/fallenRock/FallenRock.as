package game.view.enviEnemy.fallenRock
{
	import flash.utils.setTimeout;
	
	import enum.MsgTypeEnum;
	
	import frame.commonInterface.IDispose;
	import frame.view.IObserver;
	
	import game.scenceInterac.fallRockMaker.statusModel.RockStatusModel;
	import game.view.enemySoldiers.BaseEnemy;
	
	import utils.MaterialUtils;
	
	/**
	 * 落石 
	 * @author admin
	 * 
	 */	
	public class FallenRock extends BaseEnemy implements IDispose, IObserver
	{
		private var _view:FallRockView = null;
		private var _rockStatus:RockStatusModel = null;
		public function FallenRock(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_view = new FallRockView();
					params.view = _view;
				}
			}
			
			super(name, params);
			this.speed = 0;
			this.initModel();
			_view.itemName = name;
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			var rockname:String = data as String;
			if(msgName == MsgTypeEnum.REMOVE_FALL_ROCK && rockname == name)
			{
				setTimeout(dispose,10);
			}
		}
		
		override public function dispose():void
		{
			if(_view)
			{
				_view.dispose();
				_view = null;
				this.destroy();
			}
		}
		
		private function initModel():void
		{
			_rockStatus = RockStatusModel.instance;
			_rockStatus.register(this);
		}
		override protected function createMaterial():void 
		{			
			_material = MaterialUtils.createRockMaterial();
		}
	}
}
package game.scenceInterac.fallRockMaker
{
	import flash.utils.setTimeout;
	
	import citrus.objects.platformer.nape.MovingPlatform;
	
	import enum.MsgTypeEnum;
	
	import frame.view.IObserver;
	
	import game.scenceInterac.fallRockMaker.statusModel.RockStatusModel;
	
	/**
	 * 落石承载平台 
	 * @author admin
	 * 
	 */	
	public class RockPlatform extends MovingPlatform implements IObserver
	{
		private var _rockStatusModel:RockStatusModel = null;
		public function RockPlatform(name:String, params:Object=null)
		{
			super(name, params);
			this.initModel();
		}
		public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.FALLROCK_SECSOR_ACTIVE)
			{
				var sensorname:String = data as String;
				if(sensorname == this.name)
				{
					var value:Number = Math.random() * Const.FALL_ROCK_TIME_SPACE;
					setTimeout(activeFallRock,value);
				}
					
			}
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
			this.endY = value;
		}
		
		
		override public function set x(value:Number):void
		{
			super.x = value;
			this.endX = value;
		}
		
		private function activeFallRock():void
		{
			this.y = int.MAX_VALUE;
			super.enabled = false;
		}
		
		public function dispose():void
		{
			if(_rockStatusModel)
				_rockStatusModel.unRegister(this);
			_rockStatusModel = null;
		}
		private function initModel():void
		{
			_rockStatusModel = RockStatusModel.instance;
			_rockStatusModel.register(this);
		}
	}
}
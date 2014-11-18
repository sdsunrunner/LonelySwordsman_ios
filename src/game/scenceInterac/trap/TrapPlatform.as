package game.scenceInterac.trap
{
	import flash.utils.setTimeout;
	
	import citrus.objects.platformer.nape.MovingPlatform;
	
	import enum.MsgTypeEnum;
	
	import frame.view.IObserver;
	
	/**
	 * 陷阱平台 
	 * @author admin
	 * 
	 */	
	public class TrapPlatform extends MovingPlatform implements IObserver		
	{
		private var _platView:TrapPlatformView = null;
		
		public var endXPlus:Number = 0;
		private var _model:TrapStatusMsg = null;
		
		public function TrapPlatform(name:String, params:Object=null)
		{
			if(params)
			{
				endXPlus = params.endXPlus;
				if(!params.view)
				{
					_platView = new TrapPlatformView(params.width);
					params.view = _platView;
				}
			}
			super(name, params);	
			this.initModel();
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.TRAP_SECSOR_ACTIVE)
			{
				_platView.showSmoke();
				setTimeout(activeFallRock,500);
			}
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;			
			_start.x = value;
			this.endX = value;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;			
			_start.y = value;
			this.endY = value;
		}
		
		public function dispose():void
		{
			if(_model)
				_model.unRegister(this);
			if(_platView)
				_platView.dispose();
			_model = null;
		}
		
		private function activeFallRock():void
		{
			this.y = int.MAX_VALUE;
			super.enabled = false;
		}
		private function initModel():void
		{
			_model = TrapStatusMsg.instance;
			_model.register(this);
		}
	}
}
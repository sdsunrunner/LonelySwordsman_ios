package game.scenceInterac.fallRockMaker
{
	import frame.commonInterface.IDispose;
	import frame.sys.track.ITrackable;
	
	import game.basewidget.ScenceBaseSensor;
	import game.scenceInterac.fallRockMaker.rockSysView.RockRemoveScensorView;
	import game.view.models.SysEnterFrameCenter;
	
	/**
	 * 落石remove探测器 
	 * @author admin
	 * 
	 */	
	public class FallRockRemoveScensor extends ScenceBaseSensor implements ITrackable, IDispose
	{
		private var _fallRockremoveView:RockRemoveScensorView = null;
		public var scensorWidth:Number = 0;
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		public function FallRockRemoveScensor(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_fallRockremoveView = new RockRemoveScensorView();
					params.view = _fallRockremoveView;
				}
			}
			super(name, params);
			this.initModel();
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			if(_fallRockremoveView)
				_fallRockremoveView.resetPos(this.x, this.y);
		}
		
		public function dispose():void
		{
			if(_fallRockremoveView)
				_fallRockremoveView.dispose();
			_fallRockremoveView = null;
		}
		
		private function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
		}
	}
}
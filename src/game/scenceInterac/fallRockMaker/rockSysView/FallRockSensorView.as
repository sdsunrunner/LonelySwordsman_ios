package game.scenceInterac.fallRockMaker.rockSysView
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import enum.MsgTypeEnum;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.scenceInterac.fallRockMaker.statusModel.RockStatusModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SysEnterFrameCenter;
	
	import utils.HitTest;
	
	/**
	 * 落石探测器 
	 * @author admin
	 * 
	 */	
	public class FallRockSensorView extends BaseViewer implements ITrackable
	{
		private var _sensor:Bitmap = null;
		private var _gloabPoint:Point = new Point();
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _heroStatus:HeroStatusModel = null;
		private var _rockStatusModel:RockStatusModel = null;
		private var _itemName:String = "";
		private var _heroPos:Bitmap = null;
		public function FallRockSensorView()
		{
			super();
			initView();
			initModel();
		}
		
		public function set itemName(value:String):void
		{
			_itemName = value;
		}

		public function track(msg:Object, msgName:String, delayFlag:Boolean=false):void
		{
			_gloabPoint = localToGlobal(new Point(this.x,this.y));
			_sensor.x = _gloabPoint.x;
			_sensor.y = _gloabPoint.y-50;
		}
		
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_TRAIL_UPDATE)
			{
				_heroPos = data as Bitmap;
				this.checkSensorActive();
			}
		}
		
		override public function dispose():void
		{
			_enterFrameCenter.unRegister(this);
			_enterFrameCenter = null
		
			_heroStatus.unRegister(this);
			_heroStatus = null;
			
			Const.collideLayer.removeChild(_sensor);
			_sensor.bitmapData.dispose();
			_sensor = null;
		}
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_heroStatus = HeroStatusModel.instance;
			_heroStatus.register(this);
			
			_rockStatusModel = RockStatusModel.instance;
			
		}
		
		private function initView():void
		{
			_sensor = new Bitmap();
			_sensor.bitmapData = assetManager.getBitmapForHitByName("mechanismSensor");
			Const.collideLayer.addChild(_sensor);
		}
		
		private function checkSensorActive():void
		{
			if(HitTest.complexHitTestObject(_heroPos,_sensor))
			{
				_rockStatusModel.noteScensorActive(_itemName);
			}
		}
	}
}
package game.scenceInterac.fallRockMaker.rockSysView
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import enum.MsgTypeEnum;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.scenceInterac.fallRockMaker.statusModel.RockStatusModel;
	import game.view.models.SysEnterFrameCenter;
	
	import utils.HitTest;
	
	import vo.ObjFallRockInfo;
	
	/**
	 * 落石删除探测器 
	 * @author admin
	 * 
	 */	
	public class RockRemoveScensorView extends BaseViewer  implements ITrackable
	{
		private var _sensor:Bitmap = null;
		private var _gloabPoint:Point = new Point();
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _rockStatusModel:RockStatusModel = null;
	
		private var _needRemove:Dictionary = null;
		private var _frameCount:Number = 0;
		
		public function RockRemoveScensorView()
		{
			super();
			this.initView();
			this.initModel();
			_needRemove = new Dictionary();
		}
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_rockStatusModel = RockStatusModel.instance;
			_rockStatusModel.register(this);
		}
		
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(MsgTypeEnum.ROCK_FALL_END == msgName)
			{
				var rockInfo:ObjFallRockInfo = data as ObjFallRockInfo;
				_needRemove[rockInfo.rockName] = rockInfo;
			}
		}
		
		public function resetPos(posX:Number, posY:Number):void
		{
			
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean=false):void
		{
			_gloabPoint = localToGlobal(new Point(this.x,this.y));			
			_sensor.y = _gloabPoint.y;
			_sensor.x = 0;
			checkNeedRemove();
		}
		
		override public function dispose():void
		{
			if(_enterFrameCenter)
				_enterFrameCenter.unRegister(this);
			_enterFrameCenter = null;
			if(_rockStatusModel)
				_rockStatusModel.unRegister(this);
			_rockStatusModel = null;	
			if(_sensor)
				Const.collideLayer.removeChild(_sensor);
			if(_sensor && _sensor.bitmapData)
				_sensor.bitmapData.dispose();
			_needRemove = null;
		}		
		
		private function initView():void
		{
			_sensor = new Bitmap();
			_sensor.bitmapData = assetManager.getBitmapForHitByName("basicSight");
			_sensor.width = Const.STAGE_WIDTH;
			Const.collideLayer.addChild(_sensor);
		}
		
		private function checkNeedRemove():Boolean
		{
			var count:Number = 0;
			var itemname:String = "";
			for (var key:* in _needRemove)
			{
				itemname = key;
				checkSensorActive(_needRemove[itemname]);
				count++;
			}
			
			return count>0;
		}
		
		
		private function checkSensorActive(rockInfo:ObjFallRockInfo):void
		{
			if(HitTest.complexHitTestObject(rockInfo.rockCheckBitMap,_sensor))
			{				
				_rockStatusModel.noteRemoveRockPos(rockInfo.rockName);
				delete _needRemove[rockInfo.rockName];
			}
		}
	}
}

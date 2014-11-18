package game.scenceInterac.ladder
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import enum.MsgTypeEnum;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.scenceInterac.ladder.datamodel.LadderDataModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SysEnterFrameCenter;
	
	import utils.HitTest;
	
	import vo.configInfo.ObjScenceInteracConfigInfo;
	
	/**
	 * 梯子传感器探测器视图 
	 * @author admin
	 * 
	 */	
	public class LadderSensorView extends BaseViewer implements ITrackable
	{
		private var _laddRange:Bitmap = null;
		private var _gloabPoint:Point = new Point();
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _ladderDataModel:LadderDataModel = null;
		private var _heroTestBit:Bitmap = null;
		private var _isTouchLadder:Boolean = false;
		
		private var _scenceConfig:ObjScenceInteracConfigInfo = null;
		
		public function LadderSensorView()
		{
			super();
			_scenceConfig = GameLevelManager.instance.getScenceInteracConfigInfo();
			
			this.initView();
			this.initModel();
		}
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_ladderDataModel = LadderDataModel.instance;
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_TRAIL_UPDATE)
			{
				_heroTestBit = data as Bitmap;
				if(HitTest.complexHitTestObject(_heroTestBit,_laddRange))				
					_isTouchLadder = true;				
				else
					_isTouchLadder = false;
				
				_ladderDataModel.noteHeroIsTouchLadder(_isTouchLadder);
			}
		}
		override public function dispose():void
		{
			_enterFrameCenter.unRegister(this);
			_heroStatusModel.unRegister(this);
			if(_laddRange.parent == Const.collideLayer)
				Const.collideLayer.removeChild(_laddRange);
			if(_heroTestBit)
				_heroTestBit.bitmapData.dispose();
			_heroTestBit = null;
			if(_laddRange)
				_laddRange.bitmapData.dispose();
			_laddRange = null;
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{	
			_gloabPoint = localToGlobal(new Point(this.x,this.y));
			_laddRange.x = _gloabPoint.x - _scenceConfig.ladderOffsetX;
			_laddRange.y = _gloabPoint.y -  _scenceConfig.ladderOffsetY;
		}
		
		private function initView():void
		{
			_laddRange = new Bitmap();
			_laddRange.bitmapData = assetManager.getBitmapForHitByName("ladderPlatform");
			_laddRange.height = _scenceConfig.ladderHeight;
			_laddRange.width = 150;
			Const.collideLayer.addChild(_laddRange);
		}	
	}
}
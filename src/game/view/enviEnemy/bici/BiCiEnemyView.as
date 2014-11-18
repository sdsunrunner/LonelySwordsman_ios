package game.view.enviEnemy.bici
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import frame.sys.track.ITrackable;
	import frame.view.IObserver;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.models.EnviItemsInfoModel;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.display.Image;
	
	import vo.attackInfo.ObjEnviHitInfo;
	
	/**
	 * 墙壁上的尖刺 视图 
	 * @author admin
	 * 
	 */	
	public class BiCiEnemyView extends BaseViewer implements ITrackable,IObserver
	{
		private static const SHOW_IMAGE_COUNT:Number = 15;
		private static const IMAGE_HEIGHT:Number = 32;
		private var _hitBitMap:Bitmap = null;
		private var _gloabPoint:Point = null;
		private var _hitInfo:ObjEnviHitInfo = null;
		
		private var _enviItemsInfoModel:EnviItemsInfoModel = null;
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		public function BiCiEnemyView()
		{
			super();
			this.initView();
			this.initModel();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_hitBitMap.bitmapData.dispose();
			
			_enterFrameCenter.register(this);
			_enterFrameCenter = null;
			_enviItemsInfoModel =null;
			
			Const.collideLayer.addChild(_hitBitMap);	
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			
		}	
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_enviItemsInfoModel = EnviItemsInfoModel.instance;
		}		
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			_gloabPoint = localToGlobal(new Point(this.x,this.y));
			
			if(_hitBitMap)
			{
				_hitBitMap.scaleX = 3;
				_hitBitMap.x = _gloabPoint.x-50;
				_hitBitMap.y = _gloabPoint.y+600;
			}
			
			_hitInfo = new ObjEnviHitInfo();
			_hitInfo.enViHitValue = 100;
			_hitInfo.hitBounds = this._hitBitMap;	
			if(delayFlag&&_enviItemsInfoModel)
				_enviItemsInfoModel.noteHitRange(_hitInfo);
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < SHOW_IMAGE_COUNT; i++)
			{
				var image:Image = new Image(assetManager.getTextureAtlas("map_items").getTexture("hengci"));
				image.scaleX = -1;
				image.x = 0;
				image.y = i*IMAGE_HEIGHT;
				this.addChild(image);
			}
			
			_hitBitMap = new Bitmap();
			_hitBitMap.bitmapData = assetManager.getBitmapForHitByName("pillarHit");
			Const.collideLayer.addChild(_hitBitMap);	
		}
	}
}
package  game.view.enviEnemy.dici
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
	 * 地上的尖刺 视图 
	 * @author admin
	 * 
	 */	
	public class DiCiEnemyView extends BaseViewer implements ITrackable,IObserver
	{
		private var _showImageCount:Number = 1;
		private static const IMAGE_Width:Number = 171;
		private var _hitBitMap:Bitmap = null;
		private var _gloabPoint:Point = null;
		private var _hitInfo:ObjEnviHitInfo = null;
		
		private var _enviItemsInfoModel:EnviItemsInfoModel = null;
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		
		public function DiCiEnemyView(count:Number)
		{
			_showImageCount = count;
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
			_enviItemsInfoModel = null;
			
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
				_hitBitMap.x = _gloabPoint.x - 1000;
				_hitBitMap.width = Const.STAGE_WIDTH;
				_hitBitMap.y = _gloabPoint.y+50;
				_hitBitMap.rotation = 90;
			}
			
			_hitInfo = new ObjEnviHitInfo();
			_hitInfo.enViHitValue = 1000;
			_hitInfo.hitBounds = this._hitBitMap;	
			if(_enviItemsInfoModel)
				_enviItemsInfoModel.noteHitRange(_hitInfo);
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < _showImageCount; i++)
			{
				var image:Image = new Image(assetManager.getTextureAtlas("map_items").getTexture("dici"));
//				image.scaleX = -1;
				image.x = i*IMAGE_Width;
				image.y = -30;
				this.addChild(image);
			}
			
			_hitBitMap = new Bitmap();
			_hitBitMap.bitmapData = assetManager.getBitmapForHitByName("pillarHit");
			Const.collideLayer.addChild(_hitBitMap);	
		}
	}
}
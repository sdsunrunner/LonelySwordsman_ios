package game.view.enviEnemy.fallenRock
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.scenceInterac.fallRockMaker.statusModel.RockStatusModel;
	import game.view.models.EnviItemsInfoModel;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.display.Image;
	
	import vo.attackInfo.ObjEnviHitInfo;
	
	/**
	 * 落石视图 
	 * @author admin
	 * 
	 */	
	public class FallRockView extends BaseViewer implements ITrackable
	{
		private var _image:Image = null;
		
		private static const ROCK_IMAGE_NAMES:Array = ["smallRock"];
		private var _trackCenter:SysEnterFrameCenter = null;
		private var _enviItemsInfoModel:EnviItemsInfoModel = null;
		private var _rockStatusModel:RockStatusModel = null;
		private var _hitBitmap:Bitmap = null;
		private var _gloabPoint:Point = null;
		
		private var _hitInfo:ObjEnviHitInfo = null;
		private var _itemName:String = "";
		public function FallRockView()
		{
			super();			
			this.initView();
			this.initModel();
		}
		
		public function set itemName(value:String):void
		{
			_itemName = value;
		}

		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			this.scaleX = 1;
			_gloabPoint = localToGlobal(new Point(this.x,this.y));
			_hitBitmap.x = _gloabPoint.x-10;
			_hitBitmap.y = _gloabPoint.y+30;
			if(null == _hitInfo)
			{
				_hitInfo = new ObjEnviHitInfo();
				_hitInfo.hitBounds = _hitBitmap;
				_hitInfo.enViHitValue = Const.SMALL_ROCK_HIT_VALUE;
				_hitInfo.enViHitItemname = this._itemName;
			}
			_enviItemsInfoModel.noteHitRange(_hitInfo);
			_rockStatusModel.noteRockPosUpdate(this._itemName, this._hitBitmap);
		}
		
		override public function initModel():void
		{
			_trackCenter = SysEnterFrameCenter.instance;
			_trackCenter.register(this);
			
			_enviItemsInfoModel = EnviItemsInfoModel.instance;			
			_rockStatusModel = RockStatusModel.instance;
		}
		
		override public function dispose():void
		{
			_trackCenter.unRegister(this);
			_trackCenter = null;
			
			if(_hitBitmap)
			{
				_hitBitmap.bitmapData.dispose();
				if(_hitBitmap.parent == Const.collideLayer)
					Const.collideLayer.removeChild(_hitBitmap);
				_hitBitmap = null;
			}
				
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			this.removeEventListeners();
		}
		
		private function initView():void
		{
			var index:Number = Math.floor(Math.random()*ROCK_IMAGE_NAMES.length);
			var rockname:String = ROCK_IMAGE_NAMES[index];
			_image = new Image(assetManager.getTextureAtlas("map_items").getTexture(rockname));		
			_image.y = 7;
			_image.scaleX = 1;
			this.addChild(_image);
			
			_hitBitmap = new Bitmap();
			_hitBitmap.bitmapData = assetManager.getBitmapForHitByName(rockname);
			_hitBitmap.scaleX = -1;
			Const.collideLayer.addChild(_hitBitmap);
		}
	}
}
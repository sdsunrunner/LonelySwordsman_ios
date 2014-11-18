package game.view.store
{
	import enum.ProcuctIdEnum;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	import game.view.event.NoteEvent;
	import game.view.models.HeroStatusModel;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	
	/**
	 * 商店视图 
	 * @author admin
	 * 
	 */	
	public class StoreView extends BaseViewer
	{
		private var _bgMask:Shape = null;		
		
		private var _closeImage:Image = null;
		private var _buyHeroPh:Image = null;
//		private var _buyBossImage:Image = null;
		private var _bg:Image = null;
		
		private var _storeGoods1:Image = null;
		private var _storeGoods2:Image = null;
		private var _storeGoods3:Image = null;
		private var _storeGoods4:Image = null;
		
//		private var _restoreBtn:Image = null;
//		private var _monsterUnLock:Image = null;
		private var _bossUnLock:Image = null;
		
		private var _buyHeroNoteTxt:Image = null;
		
		private var _buyHeroPhLock:Image = null;
		
		public function StoreView()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		public function buyBossSuccess():void
		{
			
//			_restoreBtn.visible = ProtoDataInfoModel.instance.isHeroLock;
		}
		
		override public function dispose():void
		{
			_bgMask.dispose();
			
			_closeImage.dispose();
			_buyHeroPh.dispose();
//			_alert.dispose();
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0, true);	
			}
		}
		
		override public function get width():Number
		{
			return Const.STAGE_WIDTH;
		}
		
		override public function get height():Number
		{
			return Const.STAGE_HEIGHT;
		}
		
		private function initView():void
		{
			_bgMask = new Shape();
			_bgMask.graphics.beginFill(0x000000);
			_bgMask.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			this.addChild(_bgMask);				
			_closeImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("closeBtn"));	
			_closeImage.y = _closeImage.height/2;
			_closeImage.x = Const.STAGE_WIDTH - _closeImage.width - 30;
			
			this.addChild(_closeImage);
			
			_buyHeroPh = new Image(assetManager.getTextureAtlas("gui_images").getTexture("heroPh"));			
			this.addChild(_buyHeroPh);
			_buyHeroPhLock = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bossLock"));
			this.addChild(_buyHeroPhLock);
			
//			_buyBossImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("buBoss"));
//			this.addChild(_buyBossImage);
			
			_buyHeroPh.x = Math.floor((Const.STAGE_WIDTH - _buyHeroPh.width)/2);	
			_buyHeroPh.y = Math.floor((Const.STAGE_HEIGHT - _buyHeroPh.height)/6)+30;	
			
			
			_buyHeroPhLock.scaleX = 2;
			_buyHeroPhLock.scaleY = 2;
			_buyHeroPhLock.x = _buyHeroPh.x + _buyHeroPhLock.width/2 + 20;
			_buyHeroPhLock.y = _buyHeroPh.y +_buyHeroPhLock.height/2;
			
//			_buyBossImage.x = _buyHeroPh.x + _buyHeroPh.width + 30;
//			_buyBossImage.y = _buyHeroPh.y;	
//			
			_bg = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeBg"));
			_bg.y =  Math.floor(_buyHeroPh.y + _buyHeroPh.height)+10;
			_bg.x =  Math.floor((Const.STAGE_WIDTH - _bg.width)/2);	
			this.addChild(_bg);
			
			_storeGoods1 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeImage1"));
			_storeGoods1.y = _bg.y + 55;
			_storeGoods1.x = _bg.x + 20;
			this.addChild(_storeGoods1);
			
			_storeGoods2 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeImage2"));
			_storeGoods2.y = _storeGoods1.y;
			_storeGoods2.x = _storeGoods1.x + _storeGoods1.width + 10;
			this.addChild(_storeGoods2);
			
			_storeGoods3 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeImage3"));
			_storeGoods3.y = _storeGoods1.y;
			_storeGoods3.x = _storeGoods2.x + _storeGoods2.width + 25;
			this.addChild(_storeGoods3);
			
			_storeGoods4 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeImage4"));
			_storeGoods4.y = _storeGoods1.y;
			_storeGoods4.x = _storeGoods3.x + _storeGoods3.width + 10;
			this.addChild(_storeGoods4);
			
//			_monsterUnLock = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeMonsterUnlock"));
//			_monsterUnLock.x = Math.floor(_buyHeroPh.x + _buyHeroPh.width )/2 + 80;
//			_monsterUnLock.y = Math.floor(_buyHeroPh.y + _buyHeroPh.height - _monsterUnLock.height)/2 + 50;
//			this.addChild(_monsterUnLock);
			
//			_bossUnLock = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeBossUnlock"));
//			_bossUnLock.x = Math.floor(_buyBossImage.x + _buyBossImage.width)/2 + 170;
//			_bossUnLock.y = Math.floor(_buyBossImage.y + _buyBossImage.height - _bossUnLock.height)/2 + 50;
//		
//			this.addChild(_bossUnLock);
//			
////			_monsterUnLock.alpha = .8;
//			_bossUnLock.alpha = .8;
//			_bossUnLock.touchable = false;
//			_bossUnLock.visible = !ProtoDataInfoModel.instance.isHeroLock;
			
			
			
//			_buyHeroNoteTxt = new Image(assetManager.getTextureAtlas("gui_images").getTexture("buyReborn"));	
//			_buyHeroNoteTxt.x = (Const.STAGE_WIDTH - _buyHeroNoteTxt.width)>>1;
//			_buyHeroNoteTxt.y = 50;
//			this.addChild(_buyHeroNoteTxt);	
//			
//			if(HeroStatusModel.instance.heroLifeCount == 0 &&HeroStatusModel.instance.heroCurrentHp == 0)
//				_buyHeroNoteTxt.visible = true;
//			else
//				_buyHeroNoteTxt.visible = false;
			
			
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			
//			_alert = new AlertView();
//			this.addChild(_alert);
			
			var lifeCount:Number = HeroStatusModel.instance.heroLifeCount;
//			if(lifeCount<1)
//			{
//				_buyHeroPhLock.visible = false;
//				_buyHeroPh.touchable = true;
//			}
//			else
//			{
//				_buyHeroPhLock.visible = true;
//				_buyHeroPh.touchable = false;
//			}
			
//			_restoreBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("restore"));	
//			_restoreBtn.x = Math.floor(_buyBossImage.x + _buyBossImage.width)/2+320 ;
//			_restoreBtn.y = Math.floor(_buyBossImage.y + _buyBossImage.height - _restoreBtn.height)/2 +50;
//			this.addChild(_restoreBtn);	
//			_restoreBtn.height = 
//			_restoreBtn.touchable = false;
			
//			_restoreBtn.visible = ProtoDataInfoModel.instance.isHeroLock;
		}
		
		private function addListeners():void
		{
			var closeTap:TapGestures = new TapGestures(_closeImage, closeViewHandler);
			var buyHeroPh:TapGestures = new TapGestures(_buyHeroPh, buyHeroPhHandler);
//			var buyBoss:TapGestures = new TapGestures(_buyBossImage, buyBosshandler);	
			var buyGoods1:TapGestures = new TapGestures(_storeGoods1, buyProtoHp10handler);
			var buyGoods2:TapGestures = new TapGestures(_storeGoods2, buyProtoHp50handler);
			var buyGoods3:TapGestures = new TapGestures(_storeGoods3, buyProtoMp5handler);
			var buyGoods4:TapGestures = new TapGestures(_storeGoods4, buyProtoMp30handler);
//			var restoreBtnTap:TapGestures = new TapGestures(_restoreBtn, restorehandler);
			
		}
		
		private function buyProtoMp30handler():void
		{
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.BUY_PROTO_HANDLER,true,ProcuctIdEnum.mp_recover_30);
		}
		
//		private function restorehandler():void
//		{
//			this.dispatchEventWith(NoteEvent.BUY_PROTO_HANDLER,true,ProcuctIdEnum.RESTORE);
//		}
		
		private function buyProtoMp5handler():void
		{
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.BUY_PROTO_HANDLER,true,ProcuctIdEnum.mp_recover_5);
		}
		
		private function buyProtoHp50handler():void
		{
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.BUY_PROTO_HANDLER,true,ProcuctIdEnum.hp_recover_50);
		}
		
		private function buyProtoHp10handler():void
		{
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.BUY_PROTO_HANDLER,true,ProcuctIdEnum.hp_recover_10);
		}
		
		private function buyBosshandler():void
		{
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			// TODO Auto Generated method stub
//			this.dispatchEventWith(NoteEvent.BUY_BOSS_HANDLER);
		}
		
		//购买3次英雄复活
		private function buyHeroPhHandler():void
		{
			// TODO Auto Generated method stub
			//ProcuctIdEnum.life_ph_3
//			infoCh("ProductStore.isSupported",ProductStore.isSupported);
			//购买成功返回
			this.dispatchEventWith(NoteEvent.BUY_HERO_PH_HANDLER);
		}
		
		private function closeViewHandler():void
		{
			this.dispatchEventWith(MainScenceEvent.STORE_CLOSE_BTN_CLICK, true);
		}
	}
}
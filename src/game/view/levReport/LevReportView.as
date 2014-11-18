package game.view.levReport
{
	import enum.MsgTypeEnum;
	import enum.RoleActionEnum;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.controlView.collDownBtn.CoolingActionBtn;
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	import game.view.enemySoldiers.animals.AnimalSoldierView;
	import game.view.enemySoldiers.basis.BaseSoldierAnimaView;
	import game.view.enemySoldiers.tall.TallSoldierAnimaView;
	import game.view.enemySoldiers.twoKnives.TwoKnivesSoldierAnimaView;
	import game.view.event.NoteEvent;
	import game.view.models.ControlleBarStatusModel;
	import game.view.models.HeroStatusModel;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * 关卡结算视图 
	 * @author admin
	 * 
	 */	
	public class LevReportView extends BaseViewer
	{
		private var _shap:Shape = null;
		private var _infoBg:Image = null;
		private var _useHpRecoverBtn:CoolingActionBtn = null;
		private var _useMpRecoverBtn:CoolingActionBtn = null;
		
		private var _phContainer:Sprite = null;
		private var _phIconarr:Array = null;
		private var _nextLev:Image = null;
		private var _storeImage:Image = null;
		
		private var _baseSoldierAnimaView:BaseSoldierAnimaView = null;
		private var _animalSoldierView:AnimalSoldierView = null;
		private var _tallSoldierView:TallSoldierAnimaView = null;
		private var _twoKnivesSoldierAnimaView:TwoKnivesSoldierAnimaView = null;
		
		private var _statusModel:ControlleBarStatusModel = null;
		private var _hpCount:Number = 0;
		private var _mpCount:Number = 0;
		private var _hpImage:Image = null;
		private var _mpImage:Image = null;
		private var _heroStatusModel:HeroStatusModel = null;
		
		public function LevReportView()
		{
			super();
			initView();
			this.initModel();
			addListeners();
			
			
			_hpCount = ProtoDataInfoModel.instance.hpProtoCount;
			_mpCount = ProtoDataInfoModel.instance.mpProtoCount;
		}
		
		public function setHeroLifeCount(count:Number):void
		{
			if(count>6)
				count = 6;
			var iconImage:Image = null;
			for(var i:Number = 0; i < count; i++)
			{
				iconImage = _phIconarr[i];
				iconImage.visible = true;
			}
			while(count < _phIconarr.length)
			{
				iconImage = _phIconarr[count];
				iconImage.visible = false;
				count++;
			}
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName ==  MsgTypeEnum.HERO_HP_UPDATE ||msgName ==  MsgTypeEnum.HERO_HP_ADD_UPDATE)
			{
				var heroHpRatio:Number = data as Number;
				if(heroHpRatio>0)
					_hpImage.scaleX = heroHpRatio;
				else
					_hpImage.visible = false;
			}
			
			if(msgName ==  MsgTypeEnum.HERO_MP_UPDATE)
			{
				var heroMpRatio:Number = data as Number;
				if(heroMpRatio>0)
					_mpImage.scaleX = heroMpRatio;
				else
					_mpImage.visible = false;
			}
		}
		override public function initModel():void
		{
			_statusModel = ControlleBarStatusModel.instance;
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
		}
		
		public function refershProtoCount(hpCount:Number,mpCount:Number,liftCount:Number):void
		{
			setHeroLifeCount(liftCount);
		}
		
		public function refershHpPtotoCount(count:Number):void
		{
			_useHpRecoverBtn.initCount(count);
		}
		
		public function refershMpPtotoCount(count:Number):void
		{
			_useMpRecoverBtn.initCount(count);
		}
		
		private function initView():void
		{
			_shap = new Shape(); 
			_shap.graphics.beginFill(0x999999);
			_shap.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			this.addChild(_shap);
			
			_infoBg =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("lifeBg"));
			_infoBg.x = 20;
			_infoBg.y = 45;
			this.addChild(_infoBg);
			
			_useHpRecoverBtn = new CoolingActionBtn();
			_useHpRecoverBtn.x = 155;
			_useHpRecoverBtn.y = 120;			
			this.addChild(_useHpRecoverBtn);
			_useHpRecoverBtn.setMovesType(RoleActionEnum.RECOVER_HP);
			
			_useMpRecoverBtn = new CoolingActionBtn();
			_useMpRecoverBtn.x = 270;
			_useMpRecoverBtn.y = 120;			
			this.addChild(_useMpRecoverBtn);
			_useMpRecoverBtn.setMovesType(RoleActionEnum.RECOVER_MP);
			
			
			_phContainer = new Sprite();
			this.addChild(_phContainer);
			_phContainer.x = 525;
			_phContainer.y = 35;
			
			initRebornImage();
			
			_nextLev = new Image(assetManager.getTextureAtlas("gui_images").getTexture("nextLev"));
			_nextLev.y = 560;
			_nextLev.x = Const.STAGE_WIDTH - _nextLev.width - 150;
			this.addChild(_nextLev);
			
			_storeImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("store"));
			_storeImage.y = _nextLev.y;
			_storeImage.x =  150;
			this.addChild(_storeImage);
			
			_hpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("hpValueBar"));
			_hpImage.x = 108;
			_hpImage.y = 22+23.5 + 25;
			this.addChild(_hpImage);
			
			_mpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("mpValueBar"));
			
			_mpImage.x = 109;
			_mpImage.y = 37+32.5 + 25;
			this.addChild(_mpImage);	
			
//			_animalSoldierView = new AnimalSoldierView();
//			_animalSoldierView.doAttackLoop();
//			_animalSoldierView.scaleX = -1.3;
//			_animalSoldierView.scaleY = 1.3;
//			_animalSoldierView.x = 200;
//			_animalSoldierView.y = Const.STAGE_HEIGHT/2 + 100;
//			this.addChild(_animalSoldierView);
//			
//			
//			_baseSoldierAnimaView = new BaseSoldierAnimaView();
//			_baseSoldierAnimaView.scaleX = -1.3;
//			_baseSoldierAnimaView.scaleY = 1.3;
//			_baseSoldierAnimaView.x = 400;
//			_baseSoldierAnimaView.y = Const.STAGE_HEIGHT/2 + 50;
//			_baseSoldierAnimaView.doAttackLoop();
//			this.addChild(_baseSoldierAnimaView);
//			
//			_tallSoldierView = new TallSoldierAnimaView();
//			_tallSoldierView.doAttackLoop();
//			_tallSoldierView.scaleX = -1.3;
//			_tallSoldierView.scaleY = 1.3;
//			_tallSoldierView.x = 600;
//			_tallSoldierView.y = Const.STAGE_HEIGHT/2 - 10;
//			this.addChild(_tallSoldierView);
//			
//			_twoKnivesSoldierAnimaView = new TwoKnivesSoldierAnimaView();
//			_twoKnivesSoldierAnimaView.doAttackLoop();
//			_twoKnivesSoldierAnimaView.scaleX = -1.3;
//			_twoKnivesSoldierAnimaView.scaleY = 1.3;
//			_twoKnivesSoldierAnimaView.x = 700;
//			_twoKnivesSoldierAnimaView.y = Const.STAGE_HEIGHT/2 - 100;
//			this.addChild(_twoKnivesSoldierAnimaView);
		}
		
		private function addListeners():void
		{
			var showStoreTap:TapGestures = new TapGestures(_storeImage, showStoreHandler);
			var nextLevTap:TapGestures = new TapGestures(_nextLev, nextLevHandler);
			
			var useHpTab:TapGestures = new TapGestures(_useHpRecoverBtn, useHpRecoverhandler);
			var useMpTab:TapGestures = new TapGestures(_useMpRecoverBtn, useMpRecoverhandler);
		}	
		
		private function useMpRecoverhandler():void
		{
			_useMpRecoverBtn.startColldown(20);	
			_mpCount--;
			ProtoDataInfoModel.instance.mpProtoCount = _mpCount;
			// TODO Auto Generated method stub
			_statusModel.noteUseProp(RoleActionEnum.RECOVER_MP);
		}
		
		private function useHpRecoverhandler():void
		{
			_useHpRecoverBtn.startColldown(20);	
			_hpCount--;
			ProtoDataInfoModel.instance.hpProtoCount = _hpCount;
			// TODO Auto Generated method stub
			_statusModel.noteUseProp(RoleActionEnum.RECOVER_HP);
		}
		
		private function nextLevHandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.SHOW_NEXT_LEV);
		}
		
		private function showStoreHandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.SHOW_STORE);
		}
		
		private function initRebornImage():void
		{
			var rowX:Number = 0;
			var rowY:Number = 0;
			
			_phIconarr = [];
			for(var i:Number = 0; i < 6; i++)
			{
				var phBgImage:Image = new Image(assetManager.getTextureAtlas("gui_images").getTexture("phBg")); 
				var phIconImage:Image = new Image(assetManager.getTextureAtlas("gui_images").getTexture("rebornIcon")); 
				_phContainer.addChild(phBgImage);
				_phContainer.addChild(phIconImage);
				if(i == 3)
					rowX = 0;
				if(i > 2)
					rowY = 1;
				phBgImage.x = rowX * 120;
				phBgImage.y = rowY * 90;	
				phIconImage.x = phBgImage.x + 1;
				phIconImage.y = phBgImage.y + 1;
				_phIconarr.push(phIconImage);
				rowX++;
			}
		}
	}
}
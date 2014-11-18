package game.view.welcomeScence
{
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	import starling.utils.deg2rad;
	
	/**
	 * 主菜单视图 
	 * @author admin
	 * 
	 */	
	public class MainMenuView extends BaseViewer
	{
		private var _mainBg:Image = null;
		private var _mainBgLogo:Image = null;
		private var _battleModeBtn:Image = null;
		private var _callMeBtn:Image = null;
		private var _surBtn:Image = null;
		private var _shareToWXBtn:Image = null;
		private var _pingfenBtn:Image = null;
		public function MainMenuView()
		{
			super();
			this.initView();
			this.addGestures();
		}
		
		private function initView():void
		{
			_mainBg = new Image(assetManager.getTextureAtlas("gui_images").getTexture("menuBg"));	
			this.addChild(_mainBg);
			
			_mainBgLogo  = new Image(assetManager.getTextureAtlas("gui_images").getTexture("menuLogo"));	
			_mainBgLogo.x = _mainBg.x + 279/2;
			_mainBgLogo.y = _mainBg.y + 272/2;
			this.addChild(_mainBgLogo);
			
			
			_battleModeBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("gushi"));
			_battleModeBtn.x = _mainBg.x + 300;
			_battleModeBtn.y = _mainBg.y + 45;
			_battleModeBtn.rotation = deg2rad(23);
			this.addChild(_battleModeBtn);
			
			_callMeBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("callMe"));
			_callMeBtn.x = _mainBg.x + 70;
			_callMeBtn.y = _mainBg.y + 275;
			_callMeBtn.rotation = deg2rad(60);
			this.addChild(_callMeBtn);
			
			_surBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("shengcun"));
			_surBtn.x = _mainBg.x + 50;
			_surBtn.y = _mainBg.y + 190;
			_surBtn.rotation = deg2rad(-50);
			this.addChild(_surBtn);
			
			_shareToWXBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("share"));
			_shareToWXBtn.x = _mainBg.x + 175;
			_shareToWXBtn.y = _mainBg.y + 455;
			_shareToWXBtn.rotation = deg2rad(-14);
			this.addChild(_shareToWXBtn);
			
			_pingfenBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("pingfen"));
			
			_pingfenBtn.x = _mainBg.x + 480;
			_pingfenBtn.y = _mainBg.y + 250;
			_pingfenBtn.rotation = deg2rad(90);
			this.addChild(_pingfenBtn);
		}
		
		private function addGestures():void
		{
			var tapContinue:TapGestures = new TapGestures(_battleModeBtn, battleModelBtnTapHandler);
			var surBtnContinue:TapGestures = new TapGestures(_surBtn, surModelBtnTapHandler);	
			var callMeBtnTap:TapGestures = new TapGestures(_callMeBtn, callMeBtnTapHandler);
			
			var moreBtnTap:TapGestures = new TapGestures(_shareToWXBtn, shareToWeiXinBtnTapHandler);
			var pingfenBtn:TapGestures = new TapGestures(_pingfenBtn, pingfenBtnTapHandler);
			var mainBgLogoTap:TapGestures = new TapGestures(_mainBgLogo, pingfenBtnTapHandler);
			
		}
		
		private function pingfenBtnTapHandler():void
		{
			// TODO Auto Generated method stub
//			var _newURL:URLRequest = new URLRequest(Const.PINGFENG_URL);
//			var _fangshi:String="_blank";
//			navigateToURL(_newURL,_fangshi);
			this.dispatchEventWith(MainScenceEvent.GOTO_GIVE_SCORE, true);
		}
		
		private function shareToWeiXinBtnTapHandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(MainScenceEvent.SHARE_TO_WEIXIN, true);
		}
		
		private function callMeBtnTapHandler():void
		{
			this.dispatchEventWith(MainScenceEvent.CALL_ME, true);
		}	
		
		private function battleModelBtnTapHandler():void
		{
			this.dispatchEventWith(MainScenceEvent.BATTLE_MODEL_BTN_CLICK, true);
		}
		
		private function surModelBtnTapHandler():void
		{
			this.dispatchEventWith(MainScenceEvent.SURVIVAL_MODEL_BTN_CLICK, true);
		}
			
	}
}
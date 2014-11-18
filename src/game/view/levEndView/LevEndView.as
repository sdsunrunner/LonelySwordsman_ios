package game.view.levEndView
{
	
	
	import extend.draw.display.Shape;
	
	import font.Font;
	import font.Fonts;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	
	import lzm.starling.gestures.TapGestures;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * 关卡结束视图 
	 * @author admin
	 * 
	 */	
	public class LevEndView extends BaseViewer
	{
		private var _continue:Image = null;			
		private var _menu:Image = null;
		private var _giveScore:Image = null;
		private var _shareToWeiXin:Image = null;
		private var _shareToWeiBo:Image = null;
		private var _shap:Shape = null;
		
		private var _dogIcon:Image = null;
		private var _dogIconGrey:Image = null;
		private var _basicSoldierIcon:Image = null;
		private var _basicSoldierIconGrey:Image = null;
		private var _tallSoldierIcon:Image = null;
		private var _tallSoldierIconGrey:Image = null;
		private var _twoknivesSoldierIcon:Image = null;
		private var _twoknivesSoldierIconGrey:Image = null;
		private var _killCountImage:Image = null;
		private var _dogCountBg:EnemyCountInfoView = null;
		private var _basicSoldierCountBg:EnemyCountInfoView = null;
		private var _tallSoldierCountBg:EnemyCountInfoView = null;
		private var _twoknivesSoldierCountBg:EnemyCountInfoView = null;
		
		private var _reportModel:LevReportInfomodel = LevReportInfomodel.instance;
		
		private var fontRegular:Font;
		
		/** About text field. */
		private var infoText:TextField;		
		private var _playerInfo:ObjPlayerInfo = null;
		private var _enemyInfoBox:Sprite = null;
		public function LevEndView()
		{
			super();
			initView();
			setCountInfo();
			addListeners();
			
			
			if(!_playerInfo)
				_playerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			
			var killCount:Number = _playerInfo.killCount;
			setkillCountInfo(killCount);
		}
		
		private function setCountInfo():void
		{
			_dogCountBg.setCountInfo(_reportModel.killDog);
			_basicSoldierCountBg.setCountInfo(_reportModel.killBaseSoldier);
			_tallSoldierCountBg.setCountInfo(_reportModel.killTallSoldier);
			_twoknivesSoldierCountBg.setCountInfo(_reportModel.killTwoKinfeSoldier);
			
			_dogIconGrey.visible = _reportModel.killDog == 0;
			_basicSoldierIconGrey.visible = _reportModel.killBaseSoldier == 0;
			_tallSoldierIconGrey.visible = _reportModel.killTallSoldier == 0;
			_twoknivesSoldierIconGrey.visible = _reportModel.killTwoKinfeSoldier == 0;
		}
		
		private function setkillCountInfo(count:Number):void
		{
			if(!infoText)
			{
				fontRegular = Fonts.getFont("ScoreValue");
				infoText = new TextField(225, 40, "", fontRegular.fontName, 34, 0xff0000);
				infoText.x = _killCountImage.x + 240;
				infoText.y = 20;
				infoText.hAlign = HAlign.CENTER;
				infoText.vAlign = VAlign.TOP;
				this.addChild(infoText);
			}
			infoText.text = count.toString();
		}
		
		
		private function initView():void
		{
			_shap = new Shape(); 
			_shap.graphics.beginFill(0x999999);
			_shap.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			this.addChild(_shap);
			
			_killCountImage =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("killCount"));
			_killCountImage.x = (Const.STAGE_WIDTH - _killCountImage.width)/2;
			_killCountImage.y = 10;
			this.addChild(_killCountImage);
			
			_enemyInfoBox = new Sprite();
			_enemyInfoBox.y = 50;
			this.addChild(_enemyInfoBox);
			
			_dogCountBg = new EnemyCountInfoView();
			_dogCountBg.x = 172;
			_dogCountBg.y = 140;
			_enemyInfoBox.addChild(_dogCountBg);
			
			_dogIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("dogIcon"));
			_dogIcon.x = 105;
			_dogIcon.y = 180;
			_enemyInfoBox.addChild(_dogIcon);
			
			_dogIconGrey = new Image(assetManager.getTextureAtlas("gui_images").getTexture("dogIconGrey"));
			_dogIconGrey.x = 102;
			_dogIconGrey.y = 180;
			_enemyInfoBox.addChild(_dogIconGrey);
			
			_basicSoldierCountBg = new EnemyCountInfoView();
			_basicSoldierCountBg.x = 360;
			_basicSoldierCountBg.y = 65;
			_enemyInfoBox.addChild(_basicSoldierCountBg);
			
			_basicSoldierIconGrey= new Image(assetManager.getTextureAtlas("gui_images").getTexture("baseSoldierIconGrey"));
			_basicSoldierIconGrey.x = 590;
			_basicSoldierIconGrey.y = 75;
			_enemyInfoBox.addChild(_basicSoldierIconGrey);
			
			_basicSoldierIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("basicSoldierIcon"));
			_basicSoldierIcon.x = 292;
			_basicSoldierIcon.y = 77;
			_enemyInfoBox.addChild(_basicSoldierIcon);
			
			
			_tallSoldierCountBg = new EnemyCountInfoView();
			_tallSoldierCountBg.x = 580;
			_tallSoldierCountBg.y = 41;
			_enemyInfoBox.addChild(_tallSoldierCountBg);
			
			_tallSoldierIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("tallSoldierIcon"));
			_tallSoldierIcon.x = 511;
			_tallSoldierIcon.y = 60;
			_enemyInfoBox.addChild(_tallSoldierIcon);
			
			_tallSoldierIconGrey= new Image(assetManager.getTextureAtlas("gui_images").getTexture("tallSoldierIconGrey"));
			_tallSoldierIconGrey.x = 503;
			_tallSoldierIconGrey.y = 52;
			_enemyInfoBox.addChild(_tallSoldierIconGrey);
			
			
			_twoknivesSoldierCountBg = new EnemyCountInfoView();
			_twoknivesSoldierCountBg.x = 823;
			_twoknivesSoldierCountBg.y = 70;
			_enemyInfoBox.addChild(_twoknivesSoldierCountBg);
			
			_twoknivesSoldierIcon= new Image(assetManager.getTextureAtlas("gui_images").getTexture("twoknivesSoldierIcon"));
			_twoknivesSoldierIcon.x = 763;
			_twoknivesSoldierIcon.y = 90;
			_enemyInfoBox.addChild(_twoknivesSoldierIcon);
			
			_twoknivesSoldierIconGrey= new Image(assetManager.getTextureAtlas("gui_images").getTexture("twoKnifeSoldierIconGrey"));
			_twoknivesSoldierIconGrey.x = 760;
			_twoknivesSoldierIconGrey.y = 90;
			_enemyInfoBox.addChild(_twoknivesSoldierIconGrey);
			
			
			_menu = new Image(assetManager.getTextureAtlas("gui_images").getTexture("menu"));
			this.addChild(_menu);
			_menu.x = 100;
			_menu.y = 250 + 70;
			
			_giveScore = new Image(assetManager.getTextureAtlas("gui_images").getTexture("giveScore"));
			_giveScore.x = Const.STAGE_WIDTH - _giveScore.width-100;
			_giveScore.y = (Const.STAGE_HEIGHT)/2 + 120 + 30;
			this.addChild(_giveScore);
			
			_continue = new Image(assetManager.getTextureAtlas("gui_images").getTexture("continue"));
			this.addChild(_continue);
			_continue.x = _giveScore.x;
			_continue.y =  _menu.y;
			
			
			_shareToWeiXin = new Image(assetManager.getTextureAtlas("gui_images").getTexture("levShare"));
			if(Const.SHARE_TO_SINA_WEIBO)
				_shareToWeiXin.x = _menu.x;
			else
				_shareToWeiXin.x = _menu.x;
//				_shareToWeiXin.x = (Const.STAGE_WIDTH - _shareToWeiXin.width)>>1;
			
			_shareToWeiXin.y =  _giveScore.y;
			this.addChild(_shareToWeiXin);
			
			_shareToWeiBo = new Image(assetManager.getTextureAtlas("gui_images").getTexture("shareToWeiBo")); 
			if(Const.SHARE_TO_SINA_WEIBO)
				this.addChild(_shareToWeiBo);
			_shareToWeiBo.x = _continue.x;
			_shareToWeiBo.y = _shareToWeiXin.y;			
		}
		
		private function addListeners():void
		{
			var continueTap:TapGestures = new TapGestures(_continue, continueHandler);
			var menuTap:TapGestures = new TapGestures(_menu, menuTabhandler);
			var giveScoreTap:TapGestures = new TapGestures(_giveScore, giveScoreTabhandler);
			var shareToWeiXinTap:TapGestures = new TapGestures(_shareToWeiXin,shareToWeiXinTabhandler);
			var shareToWeiBoTap:TapGestures = new TapGestures(_shareToWeiBo,shareToWeiBoTabhandler);
		}
		
		private function shareToWeiBoTabhandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(MainScenceEvent.SHARE_TO_WEIBO);
		}
		
		private function shareToWeiXinTabhandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(MainScenceEvent.SHARE_TO_WEIXIN);
		}
		
		private function giveScoreTabhandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(MainScenceEvent.GOTO_GIVE_SCORE);
		}
		
		private function continueHandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(MainScenceEvent.GAME_LEV_CONTINUE);
		}
		
		private function menuTabhandler():void
		{
			this.dispatchEventWith(MainScenceEvent.SHOW_MAIN_MENU);
		}
	}
}
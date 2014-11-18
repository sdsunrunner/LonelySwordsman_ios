package game.view.gameEndMenu
{
	import extend.draw.display.Shape;
	
	import font.Font;
	import font.Fonts;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	import game.view.survivalMode.SurvivalModeDataModel;
	
	import lzm.starling.gestures.TapGestures;
	
	import playerData.GamePlayerDataProxy;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * 生存模式结束视图 
	 * @author admin
	 * 
	 */	
	public class SurverModeGameEndView extends BaseViewer
	{
		private var _scoreNote:Image = null;
		private var _bestScoreNote:Image = null;
		private var _fontRegular:Font;
		
		/** About text field. */
		private var _scoreinfoText:TextField;
		private var _bestScoreinfoText:TextField;
		private var _shareToWeiXin:Image = null;
		private var _shareToWeiBo:Image = null;
		
		private var _closeImage:Image = null;
		private var _bg:Shape = null;
		public function SurverModeGameEndView()
		{
			super();
			this.initView();
			this.addEventListeners();
		}
		
		override public function dispose():void
		{
			_fontRegular = null;
			_scoreinfoText = null;
			if(_scoreNote)
			{
				_scoreNote.dispose();
			}
			
			_scoreNote = null;
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		private function initView():void
		{
			_bg = new Shape();
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			this.addChild(_bg);
			
			_scoreNote = new Image(assetManager.getTextureAtlas("gui_images").getTexture("score"));
			
			_scoreNote.x = (Const.STAGE_WIDTH - _scoreNote.width)/2;
			_scoreNote.y =  (Const.STAGE_HEIGHT - _scoreNote.height)/2 - 150;
			this.addChild(_scoreNote);
			
			_bestScoreNote = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bestScore"));
			_bestScoreNote.x = _scoreNote.x;
			_bestScoreNote.y = _scoreNote.y + 80 ;
			this.addChild(_bestScoreNote);
			
			if(!_scoreinfoText)
			{
				_fontRegular = Fonts.getFont("ScoreValue");
				_scoreinfoText = new TextField(300, 50, "", _fontRegular.fontName, 40, 0xff0000);
				_scoreinfoText.x = _scoreNote.x + 200;
				_scoreinfoText.y = _scoreNote.y + 10;
				_scoreinfoText.text = SurvivalModeDataModel.instance.score + "";
				_scoreinfoText.hAlign = HAlign.LEFT;
				_scoreinfoText.vAlign = VAlign.TOP;
				this.addChild(_scoreinfoText);
			}
			
			if(!_bestScoreinfoText)
			{
				_fontRegular = Fonts.getFont("ScoreValue");
				_bestScoreinfoText = new TextField(300, 50, "", _fontRegular.fontName, 40, 0xff0000);
				_bestScoreinfoText.x = _scoreNote.x + 200;
				_bestScoreinfoText.y = _bestScoreNote.y + 10;
				_bestScoreinfoText.text = GamePlayerDataProxy.instance.getPlayerInfo().surverModeBestScore + "";
				_bestScoreinfoText.hAlign = HAlign.LEFT;
				_bestScoreinfoText.vAlign = VAlign.TOP;
				this.addChild(_bestScoreinfoText);
			}
			
			_shareToWeiXin = new Image(assetManager.getTextureAtlas("gui_images").getTexture("levShare"));
			_shareToWeiXin.y = _scoreNote.y + _scoreNote.height + 175;
			if(Const.SHARE_TO_SINA_WEIBO)
				_shareToWeiXin.x = 150;
			else
				_shareToWeiXin.x = (Const.STAGE_WIDTH - _shareToWeiXin.width)/2;
			
			this.addChild(_shareToWeiXin);
			
			_shareToWeiBo = new Image(assetManager.getTextureAtlas("gui_images").getTexture("shareToWeiBo")); 
			if(Const.SHARE_TO_SINA_WEIBO)
				this.addChild(_shareToWeiBo);
			_shareToWeiBo.x =  Const.STAGE_WIDTH - _shareToWeiBo.width - 150;
			_shareToWeiBo.y = _shareToWeiXin.y;
			
			_closeImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("closeBtn"));			
			this.addChild(_closeImage);
			
			_closeImage.y = _closeImage.height/2;
			_closeImage.x = Const.STAGE_WIDTH - _closeImage.width - 30;
			
		}
		
		private function addEventListeners():void
		{
			var closeTap:TapGestures = new TapGestures(_closeImage, closeViewHandler);
			var shareTap:TapGestures = new TapGestures(_shareToWeiXin, shareToWeiXinHandler);
			var shareToWeiBoGes:TapGestures = new TapGestures(_shareToWeiBo, shareToWeiBoHandler);
		}
		
		private function shareToWeiXinHandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(MainScenceEvent.SHARE_TO_WEIXIN,true);
		}
		
		private function shareToWeiBoHandler():void
		{
			this.dispatchEventWith(MainScenceEvent.SHARE_TO_WEIBO,true);
		}
		
		private function closeViewHandler():void
		{
			this.dispatchEventWith(MainScenceEvent.CLOSE_BATTLE_END_RESULR_VIEW,true);
		}
	}
}
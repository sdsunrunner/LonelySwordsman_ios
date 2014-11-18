package game.view.infoAlert
{
	import font.Font;
	import font.Fonts;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.NoteEvent;
	import game.view.survivalMode.SurvivalModeDataModel;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * 生存模式结算提示 
	 * @author admin
	 * 
	 */	
	public class SurverModeInfoViewAlert extends BaseViewer
	{
		private var _scoreNote:Image = null;
		private var _fontRegular:Font;
		
		/** About text field. */
		private var _infoText:TextField;
		private var _shareToWeiXin:Image = null;
		public function SurverModeInfoViewAlert()
		{
			super();
			this.initView();
		}
		
		override public function dispose():void
		{
			_fontRegular = null;
			_infoText = null;
			_scoreNote.dispose();
			_scoreNote = null;
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		private function initView():void
		{
			_scoreNote = new Image(assetManager.getTextureAtlas("gui_images").getTexture("score"));
			
			_scoreNote.x = 100;
			_scoreNote.y = 0;
			this.addChild(_scoreNote);
			
			if(!_infoText)
			{
				_fontRegular = Fonts.getFont("ScoreValue");
				_infoText = new TextField(300, 50, "", _fontRegular.fontName, 40, 0xff0000);
				_infoText.x = 230;
				_infoText.y = 10;
				_infoText.text = SurvivalModeDataModel.instance.score + "";
				_infoText.hAlign = HAlign.LEFT;
				_infoText.vAlign = VAlign.TOP;
				this.addChild(_infoText);
			}
			
			_shareToWeiXin = new Image(assetManager.getTextureAtlas("gui_images").getTexture("levShare"));
			_shareToWeiXin.y = _scoreNote.y + _scoreNote.height + 45;
			_shareToWeiXin.x = (this.width - _shareToWeiXin.width)/2 + 10;
			this.addChild(_shareToWeiXin);
			
			var shareTap:TapGestures = new TapGestures(_shareToWeiXin, shareToWeiXinHandler);
		}
		
		private function shareToWeiXinHandler():void
		{
			// TODO Auto Generated method stub
			this.dispatchEventWith(NoteEvent.SHARE_SURVER_MODEL_SCORE);
		}
	}
}
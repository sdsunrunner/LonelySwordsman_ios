package game.view.levEndView
{
	import font.Font;
	import font.Fonts;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * 击杀敌人数目信息 
	 * @author admin
	 * 
	 */	
	public class EnemyCountInfoView extends BaseViewer
	{
		private var _countBg:Image = null;
		private var fontRegular:Font;
		
		/** About text field. */
		private var infoText:TextField;		
		public function EnemyCountInfoView()
		{
			super();
			initView();
		}
		
		public function setCountInfo(count:Number):void
		{
			if(!infoText)
			{
				fontRegular = Fonts.getFont("ScoreValue");
				infoText = new TextField(70, 40, "", fontRegular.fontName, 30, 0xff0000);
				infoText.x = 20;
				infoText.y = 10;
				infoText.hAlign = HAlign.LEFT;
				infoText.vAlign = VAlign.TOP;
				this.addChild(infoText);
			}
			infoText.text = count.toString();
			
		
			infoText.visible = count>0;
			_countBg.visible = count>0;
		
		}
		
		private function initView():void
		{
			_countBg = new Image(assetManager.getTextureAtlas("gui_images").getTexture("countBg"));
			_countBg.x = 0;
			_countBg.y = 0;
			this.addChild(_countBg);
		}
	}
}
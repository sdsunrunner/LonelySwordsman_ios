package game.view.gameEndMenu
{
	import com.greensock.TweenMax;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.event.MainScenceEvent;
	import game.view.models.HeroStatusModel;
	
	import lzm.starling.gestures.TapGestures;
	
	import playerData.GamePlayerDataProxy;
	
	import starling.display.Image;
	
	/**
	 * 对决模式游戏结束视图 
	 * @author admin
	 * 
	 */	
	public class BattModeGameEndView extends BaseViewer
	{
		private var _bg:Shape = null;
		private var _resultImage:Image = null;
//		private var _phImage:Image = null;
		private var _shareToWeiXinImage:Image = null;
		private var _shareToWeiBo:Image = null;
		private var _closeImage:Image = null;
		
		public function BattModeGameEndView()
		{
			super();
		}
		
		public function showResult(win:Boolean):void
		{
			_bg = new Shape();
			_bg.graphics.beginFill(0x000000);
			_bg.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			this.addChild(_bg);
			if(win)			
				_resultImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("win"));
			else
				_resultImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("fail"));
//			_phImage =new Image(assetManager.getTextureAtlas("gui_images").getTexture("heroPhIcon"));
//			
//			_phImage.x = (Const.STAGE_WIDTH -_phImage.width )/2;
//			_phImage.y = (Const.STAGE_HEIGHT -_phImage.height )/2;	
//			_phImage.alpha = 0.0;
//			this.addChild(_phImage);
			
			_resultImage.x = (Const.STAGE_WIDTH -_resultImage.width )/2;
			_resultImage.y = (Const.STAGE_HEIGHT -_resultImage.height )/2 - _resultImage.height + 50;	
			
			this.addChild(_resultImage);
			
			_shareToWeiXinImage =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("levShare"));
			this.addChild(_shareToWeiXinImage);
			if(Const.SHARE_TO_SINA_WEIBO)
				_shareToWeiXinImage.x = 150;
			else
				_shareToWeiXinImage.x = (Const.STAGE_WIDTH - _shareToWeiXinImage.width)/2;
			_shareToWeiXinImage.y = (Const.STAGE_HEIGHT - _shareToWeiXinImage.height)/2 + 50;
//			_shareToWeiXinImage.visible = false;	
			
			_shareToWeiBo = new Image(assetManager.getTextureAtlas("gui_images").getTexture("shareToWeiBo")); 
			if(Const.SHARE_TO_SINA_WEIBO)
				this.addChild(_shareToWeiBo);
			_shareToWeiBo.x = Const.STAGE_WIDTH - _shareToWeiBo.width - 150;
			_shareToWeiBo.y = _shareToWeiXinImage.y;
			
			if(win)	
			{
				this.checkResult();
			}
			
			_closeImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("closeBtn"));			
			this.addChild(_closeImage);
			
			_closeImage.y = _closeImage.height/2;
			_closeImage.x = Const.STAGE_WIDTH - _closeImage.width - 30;
			
			addListeners();
			
		}
		
		private function addListeners():void
		{
			var shareGes:TapGestures = new TapGestures(_shareToWeiXinImage, shareToWeiXinHandler);
			var shareToWeiBoGes:TapGestures = new TapGestures(_shareToWeiBo, shareToWeiBoHandler);
			var closeTap:TapGestures = new TapGestures(_closeImage, closeViewHandler);
		}
		
		private function checkResult():void
		{
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS)
				getPhProto();
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER)
			{
				if(Math.random()>.85)
					getPhProto();
			}
		}
		
		private function getPhProto():void
		{
			var lifeCount:Number = HeroStatusModel.instance.heroLifeCount;			
			if(lifeCount<3)
			{
//				TweenMax.to(_phImage,0.2,{alpha:0.6});
				lifeCount = lifeCount+1; 
				HeroStatusModel.instance.heroLifeCount = lifeCount;
				GamePlayerDataProxy.instance.saveGamelLevInfo();
			}
		}
		
		private function shareToWeiXinHandler():void
		{
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
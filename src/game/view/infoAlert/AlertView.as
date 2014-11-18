package game.view.infoAlert
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import enum.ProcuctIdEnum;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.NoteEvent;
	
	import lzm.starling.gestures.TapGestures;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * 商店信息弹出框 
	 * @author admin
	 * 
	 */	
	public class AlertView extends BaseViewer
	{
		private var _bgPanel:Image = null;
		private var _closeBtn:Image = null;
		
//		private var _noteBossUnlock:Image = null;
		private var _noteBuySuccess:Image = null;
		
		private var _noteStoreClose:Image = null;
		private var _noteBuyIng:Image = null;
		private var _noteresorefail:Image = null;
		
		private var _bgMask:Shape = null;
		private var _noteArr:Array = [];
		private var _panelContent:Sprite = null;
		
		private var _noteType:String = "";
	
		
		private var _surverModeInfoViewAlert:SurverModeInfoViewAlert = null;
		
		public function AlertView()
		{
			super();
			this.initView();
			this.addListeners();
		}
		
		public function setNoteType(noteType:String):void
		{
			_noteType = noteType;
			this.visible = true;
			this.touchable = true;
			TweenLite.to(_panelContent, 0.2, {transformAroundCenter:{scaleX:0, scaleY:0},onComplete:showNotePanel});
		}
		
		override public function dispose():void
		{
			if(this.parent)
				this.parent.removeChild(this);
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true)
			}
		}
		private function addListeners():void
		{
			var closeTap:TapGestures = new TapGestures(_closeBtn, closeViewHandler);
//			var shareTap:TapGestures = new TapGestures(_shareToWeiXinBtn, shareBossUnlock);
		}
		
		private function showNotePanel():void
		{
			_panelContent.x = (Const.STAGE_WIDTH - _panelContent.width)/2;
			_panelContent.y = (Const.STAGE_HEIGHT - _panelContent.height)/2;
			
			TweenLite.to(_panelContent, 1, {transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
			
			for each(var noteImage:DisplayObject in _noteArr)
			{
				noteImage.visible = false;
			}
			
			switch(_noteType)
			{
				case ProcuctIdEnum.store_close:
					_noteBuyIng.visible = true;
					break;
				
				case ProcuctIdEnum.store_close:
					_noteStoreClose.visible = true;	
					break;
				
				case ProcuctIdEnum.buy_fail:
					_noteresorefail.visible = true;	
					break;				
			}
		}
		
		
		private function initView():void
		{
			_bgMask = new Shape();
			_bgMask.graphics.beginFill(0x000000);
			_bgMask.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			this.addChild(_bgMask);
			_bgMask.alpha = 0.8;
			
			_panelContent = new Sprite();
			_panelContent.scaleX = 0;
			_panelContent.scaleY = 0;
			this.addChild(_panelContent);
			
			_bgPanel = new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeViewAlertBg"));	
			_closeBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("closeBtn"));	
			_noteBuySuccess = new Image(assetManager.getTextureAtlas("gui_images").getTexture("buySuccess"));	
			
			
			_bgPanel.x = (Const.STAGE_WIDTH - _bgPanel.width)/2;
			_bgPanel.y = (Const.STAGE_HEIGHT - _bgPanel.height)/2;
			
			_panelContent.addChild(_bgPanel);
			_closeBtn.width = 50;
			_closeBtn.height = 50;
			_closeBtn.x =_bgPanel.x +  _bgPanel.width - _closeBtn.width/2;
			_closeBtn.y =_bgPanel.y-  _closeBtn.height/2;
			_panelContent.addChild(_closeBtn);
			
			
//			_noteBossUnlock  =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("unlockSuccessNote"));
//			_noteBossUnlock.x =  (Const.STAGE_WIDTH - _noteBossUnlock.width)/2;
//			_noteBossUnlock.y =  (Const.STAGE_HEIGHT - _noteBossUnlock.height)/2;
//			_panelContent.addChild(_noteBossUnlock);
//			_noteArr.push(_noteBossUnlock);
			
			_noteBuySuccess  =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("buyhp10note"));
			_noteBuySuccess.x =  (Const.STAGE_WIDTH - _noteBuySuccess.width)/2;
			_noteBuySuccess.y =  (Const.STAGE_HEIGHT - _noteBuySuccess.height)/2;
			_panelContent.addChild(_noteBuySuccess);
			_noteArr.push(_noteBuySuccess);
			
			
			
			_noteStoreClose =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("storeNotOpenNote"));
			_noteStoreClose.x =  (Const.STAGE_WIDTH - _noteStoreClose.width)/2;
			_noteStoreClose.y =  (Const.STAGE_HEIGHT - _noteStoreClose.height)/2;
			_panelContent.addChild(_noteStoreClose);
			_noteArr.push(_noteStoreClose);
			
			_noteBuyIng =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("pleaseWaitNote"));
			_noteBuyIng.x =  (Const.STAGE_WIDTH - _noteBuyIng.width)/2;
			_noteBuyIng.y =  (Const.STAGE_HEIGHT - _noteBuyIng.height)/2;
			_panelContent.addChild(_noteBuyIng);
			_noteArr.push(_noteBuyIng);
			
			
//			_shareToWeiXinBtn = new Image(assetManager.getTextureAtlas("gui_images").getTexture("share_to_weixin_btn"));
//			_shareToWeiXinBtn.x =  (Const.STAGE_WIDTH - _noteBuyIng.width)/2-10;
//			_shareToWeiXinBtn.y =  (Const.STAGE_HEIGHT - _shareToWeiXinBtn.height)/2 + 140;
//			_panelContent.addChild(_shareToWeiXinBtn);
//			_shareToWeiXinBtn.visible = false;
//			
//			
//			_shareSuccess = new Image(assetManager.getTextureAtlas("gui_images").getTexture("share_success"));
//			_shareSuccess.x =  (Const.STAGE_WIDTH - _shareSuccess.width)/2;
//			_shareSuccess.y =  (Const.STAGE_HEIGHT - _shareSuccess.height)/2;
//			_panelContent.addChild(_shareSuccess);
//			_noteArr.push(_shareSuccess);
//			
//			_shareFail = new Image(assetManager.getTextureAtlas("gui_images").getTexture("share_failed"));
//			_shareFail.x =  (Const.STAGE_WIDTH - _shareFail.width)/2;
//			_shareFail.y =  (Const.STAGE_HEIGHT - _shareFail.height)/2;
//			_panelContent.addChild(_shareFail);
//			_noteArr.push(_shareFail);
			
			_surverModeInfoViewAlert = new SurverModeInfoViewAlert();
			_surverModeInfoViewAlert.x = (Const.STAGE_WIDTH - _surverModeInfoViewAlert.width)/2;
			_surverModeInfoViewAlert.y = (Const.STAGE_HEIGHT - _surverModeInfoViewAlert.height)/2;
			_panelContent.addChild(_surverModeInfoViewAlert);
			_noteArr.push(_surverModeInfoViewAlert);
			
			
//			_noteresoreComplete = new Image(assetManager.getTextureAtlas("gui_images").getTexture("restoreComplete"));
//			_noteresoreComplete.x = (Const.STAGE_WIDTH - _noteresoreComplete.width)/2;
//			_noteresoreComplete.y = (Const.STAGE_HEIGHT - _noteresoreComplete.height)/2;
//			_panelContent.addChild(_noteresoreComplete);
//			_noteArr.push(_noteresoreComplete);
			
			_noteresorefail = new Image(assetManager.getTextureAtlas("gui_images").getTexture("restoreFial"));
			_noteresorefail.x = (Const.STAGE_WIDTH - _noteresorefail.width)/2;
			_noteresorefail.y = (Const.STAGE_HEIGHT - _noteresorefail.height)/2;
			_panelContent.addChild(_noteresorefail);
			_noteArr.push(_noteresorefail);
			
			this.closeViewHandler();
		}
		
		private function closeViewHandler():void
		{
			_panelContent.scaleX = 0;
			_panelContent.scaleY = 0;
			this.visible = false;
			this.touchable = false;
		}
		
		private function shareBossUnlock():void
		{
			this.dispatchEventWith(NoteEvent.SHARE_BOSS_UNCLOCK);
		}
	}
}
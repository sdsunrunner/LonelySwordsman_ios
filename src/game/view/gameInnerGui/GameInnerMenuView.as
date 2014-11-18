package game.view.gameInnerGui
{
	import flash.utils.Dictionary;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 游戏关卡菜单 
	 * @author admin
	 * 
	 */	
	public class GameInnerMenuView extends BaseViewer
	{
		private var _reset:Image = null;			
		private var _menu:Image = null;
//		private var _shareToWeiXin:Image = null;
		private var _dataDic:Dictionary = null;
		private var _dataModel:EnemyGuiInfoDataModel = null;
		public function GameInnerMenuView()
		{
			super();
			this.initView();
			this.initModel();
			this.addGestures();
			this.touchable = true;
		}		
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.ENEMY_INFO_UPDATE)
			{
				_dataDic = data as Dictionary;
			}
		}
		
		override public function initModel():void
		{
			_dataModel = EnemyGuiInfoDataModel.instance;
			_dataModel.register(this);
		}
		
		override public function dispose():void
		{
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			this.removeEventListeners();
		
		}
		
		private function initView():void
		{
			_reset = new Image(assetManager.getTextureAtlas("gui_images").getTexture("resetLev"));
			_menu = new Image(assetManager.getTextureAtlas("gui_images").getTexture("menu"));
//			_shareToWeiXin = new Image(assetManager.getTextureAtlas("gui_images").getTexture("levShare"));
			
			this.addChild(_reset);
			this.addChild(_menu);
//			this.addChild(_shareToWeiXin);
			_reset.x =  0;
			_reset.y = 0;
			_menu.x = _reset.x;
			_menu.y = _reset.y + 100;	
			
//			_shareToWeiXin.x = _reset.x;
//			_shareToWeiXin.y = _menu.y+100;
			
			this.scaleX = .6;
			this.scaleY = .6;
		}
		
		private function addGestures():void
		{
			_menu.addEventListener(TouchEvent.TOUCH, showmainMenuhandler);
			_reset.addEventListener(TouchEvent.TOUCH, resetGameLevhandler);
//			_shareToWeiXin.addEventListener(TouchEvent.TOUCH, shareGameLevhandler);
		}
		
		private function showmainMenuhandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this)
			if(touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					this.dispatchEventWith(MainScenceEvent.SHOW_MAIN_MENU);
				}
			}
		}
		
		private function resetGameLevhandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this)
			if(touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					this.dispatchEventWith(MainScenceEvent.REST_GAME_LEV);
				}
			}
		}
		
		private function shareGameLevhandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this)
			if(touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					this.dispatchEventWith(MainScenceEvent.SHARE_GAME_LEV);
				}
			}
		}
	}
	
}
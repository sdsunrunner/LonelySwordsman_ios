package game.view.welcomeScence.battleModelStart
{
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.event.MainScenceEvent;
	
	import lzm.starling.gestures.TapGestures;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	import starling.display.Image;
	
	/**
	 * 对决开始视图 
	 * @author admin
	 * 
	 */	
	public class BattleStartView extends BaseViewer
	{	
		private var _shBg:Shape = null;
		
		private var _bg:Image = null;
		private var _monsterImage:Image = null;
		private var _bossImage:Image = null;
//		private var _noteImage:Image = null;
		private var _closeImage:Image = null;
		private var _gameLevelManager:GameLevelManager = null;
		private var _bossLock:Image = null;
		private var _monsterLock:Image = null;
		private var _playerInfo:ObjPlayerInfo = null;
		
		public function BattleStartView()
		{
			super();
			_playerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			this.initView();
			this.addListeners();
			
			_gameLevelManager = GameLevelManager.instance;
		}
		
		override public function dispose():void
		{
			_monsterImage.dispose();
			_bossImage.dispose();
			_closeImage.dispose();
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		public function buyBossSuccess():void
		{
			_playerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			_bossLock.visible = !_playerInfo.battleModeBossIsUnLock;
			_monsterLock.visible = !_playerInfo.battleModeMonsterIsUnLock;
		}
		
		private function initView():void
		{
			_shBg = new Shape();
			_shBg.graphics.beginFill(0x000000);
			_shBg.graphics.drawRect(0,0,Const.STAGE_WIDTH,Const.STAGE_HEIGHT);
			this.addChild(_shBg);
			
			_closeImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("closeBtn"));			
			this.addChild(_closeImage);
			
			
			_monsterImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("guaiwuImage"));
			_monsterImage.y = (Const.STAGE_HEIGHT - _monsterImage.height)/2 + 18;
			
			this.addChild(_monsterImage);
			
			_bossImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bossImage"));
			_bossImage.y = _monsterImage.y;			
			this.addChild(_bossImage);
			
			_monsterImage.x = (Const.STAGE_WIDTH - _monsterImage.width - _bossImage.width - 80)/2;
			_bossImage.x = _monsterImage.x + _monsterImage.width + 60;
			
			
			_closeImage.y = _closeImage.height/2;
			_closeImage.x = Const.STAGE_WIDTH - _closeImage.width - 30;
			
			
			_bossLock = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bossLock"));
			_bossLock.x = Math.floor(this._bossImage.x + (_bossImage.width-_bossLock.width)/2);
			_bossLock.y = Math.floor(this._bossImage.y + (_bossImage.height-_bossLock.height)/2);
			this.addChild(_bossLock);
			_bossLock.alpha = .8;
			
			_bossLock.visible = !_playerInfo.battleModeBossIsUnLock;
			_bossLock.touchable = false;
			
			_monsterLock = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bossLock"));
			_monsterLock.x = Math.floor(this._monsterImage.x + (_monsterImage.width-_monsterLock.width)/2);
			_monsterLock.y = Math.floor(this._monsterImage.y + (_monsterImage.height-_monsterLock.height)/2);
			this.addChild(_monsterLock);
			_monsterLock.alpha = .8;
			
			_monsterLock.visible = !_playerInfo.battleModeMonsterIsUnLock;
			_monsterLock.touchable = false;
			
//			_noteImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("battleModeNote"));
//			_noteImage.x = Math.floor((Const.STAGE_WIDTH - _noteImage.width)/2);
//			_noteImage.y = _bossImage.y - 100;
//			this.addChild(_noteImage);
		}
		
		private function addListeners():void
		{
			var closeTap:TapGestures = new TapGestures(_closeImage, closeViewHandler);
			var vsBossTap:TapGestures = new TapGestures(_bossImage, vsBossBattlehandler);
			var vsMonsterTap:TapGestures = new TapGestures(_monsterImage, vsMonsterBattlehandler);			
		}
		
		private function closeViewHandler():void
		{
			this.touchable = false;
			this.dispatchEventWith(MainScenceEvent.BATTLE_MODEL_CLOSE_BTN_CLICK, true);
		}
		
		private function vsBossBattlehandler():void
		{
			if(_playerInfo.battleModeBossIsUnLock)
			{
				this.touchable = false;
				_gameLevelManager.currentGameModel = GameModeEnum.TYPE_BATTLE_MODEL_VS_BOSS;
				this.dispatchEventWith(MainScenceEvent.BATTLE_MODEL_START, true);
			}
		}
		
		private function vsMonsterBattlehandler():void
		{
			if(_playerInfo.battleModeMonsterIsUnLock)
			{
				this.touchable = false;
				_gameLevelManager.currentGameModel = GameModeEnum.TYPE_BATTLE_MODEL_VS_MONSTER;
				this.dispatchEventWith(MainScenceEvent.BATTLE_MODEL_START, true);
			}
		}
	}
}
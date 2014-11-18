package game.view.guiLayer
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.guiLayer.enemyInfo.EnemyInfoContainer;
	import game.view.models.HeroStatusModel;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * gui视图 
	 * @author admin
	 * 
	 */	
	public class GuiView extends BaseViewer
	{
		private var _infoBg:Image = null;
		private var _hpBg:Image = null;
		private var _hpImage:Image = null;
		private var _mpImage:Image = null;
		private var _heroStatusInfoView:Sprite = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _enemyInfoContainer:EnemyInfoContainer = null;
		private var _lifeCountBar:LifeCountBar = null;
		
		private var _surverScoreView:SurverModeInfoView = null;
		public function GuiView()
		{
			super();
			this.initView();
			this.initModel();
		}
		
		override public function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
		}
		
		override public function dispose():void
		{
			if(_hpBg)
			{
				_infoBg.dispose();
				_infoBg = null;
				_hpBg.dispose();
				_hpBg = null;
				_hpImage.dispose();
				_hpImage = null;
				_mpImage.dispose();
				_mpImage = null;
				_enemyInfoContainer.dispose();
				_enemyInfoContainer = null;
				_heroStatusModel.unRegister(this);
				_heroStatusModel = null;
			}
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName ==  MsgTypeEnum.HERO_HP_UPDATE)
			{
				var heroHpRatio:Number = data as Number;
				if(heroHpRatio>0)
					_hpImage.scaleX = heroHpRatio;
				else
					_hpImage.visible = false;
			}
			
			if(msgName ==  MsgTypeEnum.HERO_HP_ADD_UPDATE)
			{
				var heroHpRatioUpdate:Number = data as Number;
				if(heroHpRatioUpdate>0)
					_hpImage.scaleX = heroHpRatioUpdate;
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
			if(msgName ==  MsgTypeEnum.HERO_LIFE_COUNT_UPDATE)
			{
				_lifeCountBar.setHeroLifeCount(data as Number);
			}
		}
		private function initView():void
		{
			_heroStatusInfoView = new Sprite();
			_heroStatusInfoView.scaleX = 1;
			_heroStatusInfoView.scaleY = 1;
			this.addChild(_heroStatusInfoView);
			
			_infoBg =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("lifeBg"));
			_infoBg.x = 20;
			_infoBg.y = 20;
			_heroStatusInfoView.addChild(_infoBg);
			
			
//			_hpBg = new Image(assetManager.getTextureAtlas("gui_images").getTexture("hpValueBar"));
//			_hpBg.x = 50;
//			_hpBg.y = 50;
			
			_hpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("hpValueBar"));
			_hpImage.x = 108;
			_hpImage.y = 22+23.5;
			_heroStatusInfoView.addChild(_hpImage);
			
			_mpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("mpValueBar"));
			
			_mpImage.x = 109;
			_mpImage.y = 37+32.5;
			_heroStatusInfoView.addChild(_mpImage);		
			
//			_heroStatusInfoView.scaleX = 1.1;
//			_heroStatusInfoView.scaleY = 1.1;
			
			_enemyInfoContainer = new EnemyInfoContainer();
			_enemyInfoContainer.x = Const.STAGE_WIDTH - 190;
		
			
			_enemyInfoContainer.y = 20;
			this.addChild(_enemyInfoContainer);
			
			_lifeCountBar = new LifeCountBar();
			_lifeCountBar.y = 18;
			_lifeCountBar.x = 5;
//			this.addChild(_lifeCountBar);
			
			_surverScoreView = new SurverModeInfoView();
			_surverScoreView.x = Const.STAGE_WIDTH/2 - 50;
			_surverScoreView.y = 10;
			this.addChild(_surverScoreView);
			this.touchable = false;
			if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_SURVIVAL_MODEL)
				_surverScoreView.visible = true;
			else
				_surverScoreView.visible = false;			
		}
	}
}
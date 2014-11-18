package  game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.dataProxy.AutoRecoverCenter;
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.gameScenceView.gameLev.GameLevViewController;
	import game.view.gameScenceView.gameLevInterface.IGameLevViewController;
	import game.view.models.HeroStatusModel;
	
	import starling.display.Sprite;
	
	import utils.AssetUtils;
	
	import vo.configInfo.ObjGameLevelConfigInfo;
	
	/**
	 * 关卡处理命令 
	 * @author songdu
	 * 
	 */	
	public class GameLevelHandlerCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			AutoRecoverCenter.instance.autoRecoverPause(false);
			
			if(uiDelegate.storyCgViewController)
				uiDelegate.removePanel(uiDelegate.storyCgViewController,CommandViewType.GAME_STORY_CG);

			
			this.notify(CommandViewType.SCENCE_SWITCH);	
			
			this.showGameLevScenceView();			
			gameLevelMapParse();
			
			if(gameLevManager.currentGameModel != GameModeEnum.TYPE_STORY_MODEL)
			{
				HeroStatusModel.instance.setHeroStatusFull();
			}
		}
		
		public function gameLevelMapParse():void
		{
			var needLoadMap:Boolean = false;
			var needLoadRes:Boolean = false;
			var gameLevConfig:ObjGameLevelConfigInfo = gameLevManager.getLevConfigInfo();			
			
			//处理场景资源
			var levTextures:Array = gameLevConfig.scenceResCollection;
			for each(var texture:String in levTextures)
			{
				var textureUrl:String = Const.GAME_LEV_TEXTURE_RES_URL + texture;				
				if(!assetManager.getTextureAtlas(AssetUtils.getAssetNameByUrl(textureUrl)))
				{
					needLoadRes = true;
					assetManager.enqueue(textureUrl);
				}
			}		
			//处理场景地图
			var levMapUrl:String = Const.GAME_LEV_MAP_URL + gameLevConfig.levMapName;
			var levMapName:String = AssetUtils.getAssetNameByUrl(levMapUrl);
			
			if("" != levMapName)
			{
				if(uiDelegate.guiViewController)
					uiDelegate.guiViewController.activeGui(true);
				
				gameLevManager.isCgLev = false;				
				if(!assetManager.getOther(levMapName))
				{
					needLoadMap = true;
					assetManager.enqueue(levMapUrl);
				}
			}	
			else
			{
				gameLevManager.isCgLev = true;
				if(uiDelegate.guiViewController)
					uiDelegate.guiViewController.activeGui(false);
				
				if(uiDelegate.controlViewController)
					uiDelegate.controlViewController.activeControl(false);				
			}
			
			var tmxName:String = AssetUtils.getAssetNameByUrl(levMapUrl);
			if(needLoadRes || needLoadMap)
			{
				assetManager.loadQueue(function(ratio:Number):void
				{
					if (ratio == 1.0)
					{
						initGameLev(tmxName,gameLevConfig);
					}
				});	
			}
			else
				initGameLev(tmxName,gameLevConfig);
		}
		
		/**
		 * 初始化关卡 
		 * @param tmxName
		 * @param levMap
		 * 
		 */		
		private function initGameLev(tmxName:String,levConfig:ObjGameLevelConfigInfo):void
		{	
			if("" != tmxName)
			{
				var tmxXml:XML = assetManager.getOther(tmxName) as XML;
				setLevMapInfo(tmxXml,levConfig);
				changeScenceBg(levConfig);
			}
			else
			{
				showStoryCg(levConfig);
				changeScenceBg(levConfig);
			}
		}
		
		/**
		 * 显示故事cg 
		 * @param levConfig
		 * 
		 */		
		private function showStoryCg(levConfig:ObjGameLevelConfigInfo):void
		{
			var showCgCmdType:String = levConfig.showCgCmdType;
			if("" != showCgCmdType)
				this.notify(CommandInteracType.SHOW_STORY_CG,showCgCmdType);			
		}
		
		/**
		 * 切换场景背景 
		 * @param levMap
		 * 
		 */		
		private function changeScenceBg(levMap:ObjGameLevelConfigInfo):void
		{
			var changeScenceBgMsg:String = levMap.changeBgMsg;
			if("" != changeScenceBgMsg)
				this.notify(changeScenceBgMsg);
		}
		
		private function buildMapview(layers:Array):Sprite
		{
			var mapView:Sprite = new Sprite();
			for(var i:Number = 0; i < layers.length; i++)
			{
				mapView.addChild(layers[i]);
			}
			return mapView;
		}
		
		public function setLevMapInfo(tmxXml:XML,levMapInfo:ObjGameLevelConfigInfo):void
		{
			var controller:IGameLevViewController = uiDelegate.gameLevViewController;
			if(controller)
				controller.initGameLev(tmxXml,levMapInfo);
		}
		
		private function showGameLevScenceView():void
		{
			if(uiDelegate.gameLevViewController)
				uiDelegate.removePanel(uiDelegate.gameLevViewController,CommandViewType.GAME_LEVEL_VIEW);
			
			var controller:GameLevViewController = uiDelegate.gameLevViewController || this.createController();
			this.createAndAddPanel(controller, CommandViewType.GAME_LEVEL_VIEW);
			
			//处理不同模式的控制状态
			if(uiDelegate.controlViewController)
			{
				var canUseProto:Boolean = gameLevManager.isStoryMode();
				uiDelegate.controlViewController.canUseProto(canUseProto);
			}
			
			//处理不同模式英雄的数值
			if(!gameLevManager.isStoryMode())
			{
				HeroStatusModel.instance.setHeroStatusFull();
			}
		}
		
		private function createController():GameLevViewController
		{
			return new GameLevViewController();
		}
	}
}
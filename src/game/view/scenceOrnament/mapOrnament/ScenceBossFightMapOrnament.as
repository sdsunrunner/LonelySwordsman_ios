package game.view.scenceOrnament.mapOrnament
{
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.gameLevelManager.GameModeEnum;
	import game.view.superView.baseScenceView.BaseScenceMapOrnamentView;
	
	import starling.display.Image;
	
	/**
	 * boss对决场景点缀 
	 * @author admin
	 * 
	 */	
	public class ScenceBossFightMapOrnament extends BaseScenceMapOrnamentView
	{
		private static const IMAGE_COUNT:Number = 4;
		
		public function ScenceBossFightMapOrnament()
		{
			super();
			this.initView();
		}
		
		private function initView():void
		{
			for(var i:Number = 0; i < IMAGE_COUNT; i++)
			{
				var bgImage:Image =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("bgItem"));
				if(GameLevelManager.instance.currentGameModel == GameModeEnum.TYPE_STORY_MODEL)
					bgImage.x = i * 350 + 420;
				else
					bgImage.x = i * 350 + 250;
				bgImage.y = 180;
				bgImage.scaleX = 1.7;
				bgImage.scaleY = 1.7;
				bgImage.alpha = 0.85;
				this.addChild(bgImage);
			}
		}
	}
}
package game.view.controlView.movesBarView
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	import enum.RoleActionEnum;
	
	/**
	 *  
	 * @author songdu
	 * 
	 */	
	public class MovesBtnView extends BaseViewer
	{
		private var _movesIcon:Image = null;
		
		public function MovesBtnView()
		{
			super();
			this.initView();		
		}
		
		public function setMovesType(movesType:String):void
		{			
			switch(movesType)
			{
				case RoleActionEnum.CONTROLLE_BAR_UP_ATTACK:
					_movesIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("upAttackBtn"));					
					break;
				
				case RoleActionEnum.PARRY_AND_ATTACK:
					_movesIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("blockIcon"));				
					break;					
			}
			
			_movesIcon.x = 0;
			_movesIcon.y = 0;
			
			this.addChild(_movesIcon);	
		}
		
		private function initView():void
		{
			
		}
	}
}
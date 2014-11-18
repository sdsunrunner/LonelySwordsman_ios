package game.view.gameScenceView.gameLevInterface
{
	import vo.configInfo.ObjGameLevelConfigInfo;
	

	/**
	 * 游戏关卡视图控制器借口 
	 * @author songdu
	 * 
	 */	
	public interface IGameLevViewController
	{
				
		function initGameLev(tmxXml:XML,levMapInfo:ObjGameLevelConfigInfo):void;
	}
}
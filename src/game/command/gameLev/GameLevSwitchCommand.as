package game.command.gameLev
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.view.guiLayer.enemyInfo.EnemyGuiInfoDataModel;
	import game.view.levEndView.LevReportInfomodel;
	
	import playerData.GamePlayerDataProxy;
	
	import utils.console.infoCh;
	
	/**
	 * 游戏关卡切换命令 
	 * @author admin
	 * 
	 */	
	public class GameLevSwitchCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{	
//			CONFIG::ONLINE
//				behaviorAnalyseManager.umeng.dispatchEventWithParams("levEnd","lev=" + gameLevManager.gameLevIndex);
			if(gameLevManager.isMonsterLevUnlock)
			{
				GamePlayerDataProxy.instance.getPlayerInfo().battleModeMonsterIsUnLock = true; 
			}
			if(gameLevManager.isBossLevUnlock)
			{
				GamePlayerDataProxy.instance.getPlayerInfo().battleModeBossIsUnLock = true; 
			}
			
			EnemyGuiInfoDataModel.instance.resetEnemyInfo();
			gameLevManager.gameLevNext();
			if(gameLevManager.isStoryMode)
				GamePlayerDataProxy.instance.saveGamelLevInfo();
			
			infoCh("lev switch","GameLevSwitchCommand gameLevIndex" + gameLevManager.gameLevIndex);
			LevReportInfomodel.instance.resetData();
		}
	}
}
package game.command
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import frame.command.cmdInterface.INotification;

	/**
	 * 评分 
	 * @author admin
	 * 
	 */	
	public class GiveScoreCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
//			behaviorAnalyseManager.umeng.dispatchEventWithParams("giveScoreClick","type=" + note.data);
			
			var _newURL:URLRequest = new URLRequest(Const.APP_URL);
			var _fangshi:String="_blank";
			navigateToURL(_newURL,_fangshi);
		}
	}
}
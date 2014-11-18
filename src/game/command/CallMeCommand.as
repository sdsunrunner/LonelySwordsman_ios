package game.command
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import frame.command.cmdInterface.INotification;

	/**
	 * 联系我 
	 * @author admin
	 * 
	 */	
	public class CallMeCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
//			CONFIG::ONLINE
//			behaviorAnalyseManager.umeng.dispatchEvent("callMeClick");
				
			var _newURL:URLRequest = new URLRequest(Const.CALL_ME);
			var _fangshi:String="_blank";
			navigateToURL(_newURL,_fangshi);
		}
	}
}
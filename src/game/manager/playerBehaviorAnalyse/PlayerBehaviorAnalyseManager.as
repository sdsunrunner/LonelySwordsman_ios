package game.manager.playerBehaviorAnalyse
{
	

	/**
	 * 玩家行为分析 
	 * @author admin
	 * 
	 */	
	public class PlayerBehaviorAnalyseManager
	{
		private static var _instance:PlayerBehaviorAnalyseManager = null;
		
//		private var _umeng:Umeng = null;
		public function PlayerBehaviorAnalyseManager(code:InnerClass)
		{
//			_umeng = Umeng.instance;
//			var umeng:Umeng = Umeng.instance;
//			umeng.init(Const.UMENG_KEY);
		}
		
//		public function get umeng():Umeng
//		{
//			return _umeng;
//		}

		public static function get instance():PlayerBehaviorAnalyseManager
		{
			return _instance ||= new PlayerBehaviorAnalyseManager(new InnerClass);
		}
		
	}
}
class InnerClass{}
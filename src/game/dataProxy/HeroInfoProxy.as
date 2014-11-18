package game.dataProxy
{
	import enum.RoleActionEnum;
	
	import frame.view.IObserver;
	
	import game.view.models.HeroStatusModel;
	
	import playerData.GamePlayerDataProxy;
	
	/**
	 * 英雄数据代理器 
	 * @author admin
	 * 
	 */	
	public class HeroInfoProxy implements IObserver
	{
		private static var _instance:HeroInfoProxy = null;
		private var _heroStatus:HeroStatusModel = null;
		
		public function HeroInfoProxy(code:$)
		{
			this.initModel();
		}
		
		public static function get instance():HeroInfoProxy
		{
			return _instance ||= new HeroInfoProxy(new $);
		}		
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			switch(msgName)
			{
				case RoleActionEnum.RECOVER_HP:
					_heroStatus.addHp(100);
					break;
				case RoleActionEnum.RECOVER_MP:
					_heroStatus.addMp(80);
					break;
			}
			
			GamePlayerDataProxy.instance.saveGamelLevInfo();
		}
		
		public function dispose():void
		{
		
		}
		
		private function initModel():void
		{
			_heroStatus = HeroStatusModel.instance;	
		}
	}
}


class ${}
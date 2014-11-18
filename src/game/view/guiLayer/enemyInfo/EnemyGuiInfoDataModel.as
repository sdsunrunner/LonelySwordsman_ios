package game.view.guiLayer.enemyInfo
{
	import flash.utils.Dictionary;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	import vo.ObjEnemyStatusInfo;
	
	/**
	 * 敌人信息数据模型 
	 * @author admin
	 * 
	 */	
	public class EnemyGuiInfoDataModel extends MessageCenter
	{
		private static var _instance:EnemyGuiInfoDataModel = null;
		
		private var _enemyInfoDic:Dictionary = null;
		
		public function EnemyGuiInfoDataModel(code:$)
		{
			super();
		}
		
		public static function get instance():EnemyGuiInfoDataModel
		{
			return _instance  ||= new EnemyGuiInfoDataModel(new $);
		}
		
		public function resetEnemyInfo():void
		{
			for (var key:* in _enemyInfoDic)
			{
				delete _enemyInfoDic[key];
				_enemyInfoDic[key] = null;
			}
				
			_enemyInfoDic = null;
			this.msgName = MsgTypeEnum.ENEMY_INFO_UPDATE;
			this.msg = _enemyInfoDic;
			this.notify();
		}
		
		/**
		 * 更新敌人信息 
		 * @param info
		 * 
		 */		
		public function updateEnemyInfo(info:ObjEnemyStatusInfo):void
		{
			if(null == _enemyInfoDic)
				_enemyInfoDic = new Dictionary();
			
			_enemyInfoDic[info.enemyId] = info;
			this.msgName = MsgTypeEnum.ENEMY_INFO_UPDATE;
			this.msg = _enemyInfoDic;
			this.notify();
		}
		
		public function removeEnemyInfo(info:ObjEnemyStatusInfo):void
		{
			if(_enemyInfoDic && info)
				delete _enemyInfoDic[info.enemyId];
			
			this.msgName = MsgTypeEnum.ENEMY_INFO_UPDATE;
			this.msg = _enemyInfoDic;
			this.notify();
		}
	}
}

class ${}
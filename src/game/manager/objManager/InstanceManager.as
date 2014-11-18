package game.manager.objManager
{
	import flash.geom.Point;
	
	import game.view.enemySoldiers.basis.BaseSoldierEnemy;
	
	import utils.objPool.GameObjectPool;

	/**
	 * 实例管理器 
	 * @author admin
	 * 
	 */	
	public class InstanceManager
	{
		private static var _instance:InstanceManager = null;
		
		public function InstanceManager(code:$)
		{
			
		}
		
		public static function get instance():InstanceManager
		{
			return _instance ||= new InstanceManager(new $);
		}		
		
		/**
		 * 获取点对象 
		 * @return 
		 * 
		 */		
		public function getPoint():Point
		{
			return GameObjectPool.createObject(Point) as Point;
		}
		
		/**
		 * 将消除的点实例回收 存在内存池中
		 * @param point
		 * 
		 */		
		public function recoverPoin(point:Point):void
		{
			GameObjectPool.recoverObject(point);
		}
		
		/**
		 * 获取基础士兵对象 
		 * @return 
		 * 
		 */		
		public function getBaseSoldierEnemy():BaseSoldierEnemy
		{
			return GameObjectPool.createObject(BaseSoldierEnemy) as BaseSoldierEnemy;;
		}
		
		/**
		 * 将消除的基础士兵实例回收 存在内存池中  
		 * @param baseSoldierEnemy
		 * 
		 */		
		public function recoverBaseSoldierEnemy(baseSoldierEnemy:BaseSoldierEnemy):void
		{
			GameObjectPool.recoverObject(baseSoldierEnemy);
		}
	}
}

class ${}
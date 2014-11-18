package game.manager.physicsWorld
{
	import flash.display.Sprite;
	
	import citrus.physics.nape.Nape;
	
	import game.physicsWorker.NapeWorker;

	/**
	 * 物理空间管理器 
	 * @author songdu
	 * 
	 */	
	public class PhysicSpaceManager
	{
		private static var _instance:PhysicSpaceManager = null;
		 
	    private var _napeWorker:NapeWorker = null;
		
		public function PhysicSpaceManager(code:$)
		{
			_napeWorker = new NapeWorker();
		}

//		public function getNape():Nape
//		{
//			return _napeWorker.nape;
//		}
		
		public function getNapeWorkerView():Sprite
		{
			return _napeWorker;
		}
		
		public function activeNapeWorker():void
		{
			_napeWorker.active();
		}
		
		public static function get instance():PhysicSpaceManager
		{
			return _instance ||= new PhysicSpaceManager(new $);
		}
		
	}
}

class ${}
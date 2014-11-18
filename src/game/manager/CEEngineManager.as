package game.manager
{
	import flash.display.Sprite;
	
	import citrus.core.CitrusEngine;

	/**
	 * ce引擎管理器 
	 * @author songdu
	 * 
	 */	
	public class CEEngineManager
	{
		private static var _instance:CEEngineManager = null;
		private var _debugSpriteRectangle:Sprite = null;
		private var _ceEngine:CitrusEngine = null;
		
		public function CEEngineManager(code:$)
		{
		
		}
		
//		public function get debugSpriteRectangle():Sprite
//		{
//			return _debugSpriteRectangle;
//		}
//
//		public function set debugSpriteRectangle(value:Sprite):void
//		{
//			_debugSpriteRectangle = value;
//		}

		public function get ceEngine():CitrusEngine
		{
			return _ceEngine;
		}

		public function set ceEngine(value:CitrusEngine):void
		{
			_ceEngine = value;
			
		}
		
        public function setStateIndex(index:Number):void
		{
//			_ceEngine.stateDisplayIndex(index);
		}
		
		public static function get instance():CEEngineManager
		{
			return _instance||= new CEEngineManager(new $);
		}
	}
}

class ${}
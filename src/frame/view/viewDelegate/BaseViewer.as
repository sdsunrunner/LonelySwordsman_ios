package frame.view.viewDelegate
{
	import frame.view.viewInterface.IViewer;
	
	import game.manager.SoundExpressions;
	import game.manager.assetManager.GameAssetManager;
	
	import starling.display.Sprite;

	/**
	 * viewer 基类 
	 * @author songdu.greg
	 * 
	 */	
	public class BaseViewer extends Sprite implements IViewer
	{
		
		private var _assetManager:GameAssetManager = null;
		private var _soundExpressions:SoundExpressions = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function BaseViewer()
		{
			super();
		}
		
		public function initModel():void
		{
			
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			
		}
		
		/**
		 * 快捷获取资源管理器 
		 * @return 
		 * 
		 */		
		final public function get assetManager():GameAssetManager
		{
			if (_assetManager == null)
				_assetManager = GameAssetManager.instance;
			return _assetManager;
		}
		
		/**
		 * 获取音效管理器 
		 * @return 
		 * 
		 */		
		final public function get soundExpressions():SoundExpressions
		{
			if(_soundExpressions == null)
				_soundExpressions = SoundExpressions.instance;
			
			return _soundExpressions;
		}
		
		
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
	
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

	}
}
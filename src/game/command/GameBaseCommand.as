package game.command
{
	import citrus.core.SoundManager;
	
	import frame.command.SuperCommand;
	import frame.view.viewInterface.IViewerController;
	
	import game.manager.DataProxyManager;
	import game.manager.SharePlatformManager;
	import game.manager.assetManager.GameAssetManager;
	import game.manager.dicManager.DicManager;
	import game.manager.gameLevelManager.GameLevelManager;
	import game.manager.playerBehaviorAnalyse.PlayerBehaviorAnalyseManager;
	import game.manager.uiManager.UIManagerDelegate;
	
	/**
	 * command基类 
	 * @author songdu.greg
	 * 
	 */	
	public class GameBaseCommand extends SuperCommand
	{
		//字典表管理器
		private var _dicManager:DicManager = null;
		
		//ui管理器
		private var _uiDelegate:UIManagerDelegate = null;
		
		//数据代理管理器
		private var _dataProxyManager:DataProxyManager = null;
		
		//关卡管理器
		private var _gameLevManager:GameLevelManager = null;
		
		//分享平台管理器
		private var _sharePlatFormManager:SharePlatformManager = null;
		private var _behaviorAnalyseManager:PlayerBehaviorAnalyseManager = null;
		//资源管理器
		private var _assetManager:GameAssetManager = null;
		private var _soundManager:SoundManager = null;
		private var _uiType:String = "";
//==============================================================================
// Public Functions
//==============================================================================
		/**
		 * 快捷获取字典表管理器 
		 * @return 
		 * 
		 */		
		final public function get dicManager():DicManager
		{
			if (_dicManager == null)
				_dicManager = DicManager.instance;
			return _dicManager;
		}
		
		/**
		 * 快捷获取ui管理器 
		 * @return 
		 * 
		 */		
		final public function get uiDelegate():UIManagerDelegate
		{
			if (_uiDelegate == null)
				_uiDelegate = UIManagerDelegate.instance;
			return _uiDelegate;
		}
		
		/**
		 * 快捷获取数据代理管理器  
		 * @return 
		 * 
		 */		
		final public function get dataProxyManager():DataProxyManager
		{
			if (_dataProxyManager == null)
				_dataProxyManager = DataProxyManager.instance;
			return _dataProxyManager;
		}
		
		/**
		 * 快捷获取关卡管理器
		 * @return 
		 * 
		 */		
		final public function get gameLevManager():GameLevelManager
		{
			if (_gameLevManager == null)
				_gameLevManager = GameLevelManager.instance;
			return _gameLevManager;
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
		
		final public function get soundManager():SoundManager
		{
			if (_soundManager == null)
				_soundManager = SoundManager.getInstance();
			return _soundManager;
		}
		
		/**
		 * 获取分享平台管理器 
		 * @return 
		 * 
		 */		
		final public function get sharePlatformManager():SharePlatformManager
		{
			if (_sharePlatFormManager == null)
				_sharePlatFormManager = SharePlatformManager.instance;
			return _sharePlatFormManager;
		}
		
		/**
		 * 玩家行为分析 
		 * @return 
		 * 
		 */		
		final public function get behaviorAnalyseManager():PlayerBehaviorAnalyseManager
		{
			if (_behaviorAnalyseManager == null)
				_behaviorAnalyseManager = PlayerBehaviorAnalyseManager.instance;
			return _behaviorAnalyseManager;
		}
		
		/**
		 * 封装了UIDelegate 的 createPanel 和 addPanel 方法
		 * @param controller
		 * @param type
		 *
		 */
		public function createAndAddPanel(controller:IViewerController, type:String):void
		{
			_uiType = type;
			uiDelegate.createAndAddPanel(controller, type);
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	}
}
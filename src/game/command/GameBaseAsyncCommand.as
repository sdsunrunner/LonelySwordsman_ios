package game.command
{
	import frame.command.BaseAsynCommand;
	
	import game.manager.DataProxyManager;
	import game.manager.assetManager.ConfigManager;
	import game.manager.assetManager.GameAssetManager;
	
	/**
	 * 异步命令基类 
	 * @author songdu.greg
	 * 
	 */	
	public class GameBaseAsyncCommand extends BaseAsynCommand
	{
		//资源管理器
		private var _assetManager:GameAssetManager = null;
		private var _configManager:ConfigManager = null;
		//数据代理管理器
		private var _dataProxyManager:DataProxyManager = null;
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
		 * 快捷获取配置管理器 
		 * @return 
		 * 
		 */		
		final public function get configManager():ConfigManager
		{
			if (_configManager == null)
				_configManager = ConfigManager.instance;
			return _configManager;
		}
	}
}
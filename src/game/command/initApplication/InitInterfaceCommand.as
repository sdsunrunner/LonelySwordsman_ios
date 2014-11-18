package game.command.initApplication
{
	import enum.DataProxyTypeEnum;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseAsyncCommand;
	import game.dataProxy.AutoRecoverCenter;
	import game.dataProxy.HeroInfoProxy;
	
	/**
	 * 初始化接口代理 
	 * @author songdu.greg
	 * 
	 */	
	public class InitInterfaceCommand extends  GameBaseAsyncCommand
	{
		override public function excute(note:INotification):void
		{	
			this.dataProxyManager.addDataProxy(DataProxyTypeEnum.HERO_INFO_PROXY,HeroInfoProxy.instance);
//			this.dataProxyManager.addDataProxy(DataProxyTypeEnum.PRODUCT_STORE,ProductStoreManager.instance);
			this.dataProxyManager.addDataProxy(DataProxyTypeEnum.AUTO_RECOVER,AutoRecoverCenter.instance);
		}
	}
}
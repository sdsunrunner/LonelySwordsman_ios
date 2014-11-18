package game.command.store
{	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.manager.ProductStoreManager;
	
	import utils.console.infoCh;
	
	/**
	 * 购买物品命令 
	 * @author admin
	 * 
	 */	
	public class BuyProductCommand  extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			var productId:String = note.data as String;
			infoCh("buy Product req productId",productId);
//			ProductStoreManager.instance.buyProduct(productId);
		}
	}
}
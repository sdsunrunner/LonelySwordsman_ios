package game.manager
{
	import com.adobe.ane.productStore.Product;
	import com.adobe.ane.productStore.ProductEvent;
	import com.adobe.ane.productStore.ProductStore;
	import com.adobe.ane.productStore.Transaction;
	import com.adobe.ane.productStore.TransactionEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.setTimeout;
	
	import enum.ProcuctIdEnum;
	
	import frame.command.SuperCommand;
	
	import game.interactionType.CommandInteracType;
	import game.interactionType.CommandViewType;
	import game.manager.uiManager.UIManagerDelegate;
	import game.model.ProductInfoModel;
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	import game.view.models.HeroStatusModel;
	
	import playerData.GamePlayerDataProxy;
	
	import utils.console.infoCh;

	/**
	 * 产品管理器 
	 * @author admin
	 * 
	 */	
	public class ProductStoreManager extends SuperCommand
	{
		private static var _instance:ProductStoreManager = null;
		
		private var _productStore:ProductStore = null;
		private var  _productsArray:Vector.<String> = null
		private var _products:Vector.<Product> = null;
		private var _productInfoModel:ProductInfoModel = null;
		
		private var _isInited:Boolean = false;
		private var _productId:String = "";
		
		private var _dataInfoModel:ProtoDataInfoModel = ProtoDataInfoModel.instance;
		public function ProductStoreManager(code:$)
		{
			_productInfoModel = ProductInfoModel.instance;
			this.initProductStore();
		}		
		
		public static function get instance():ProductStoreManager
		{
			return _instance ||= new ProductStoreManager(new $);
		}
		
		public function buyProduct(productId:String):void
		{
			_productId = productId;
			
			if(UIManagerDelegate.instance.storeViewController)
			{
				if(_isInited)
					UIManagerDelegate.instance.storeViewController.showBuyresultNote(ProcuctIdEnum.store_buy_ing);
				else
					UIManagerDelegate.instance.storeViewController.showBuyresultNote(ProcuctIdEnum.store_close);
			}
			
			_productStore.makePurchaseTransaction(productId, 1);
		}	
		
		private function test():void
		{
			if(UIManagerDelegate.instance.storeViewController)
				UIManagerDelegate.instance.storeViewController.showBuyresultNote(_productId);
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		private function delayInit():void
		{
			
			infoCh("initProductStore new ", "begin*************");
			_productStore = new ProductStore();
			
			
			_productStore.addEventListener(ProductEvent.PRODUCT_DETAILS_SUCCESS,PRODUCT_DETAILS_SUCCESS_HANDLER);			
			_productStore.addEventListener(ProductEvent.PRODUCT_DETAILS_FAIL,PRODUCT_DETAILS_FAIL_HANDLER);
			_productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_SUCCESS,purchaseTransactionSucceeded);
			_productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_CANCEL,purchaseTransactionCanceled);
			_productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_FAIL,purchaseTransactionCanceled);
			_productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS,finishTransactionSucceeded);
			_productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_SUCCESS,RESTORE_TRANSACTION_SUCCESS_HANDLER);
			_productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_FAIL,RESTORE_TRANSACTION_FAIL_HANDLER);
			_productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_COMPLETE,RESTORE_TRANSACTION_COMPLETE_HANDLER);
			
			
			_productsArray = new Vector.<String>();
//			_productsArray.push(ProcuctIdEnum.boss_un_lock);
			_productsArray.push(ProcuctIdEnum.hp_recover_10);
			_productsArray.push(ProcuctIdEnum.hp_recover_50);
			_productsArray.push(ProcuctIdEnum.mp_recover_5);
			_productsArray.push(ProcuctIdEnum.mp_recover_30);
			_productsArray.push(ProcuctIdEnum.life_ph_3);

			_productStore.requestProductsDetails(_productsArray);
			infoCh("initProductStore new", "end*************");
			
			infoCh("int ProductStore","end!---------");
		}
		
		private function initProductStore():void
		{
			infoCh("int ProductStore","start!-------");
			setTimeout(delayInit,10);
		}
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		protected function RESTORE_TRANSACTION_COMPLETE_HANDLER(event:Event):void
		{
			// TODO Auto-generated method stub
			infoCh("store event","RESTORE_TRANSACTION_COMPLETE_HANDLER 恢复交易完成");
//			this.notify(CommandViewType.INFO_ALERT_VIEW,ProcuctIdEnum.restore_complete);
		}
		
		protected function RESTORE_TRANSACTION_FAIL_HANDLER(event:Event):void
		{
			// TODO Auto-generated method stub
			infoCh("store event","RESTORE_TRANSACTION_FAIL_HANDLER 恢复交易失败");
			
//			this.notify(CommandViewType.INFO_ALERT_VIEW,ProcuctIdEnum.restore_fail);
			
		}
		
		protected function RESTORE_TRANSACTION_SUCCESS_HANDLER(e:TransactionEvent):void
		{
			// TODO Auto-generated method stub
			infoCh("store event","RESTORE_TRANSACTION_SUCCESS_HANDLER 恢复交易成功");
			
			var i:uint=0;
			
			while(e.transactions && i < e.transactions.length)
			{
				var t:Transaction = e.transactions[i];
				printTransaction(t);
				i++;
				infoCh("store event","FinishTransactions" + t.identifier);
				_productStore.finishTransaction(t.identifier);
			}
			
			getPendingTransaction(_productStore);
		}
		
		
		private function purchaseTransactionSucceeded(e:TransactionEvent):void
		{
			
			infoCh("store event","in purchaseTransactionSucceeded 交易成功 ");
			var i:uint=0;
			var t:Transaction;
			while(e.transactions && i < e.transactions.length)
			{
				t = e.transactions[i];				
//				printTransaction(t);				
				i++;				
				var Base:Base64=new Base64();				
				var encodedReceipt:String = Base64.Encode(t.receipt);
				var req:URLRequest = null;
				if(CONFIG::IMPOLDER)
					req =  new URLRequest("https://sandbox.itunes.apple.com/verifyReceipt");
				else
					req = new URLRequest("https://buy.itunes.apple.com/verifyReceipt");

				req.method = URLRequestMethod.POST;
				req.data = "{\"receipt-data\" : \""+ encodedReceipt+"\"}";
				
				var ldr:URLLoader = new URLLoader(req);
				ldr.load(req);
				ldr.addEventListener(IOErrorEvent.IO_ERROR, onReceiptError);
				ldr.addEventListener(Event.COMPLETE,function(e:Event):void
				{
//					infoCh("store event","LOAD COMPLETE: " + ldr.data);
					_productStore.finishTransaction(t.identifier);
					infoCh("store event","LOAD COMPLETE:t.identifier " + t.identifier);
					infoCh("store event","LOAD COMPLETE:_productId " + _productId);
					
					if(UIManagerDelegate.instance.storeViewController)
						UIManagerDelegate.instance.storeViewController.showBuyresultNote(_productId);
					
					switch(_productId)
					{
//						case ProcuctIdEnum.boss_un_lock:
//							infoCh("store event BUY_BOSS_SUCCESS success", _productId);
//							infoCh("store event BUY_BOSS_SUCCESS handler", CommandInteracType.BUY_BOSS_SUCCESS);
//						
////							ProtoDataInfoModel.instance.isHeroLock = true;
//							GamePlayerDataProxy.instance.saveGamelLevInfo();
//							if(UIManagerDelegate.instance.welcomeSenceViewController)
//								UIManagerDelegate.instance.welcomeSenceViewController.buyBossSuccess();
//							
//							if(UIManagerDelegate.instance.storeViewController)
//								UIManagerDelegate.instance.storeViewController.buyBossSuccess();
//							break;
						
						case ProcuctIdEnum.hp_recover_10:
						case ProcuctIdEnum.hp_recover_50:
						case ProcuctIdEnum.mp_recover_5:
						case ProcuctIdEnum.mp_recover_30:
							infoCh("store event BUY_PROTO_SUCCESS success start***********", _productId);
							buyProtoSuccessHandler(_productId);
							infoCh("store event BUY_PROTO_SUCCESS success end**********", _productId);
//							this.notify(CommandInteracType.BUY_PROTO_SUCCESS,_productId);
							break;
			
						case ProcuctIdEnum.life_ph_3:
							infoCh("store event BUY_HERO_PH_SUCCESS success", _productId);
							HeroStatusModel.instance.heroLifeCount = 10;
							HeroStatusModel.instance.setHeroStatusFull();
							GamePlayerDataProxy.instance.saveGamelLevInfo();
							
							if(UIManagerDelegate.instance.gameLevViewController)
							{
								this.notify(CommandViewType.GAME_LEVEL_RESET);
								this.notify(CommandViewType.CLOSE_STORE_VIEW);				
							}
							if(UIManagerDelegate.instance.gameEndMenuController)
								UIManagerDelegate.instance.removePanel(UIManagerDelegate.instance.gameEndMenuController,CommandViewType.GAMEEND_MENU);
							infoCh("store event BUY_HERO_PH_SUCCESS handler", CommandInteracType.BUY_HERO_PH_SUCCESS);
							break;
					}
				});				
				
				infoCh("store event","Called Finish on/Finish Transaction " + t.identifier); 
			}
			
			getPendingTransaction(_productStore);
		}
		
		protected function purchaseTransactionCanceled(e:TransactionEvent):void
		{
			if(UIManagerDelegate.instance.storeViewController)
				UIManagerDelegate.instance.storeViewController.showBuyresultNote(ProcuctIdEnum.buy_fail);
			
			infoCh("store event","交易失败取消" + t.identifier); 
			var i:uint = 0;
			while(e.transactions && i < e.transactions.length){
				var t:Transaction = e.transactions[i];
				i++;
				_productStore.finishTransaction(t.identifier);
			}
		}
		
		protected function PRODUCT_DETAILS_SUCCESS_HANDLER(e:ProductEvent):void
		{
			infoCh("store event","PRODUCT_DETAILS_SUCCESS_HANDLER 商品列表获取成功");
			_isInited = true;
			var productList:String = "";
			infoCh("store event","in productDetailsSucceeded "+e);
			
			var i:uint=0;
			
			while(e.products && i < e.products.length)				
			{				
				var p:Product = e.products[i];
				
				infoCh("store event","title : "+p.title);
				
				infoCh("store event","description: "+p.description);
				
				infoCh("store event","identifier: "+p.identifier);
				
				infoCh("store event","priceLocale: "+p.priceLocale);
				
				infoCh("store event","price :"+p.price);
				
				switch(p.identifier)
				{
					case ProcuctIdEnum.hp_recover_10:
						productList += "101,";
						break;
					case ProcuctIdEnum.hp_recover_50:
						productList += "102,";
						break;
					case ProcuctIdEnum.mp_recover_5:
						productList += "201,";
						break;
					case ProcuctIdEnum.mp_recover_30:
						productList += "202,";
						break;
					case ProcuctIdEnum.life_ph_3:
						productList += "301,";
						break;
				}
				i++;				
			}
			
			_productInfoModel.productList = productList;
		}
		
		protected function PRODUCT_DETAILS_FAIL_HANDLER(event:Event):void
		{
			// TODO Auto-generated method stub
			infoCh("store event","PRODUCT_DETAILS_FAIL_HANDLER 商品列表获取失败");
		}
		
		protected function onReceiptError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			/*"status" : 0,
			"receipt" : { (receipt here) }*/
			infoCh("store event","onReceiptError LOAD error");
		}
		
		protected function onReceiptComplete(event:Event):void
		{
			// TODO Auto-generated method stub
		}
		
		protected function finishTransactionSucceeded(e:TransactionEvent):void
		{
			infoCh("store event","in finishTransactionSucceeded 结束交易成功" +e);
			var i:uint=0;
			while(e.transactions && i < e.transactions.length)
			{
				var t:Transaction = e.transactions[i];
//				printTransaction(t);
				i++;
			}
		}
		
		public function printTransaction(t:Transaction):void
		{
			infoCh("store event","-------------------in Print Transaction----------------------");
			
			infoCh("store event","identifier :"+t.identifier);
			
			infoCh("store event","productIdentifier: "+ t.productIdentifier);
			
			infoCh("store event","productQuantity: "+t.productQuantity);
			
			infoCh("store event","date: "+t.date);
			
//			infoCh("store event","receipt: "+t.receipt);
			
			infoCh("store event","error: "+t.error);
			
			infoCh("store event","originalTransaction: "+t.originalTransaction);
			
			infoCh("store event","---------end of print transaction----------------------------");
		}		
		
		
		public function getPendingTransaction(prdStore:ProductStore):void
		{
			
			infoCh("store event","pending transaction");
			
			var transactions:Vector.<Transaction> = prdStore.pendingTransactions; 
			
			var i:uint=0;
			
			while(transactions && i<transactions.length)
			{
				var t:Transaction = transactions[i];
//				printTransaction(t);
				i++;
			}
		}
		
		
		private function buyProtoSuccessHandler(protoName):void
		{
			var value:Number = 0;
			infoCh("buy success handler","buyProtoSuccessHandler");
			infoCh("buy success handler protoName",protoName);
			switch(protoName)
			{
				case ProcuctIdEnum.hp_recover_10:
					value = _dataInfoModel.hpProtoCount+6;
					_dataInfoModel.hpProtoCount = value;
					break;
				
				case ProcuctIdEnum.hp_recover_50:
					value = _dataInfoModel.hpProtoCount+50;
					_dataInfoModel.hpProtoCount = value;
					
					break;
				
				case ProcuctIdEnum.mp_recover_5:
					value = _dataInfoModel.mpProtoCount+5;
					_dataInfoModel.mpProtoCount = value;
					break;
				
				case ProcuctIdEnum.mp_recover_30:
					value = _dataInfoModel.mpProtoCount+30;
					_dataInfoModel.mpProtoCount = value;
					break;
			}
			
			this.saveData();
			this.refershView();
		}
		
		private function saveData():void
		{
			infoCh("buy success","saveData");
			GamePlayerDataProxy.instance.saveGamelLevInfo();
		}
		
		private function refershView():void
		{
			var hpCount:Number = _dataInfoModel.hpProtoCount;
			var mpCount:Number = _dataInfoModel.mpProtoCount;
			var liftCount:Number = _dataInfoModel.hpProtoCount;
			infoCh("buy success","refershView");
			if(UIManagerDelegate.instance.levReportViewController)
				UIManagerDelegate.instance.levReportViewController.refershProtoCount(hpCount,mpCount,liftCount)
		}
	}
	
}

class ${}
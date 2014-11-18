package game.view.gameScenceView.gameLev
{
	import com.greensock.TweenLite;
	
	import flash.utils.getDefinitionByName;
	
	import citrus.objects.CitrusSprite;
	
	import frame.command.AppNotification;
	import frame.command.BaseNotification;
	import frame.command.cmdInterface.INotification;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.manager.CEEngineManager;
	import game.manager.dicManager.DicManager;
	import game.view.gameScenceView.viewLayers.ScenceCeView;
	import game.view.gameScenceView.viewLayers.ScenceLevMapLayer;
	
	import starling.display.Sprite;
	
	import vo.configInfo.ObjGameLevelConfigInfo;
	import vo.configInfo.ObjSoundFileConfig;
	
	/**
	 * @author songdu
	 * 关卡视图
	 */	
	public class GameLevView extends BaseViewer
	{
		private var _scenceCeView:ScenceCeView = null;
		private var _levConfigInfo:ObjGameLevelConfigInfo = null;
		private var _levBgViewLayer:CitrusSprite = null;
		private var _levMapOrnamentViewLayer:CitrusSprite = null;
		
		private var _levShotViewLayer:Sprite = null;
		private var _levMainViewLayer:ScenceLevMapLayer = null;
		private var _layerArr:Array = [];
		private var _closeShotView:BaseViewer = null;
		private var _mapOrnamentView:BaseViewer = null;
		private var _bgtView:BaseViewer = null;
		public function GameLevView()
		{
			super();
			this.initView();			
		}
		
		public function initView():void
		{
			this.buildLevViewLayer();			
		}
		public function zoomCloseShotView():void
		{
			TweenLite.to(_levShotViewLayer,.2,{transformAroundCenter:{scaleX:1.02, scaleY:1.02}, onComplete:resetZoom});
		}
		
		private function resetZoom():void
		{
			TweenLite.to(_levShotViewLayer,.2,{transformAroundCenter:{scaleX:1, scaleY:1},delay:0.2});
		}
		
		
		override public function dispose():void
		{
			if(_scenceCeView)
				_scenceCeView.dispose();
			_scenceCeView = null;
			if(_levMainViewLayer)
				_levMainViewLayer.dispose();
			if(_levShotViewLayer)
				_levShotViewLayer.dispose();
			_levShotViewLayer = null;
			_levMainViewLayer = null;
			
			if(_closeShotView)
				_closeShotView.dispose();
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		public function initGameLevView(tmxXml:XML,levConfigInfo:ObjGameLevelConfigInfo):void
		{
			_scenceCeView = new ScenceCeView(); 
			_scenceCeView.setTmx(tmxXml);
			CEEngineManager.instance.ceEngine.state = _scenceCeView;	
			_levMainViewLayer.addChild(_scenceCeView);
			_levConfigInfo = levConfigInfo;
			this.buildScenceOrnamentView();
			this.playScenceSound();
		}
		
		private function playScenceSound():void
		{
			var soundInfo:ObjSoundFileConfig = DicManager.instance.getScenceSoundInfoById(_levConfigInfo.scenceSoundId);
			if(soundInfo)
				soundExpressions.playGameLevBgSound(soundInfo.soundId,soundInfo.fileName);
		}
		/**
		 * 构建场景点缀视图（近景和地图点缀视图） 
		 * 
		 */		
		private function buildScenceOrnamentView():void
		{
			if("" != _levConfigInfo.changeBgMsg)
			{
				this.sendNotification(_levConfigInfo.changeBgMsg);
			}
			
			if("" != _levConfigInfo.closeShotViewClassName)
			{
				var closeShotViewCls:Class  = getDefinitionByName(_levConfigInfo.closeShotViewClassName) as Class;
				_closeShotView = new closeShotViewCls();
				_levShotViewLayer.addChild(_closeShotView);
			}
			
			if("" != _levConfigInfo.mapOrnamentView)
			{
				var mapOrnamentViewCls:Class  = getDefinitionByName(_levConfigInfo.mapOrnamentView) as Class;
				_mapOrnamentView = new mapOrnamentViewCls();
				_levMapOrnamentViewLayer.view = _mapOrnamentView;
				_scenceCeView.addlevMapOrnamentView(_levMapOrnamentViewLayer);				
			}	
		}
		
		/**
		 * 构建场景层级 
		 * 
		 */		
		private function buildLevViewLayer():void
		{
			_levMapOrnamentViewLayer = new CitrusSprite("mapOrnamentView");
			
			_levMainViewLayer  = new ScenceLevMapLayer();
			_levMainViewLayer.x = 0;
			_levShotViewLayer = new Sprite();
			this.addChild(_levShotViewLayer);
			
			
			_layerArr.push(_levMainViewLayer);
			_layerArr.push(_levShotViewLayer);
			
			for(var i:Number = 0; i < _layerArr.length; i++)
			{
				this.addChild(_layerArr[i]);
			}
		}
		
		
		/**
		 * 发送通知 
		 * @param commandType
		 * @param data
		 * 
		 */		
		public function sendNotification(commandType:String, data:Object = null):void
		{
			var notification:INotification = new BaseNotification();
			notification.data = data;
			
			var note:AppNotification = new AppNotification(commandType, notification);
			note.dispatch();
		}
	}
}
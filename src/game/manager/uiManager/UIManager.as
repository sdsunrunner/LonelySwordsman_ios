package  game.manager.uiManager
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import frame.view.UILayoutStrategyEnum;
	import frame.view.viewLayer.ViewLayer;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	/**
	 * ui管理器 
	 * @author songdu.greg
	 * 
	 */	
	public class UIManager
	{
		private static var _instance:UIManager = null;
		
		
		private var _layerBg:ViewLayer = null; // 背景层
		private var _layerMain:ViewLayer = null; // 主视图层
		private var _layeControllerView:ViewLayer = null; //控制视图
		private var _layeGuiView:ViewLayer = null; //gui视图
		private var _layeGameCgView:ViewLayer = null; //cg视图
		private var _layeGameEndkView:ViewLayer = null; //游戏结束
		private var _layemaskView:ViewLayer = null; //场景遮挡
		private var _layeGameSysView:ViewLayer = null; //游戏系统层
		private var _layeGameLevView:ViewLayer = null; //关卡视图层
		
		private var _layeAlertLevView:ViewLayer = null; //提示信息层
		private var _layerList:Array = null;		
		private var _rootContailer:DisplayObjectContainer = null;		
		private var _layerDic:Dictionary = null;//保存view 对layer的映射		
		
//==============================================================================
// Public Functions
//==============================================================================
		public function UIManager(code:$)
		{
			_layerList = [];
			_layerDic = new Dictionary();
		}	
		
		/**
		 * 存储舞台对象
		 */		
		public function get appStage():DisplayObject
		{
			return _rootContailer;
		}
		
		public static function get instance():UIManager
		{
			return _instance ||= new UIManager(new $);
		}
		
		/**
		 * 获取 主场景的childindex
		 * @return 
		 * 
		 */		
		public function getLayerMainIndex():Number
		{
			return _rootContailer.getChildIndex(_layerMain);
		}
		
		public function removePanel(currentViewer:DisplayObject):void
		{
			var currentLayer:ViewLayer = _layerDic[currentViewer];
			if(currentLayer)
			{
				while(currentLayer.numChildren > 0)
				{
					currentLayer.removeChildAt(0);
				}
			}
		}
		
		/**
		 * 将layer添加到不同位置 
		 * 提供几种布局方式，如果需要更多布局方式在子类中添加
		 * @param panel
		 * @param layerShowStrategy
		 * 
		 */		
		public function addPanel(panel:DisplayObject, layerShowStrategy:String):void
		{
			var child:DisplayObject = DisplayObject(panel);
			
			switch(layerShowStrategy)
			{
				case UILayoutStrategyEnum.LAYER_BG:
					_layerBg.setLayoutStrategy(UILayoutStrategyEnum.LAYER_BG);
					_layerBg.addViewerToLayer(child);
					_layerDic[panel] = _layerBg;
					break;
				
				case UILayoutStrategyEnum.LAYER_MAIN:
					_layerMain.setLayoutStrategy(UILayoutStrategyEnum.LAYER_MAIN);
					_layerMain.addViewerToLayer(child);
					_layerDic[panel] = _layerMain;
					break;
				
				case UILayoutStrategyEnum.CONTROLBAR_LAYER:
					_layeControllerView.setLayoutStrategy(UILayoutStrategyEnum.CONTROLBAR_LAYER);
					_layeControllerView.addViewerToLayer(child);
					_layerDic[panel] = _layeControllerView;
					break;
				
				case UILayoutStrategyEnum.GAME_GUI_LAYER:
					_layeGuiView.setLayoutStrategy(UILayoutStrategyEnum.GAME_GUI_LAYER);
					_layeGuiView.addViewerToLayer(child);
					_layerDic[panel] = _layeGuiView;
					break;
				
				case UILayoutStrategyEnum.SCENCE_MASK_LAYER:
					_layemaskView.setLayoutStrategy(UILayoutStrategyEnum.SCENCE_MASK_LAYER);
					_layemaskView.addViewerToLayer(child);
					_layerDic[panel] = _layemaskView;
					break;
				case UILayoutStrategyEnum.GAME_STORY_CG_LAYER:
					_layeGameCgView.setLayoutStrategy(UILayoutStrategyEnum.GAME_STORY_CG_LAYER);
					_layeGameCgView.addViewerToLayer(child);
					_layerDic[panel] = _layeGameCgView;
					break;
				
				case UILayoutStrategyEnum.GAME_END_VIEW_LAYER:
					_layeGameEndkView.setLayoutStrategy(UILayoutStrategyEnum.GAME_END_VIEW_LAYER);
					_layeGameEndkView.addViewerToLayer(child);
					_layerDic[panel] = _layeGameEndkView;
					break;
				
				case UILayoutStrategyEnum.SYS_LAYER:
					_layeGameSysView.setLayoutStrategy(UILayoutStrategyEnum.SYS_LAYER);
					_layeGameSysView.addViewerToLayer(child);
					_layerDic[panel] = _layeGameSysView;
					break;
				
				
				
				case UILayoutStrategyEnum.GAME_LEV_VIEW_LAYER:
					_layeGameLevView.setLayoutStrategy(UILayoutStrategyEnum.GAME_LEV_VIEW_LAYER);
					_layeGameLevView.addViewerToLayer(child);
					_layerDic[panel] = _layeGameLevView;
					break;
				
				
				case UILayoutStrategyEnum.ALERT_LAYER:
					_layeAlertLevView.setLayoutStrategy(UILayoutStrategyEnum.ALERT_LAYER);
					_layeAlertLevView.addViewerToLayer(child);
					_layerDic[panel] = _layeAlertLevView;
					break;
				
				
			}
		}
		
		/**
		 * 注册根容器
		 * @param stage
		 * 
		 */		
		public function registerStage():void
		{
			// 保存舞台
			_rootContailer = Const.starlingInstance.stage;
			//制造面板容器
			this.initLayers();
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		private function initLayers():void
		{
			_layerBg = new ViewLayer();
			_rootContailer.addChildAt(_layerBg,0);
			
			_layerMain = new ViewLayer();
			_layerList.push(_layerMain);
			
			_layeGameLevView = new ViewLayer();
			_layerList.push(_layeGameLevView);
			
			_layeControllerView = new ViewLayer();
			_layerList.push(_layeControllerView);
			
			_layeGuiView = new ViewLayer();
			_layerList.push(_layeGuiView);
			
			
			_layeGameCgView = new ViewLayer();
			_layerList.push(_layeGameCgView);
			
			
			_layeGameEndkView = new ViewLayer();
			_layerList.push(_layeGameEndkView);
			
			_layemaskView = new ViewLayer();
			_layerList.push(_layemaskView);
		
			_layeGameSysView = new ViewLayer();
			_layerList.push(_layeGameSysView);
			
			_layeAlertLevView = new ViewLayer();
			_layerList.push(_layeAlertLevView);
			this.addLayers();
		}
		
		/**
		 * 添加所有层到舞台 
		 * 
		 */		
		private function addLayers():void
		{
			var rect:Rectangle = getViewRect();
			for each (var layer:ViewLayer in _layerList)
			{
				
				_rootContailer.addChild(layer);
				layer.setLayerRect(rect);
			}
		}
		
		/**
		 * 实际视口范围
		 * @return
		 *
		 */
		public function getViewRect():Rectangle
		{
			var stgW:int = Const.STAGE_WIDTH;
			var stgH:int = Const.STAGE_HEIGHT;
			
			var rect:Rectangle = new Rectangle;
			rect.width = stgW;
			rect.height = stgH;
			return rect;
		}
		
		
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-	
	
	}
}

class ${}
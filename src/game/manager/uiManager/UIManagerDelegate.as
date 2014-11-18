package  game.manager.uiManager
{
	import flash.utils.Dictionary;
	
	import frame.commonInterface.IUIManagerDelegate;
	import frame.view.LayerEvent;
	import frame.view.UILayoutStrategyEnum;
	import frame.view.viewInterface.IViewerController;
	
	import game.interactionType.CommandViewType;
	import game.view.bgView.mountainView.BgMountainViewController;
	import game.view.bgView.pillarView.BgPillarViewController;
	import game.view.controlView.ControlViewController;
	import game.view.gameEndMenu.GameEndMenuController;
	import game.view.gameScenceView.gameLev.GameLevViewController;
	import game.view.gameStartCg.StartCgViewController;
	import game.view.guiLayer.GuiViewController;
	import game.view.infoAlert.AlertViewController;
	import game.view.levEndView.LevEndViewController;
	import game.view.levReport.LevReportViewController;
	import game.view.scenceSwitch.ScenceSwitchMaskViewController;
	import game.view.store.StoreViewController;
	import game.view.storyCg.StoryCgViewController;
	import game.view.welcomeScence.WelcomeSenceViewController;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ui管理策略 
	 * @author songdu.greg
	 * 
	 */	
	public class UIManagerDelegate implements IUIManagerDelegate
	{
		//单例对象
		private static var _instance:UIManagerDelegate = null;
		
		private var _uiManager:UIManager = null;
		//保存所有的controller的键值对表
		private var _controllerHash:Object/* key:String(ui 名字), value:IViewerController */ = {};
		//保存viewer对controller的映射关系
		private var _v2cDic:Dictionary = new Dictionary(true);
		//当前进行操作的viewer
		private var _currentViewer:DisplayObjectContainer;
//==============================================================================
// Public Functions
//==============================================================================
		public function UIManagerDelegate(code:$)
		{
			_uiManager = UIManager.instance;
		}
		
		public static function get instance():UIManagerDelegate
		{
			return _instance ||= new UIManagerDelegate(new $);
		}
		
		/**
		 * 创建并添加显示面板 
		 * @param viewerController
		 * @param type
		 * 
		 */		
		public function createAndAddPanel(viewerController:IViewerController, type:String):void
		{
			this.createPanel(viewerController, type);
			this.addPanel(viewerController, type);
		}
		
		public function addPanel(viewerController:IViewerController, type:String):void
		{
			var viewer:DisplayObjectContainer = viewerController.viewer;
			this.showPanel(viewer, type);
			_v2cDic[viewer] = new CtrlAndType(viewerController, type);
		}
		
		/**
		 * 创建显示层 
		 * @param viewerController
		 * @param type
		 * 
		 */		
		public function createPanel(viewerController:IViewerController, type:String):void
		{
			var old:IViewerController = getController(type);
			if(old != null && old != viewerController)
			{
				this.removePanel(old, type);
			}
			if(viewerController != null)
			{
				this.organizeViewerController(viewerController, type);
			}
		}
	
		/**
		 * 删除映射关系并销毁view 
		 * @param viewerController
		 * @param type
		 * 
		 */		
		public function removePanel(viewerController:IViewerController, type:String):void
		{
			if(viewerController != null && _controllerHash[type] != null)
			{
				this.organizeViewerController(null, type);
				_currentViewer = viewerController.viewer;
				if(_currentViewer != null)
					_uiManager.removePanel(_currentViewer);
				viewerController.dispose();
			}
		}
		
		/**
		 * 通过已注册的ui名找到对应的controller
		 * @param type
		 * @return 
		 * 
		 */		
		public function getController(type:String):IViewerController
		{
			return _controllerHash[type];
		}
		
		/**
		 * 显示面板，根据名字，确定放到主界面的哪个layer上
		 * 需要在子类中复写
		 */
		protected function showPanel(viewer:DisplayObjectContainer, type:String):void
		{
			switch(type)
			{	
				case CommandViewType.BG_MOUNTAIN_VIEW:
				case CommandViewType.BG_PILLAR_VIEW:
				{
					this._uiManager.addPanel(viewer, UILayoutStrategyEnum.LAYER_BG);
					break;
				}
					
			   case CommandViewType.CONTROLLE_VIEW:
			   {
				   this._uiManager.addPanel(viewer, UILayoutStrategyEnum.CONTROLBAR_LAYER);
				   break;
			   }
				  
			 
			   case  CommandViewType.GAME_STORY_START_CG:
			   case CommandViewType.WELCOME_SCENCE:	
			   {
				   this._uiManager.addPanel(viewer, UILayoutStrategyEnum.LAYER_MAIN);
				   break;
			   }
				   
			   case  CommandViewType.GAME_GUI_VIEW:
			   {
				   this._uiManager.addPanel(viewer, UILayoutStrategyEnum.GAME_GUI_LAYER);
				   break;
			   }
				   
			   case CommandViewType.SCENCE_SWITCH:
			   {
				   this._uiManager.addPanel(viewer, UILayoutStrategyEnum.SCENCE_MASK_LAYER);
				   break;
			   }
				   
			   case  CommandViewType.GAMEEND_MENU:
			   case  CommandViewType.GAME_LEV_END_VIEW:
			   case  CommandViewType.LEV_REPORT_VIEW:
			   {
				   this._uiManager.addPanel(viewer, UILayoutStrategyEnum.GAME_END_VIEW_LAYER);
				   break;
			   }
				   
				case CommandViewType.GAME_STORY_CG:
				{
					this._uiManager.addPanel(viewer, UILayoutStrategyEnum.GAME_STORY_CG_LAYER);
					break;
				}	   
					
				case  CommandViewType.GAME_LEVEL_VIEW:
				{
					this._uiManager.addPanel(viewer, UILayoutStrategyEnum.GAME_LEV_VIEW_LAYER);
					break;						
				}
				case CommandViewType.PRODUCT_STORE_VIEW:
				{
					this._uiManager.addPanel(viewer, UILayoutStrategyEnum.SYS_LAYER);
					break;
				}
				case CommandViewType.INFO_ALERT_VIEW:
				{
					this._uiManager.addPanel(viewer, UILayoutStrategyEnum.ALERT_LAYER);
					break;
				}
					
			}
		}
		
	
		
		/**
		 * 背景山脉视图 
		 * @return 
		 * 
		 */		
		public function get bgMountainViewController():BgMountainViewController
		{
			return getController(CommandViewType.BG_MOUNTAIN_VIEW) as BgMountainViewController;
		}
		
		/**
		 * 柱子视图控制器 
		 * @return 
		 * 
		 */		
		public function get bgPillarViewController():BgPillarViewController
		{
			return getController(CommandViewType.BG_PILLAR_VIEW) as BgPillarViewController;
		}
		
		
		/**
		 * 欢迎视图 
		 * @return 
		 * 
		 */		
		public function get welcomeSenceViewController():WelcomeSenceViewController
		{
			return getController(CommandViewType.WELCOME_SCENCE) as WelcomeSenceViewController;
		}
		
		/**
		 * 控制视图 
		 * @return 
		 * 
		 */		
		public function get controlViewController():ControlViewController
		{
			return getController(CommandViewType.CONTROLLE_VIEW) as ControlViewController;
		}
	
		/**
		 * 获取场景控制器
		 * @return 
		 * 
		 */		
		public function get gameLevViewController():GameLevViewController
		{
			return getController(CommandViewType.GAME_LEVEL_VIEW) as GameLevViewController;
		}
		
		/**
		 * 获取游戏gui视图控制器  
		 * @return 
		 * 
		 */		
		public function get guiViewController():GuiViewController
		{
			return getController(CommandViewType.GAME_GUI_VIEW) as GuiViewController;
		}
		
		/**
		 * 获取场景切换视图控制器 
		 * @return 
		 * 
		 */		
		public function get scenceSwitchMaskViewController():ScenceSwitchMaskViewController
		{
			return getController(CommandViewType.SCENCE_SWITCH) as ScenceSwitchMaskViewController;
		}
		
		/**
		 * 游戏结束菜单 
		 * @return 
		 * 
		 */		
		public function get gameEndMenuController():GameEndMenuController
		{
			return getController(CommandViewType.GAMEEND_MENU) as GameEndMenuController;
		}
		
		public function get storyCgViewController():StoryCgViewController
		{
			return getController(CommandViewType.GAME_STORY_CG) as StoryCgViewController;
		}
		
		
		public function get startCgViewController():StartCgViewController
		{
			return getController(CommandViewType.GAME_STORY_START_CG) as StartCgViewController;
		}
		
		public function get storeViewController():StoreViewController
		{
			return getController(CommandViewType.PRODUCT_STORE_VIEW) as StoreViewController;
		}
		
		
		public function get alertViewController():AlertViewController
		{
			return getController(CommandViewType.INFO_ALERT_VIEW) as AlertViewController;
		}
		
		public function get levEndViewController():LevEndViewController
		{
			return getController(CommandViewType.GAME_LEV_END_VIEW) as LevEndViewController;
		}
		
		public function get levReportViewController():LevReportViewController
		{
			return getController(CommandViewType.LEV_REPORT_VIEW) as LevReportViewController;
		}
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------
		private function onViewerRemovedFormLayer(evt:LayerEvent):void
		{
			var viewer:DisplayObject = evt.currentTarget as DisplayObject;
			var ctrlAndType:CtrlAndType = _v2cDic[viewer];
			if(ctrlAndType != null)
			{
				var ctrl:IViewerController = ctrlAndType.ctrl as IViewerController;
				var type:String = ctrlAndType.type;
				
				if (_currentViewer != viewer)
					ctrl.dispose();
				this.removePanel(ctrl, type);
				delete _v2cDic[viewer];
			}
		}
		
		/**
		 * 保存layer type对controller的映射
		 * @param viewerController
		 * @param type
		 * 
		 */		
		private function organizeViewerController(viewerController:IViewerController, type:String):void
		{
			if(!viewerController)
				delete _controllerHash[type];
			
			_controllerHash[type] = viewerController;
		}
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-	
	}
}
import frame.view.viewInterface.IViewerController;


class ${}

class CtrlAndType
{
	public var ctrl:IViewerController;
	public var type:String;
	public function CtrlAndType(c:IViewerController, t:String)
	{
		ctrl = c;
		type = t;
	}
}
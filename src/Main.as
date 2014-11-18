package
{
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import game.manager.CEEngineManager;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.core.Starling;
	
	import supportLayer.CollideLayer;
	import supportLayer.physicsViewLayer;
	
	import utils.console.initConsole;
	
	/**
	 * app入口
	 * @author songdu.greg
	 * 
	 */	
	[SWF(frameRate="60", backgroundColor="0xffffff")]
	public class Main extends Startup
	{		
		private var _deviceSize:Rectangle = null;	
	
		private var _collideLayer:CollideLayer = null;
		private var _phyView:physicsViewLayer = null;
		
		public function Main()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;      
			stage.addEventListener(Event.RESIZE, handleResize); 
			stage.addEventListener(Event.ENTER_FRAME, enterFramehandler); 
			setTimeout(initApp,500);			
		}
		
		private  function handleResize(...ig) :void
		{ 
			_deviceSize = new Rectangle(0, 0, Math.max(stage.fullScreenWidth, stage.fullScreenHeight), Math.min(stage.fullScreenWidth, stage.fullScreenHeight));
			stage.stageWidth = _deviceSize.width;
			stage.stageHeight = _deviceSize.height;
			Const.STAGE_WIDTH =  _deviceSize.width;
			Const.STAGE_HEIGHT =  _deviceSize.height;
			Const.appStage = stage;
		}
		
		protected function initApp():void
		{
			Starling.multitouchEnabled = true;
			//初始化starling
			
			this.initStarlingWithWH(Game,_deviceSize.width,_deviceSize.height,CONFIG::IMPOLDER, false,true);
			
			var debugeRectangle:Sprite = new Sprite();
			_collideLayer = new CollideLayer();
			this.addChild(_collideLayer);
			
			_phyView = new physicsViewLayer();
			this.addChild(_phyView);
			
			this.addChild(debugeRectangle);
			CEEngineManager.instance.ceEngine = this;
			
			Const.collideLayer = _collideLayer;
			Const.phyLayer = _phyView;
			_collideLayer.visible = CONFIG::DEBUG;
			_phyView.visible = false;	
			CEEngineManager.instance.setStateIndex(int.MAX_VALUE);
			
			TweenPlugin.activate([TransformAroundCenterPlugin]);	
			this.initAppConsole();
			
			//友盟key
			//531935f556240bf98200e6be
			
//			PlayerBehaviorAnalyseManager.instance.umeng.dispatchEvent("login");	
			
		}
		
		private function enterFramehandler(evt:Event):void
		{
			//初始化逐帧追踪器
			SysEnterFrameCenter.instance.notifyTrack();
		}
		
		private function initAppConsole():void
		{
			initConsole(stage);
		}
	}
}

package
{

	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	import lzm.starling.STLConstant;
	import lzm.starling.STLRootClass;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	public class Startup extends StarlingCitrusEngine
	{
		/**
		 * 根据宽高来创建starling 
		 * @param mainClass
		 * @param width
		 * @param height
		 * @param debug
		 * @param isPc		是否是在pc上
		 * @param pullUp	是否拉伸(不拉伸就留黑边)
		 * 
		 */		
		protected function initStarlingWithWH(mainClass:Class,width:int,height:int,debug:Boolean=false,isPc:Boolean=false,pullUp:Boolean=false):void
		{
			STLConstant.nativeStage = stage;
			STLConstant.StageWidth = width;
			STLConstant.StageHeight = height;
			
			Starling.handleLostContext = true;
			var stageFullScreenWidth:Number = isPc ? stage.stageWidth : stage.fullScreenWidth;
			var stageFullScreenHeight:Number = isPc ? stage.stageHeight : stage.fullScreenHeight;
			
			var viewPort:Rectangle;
			if(pullUp)
				viewPort = new Rectangle(0,0,stageFullScreenWidth,stageFullScreenHeight);
			else
			{
				viewPort = RectangleUtil.fit(
					new Rectangle(0, 0, width, height), 
					new Rectangle(0, 0,stageFullScreenWidth,stageFullScreenHeight), 
					ScaleMode.SHOW_ALL);
			}
			
			STLConstant.scale = viewPort.width > 480 ? 2 : 1;//Capabilities.screenDPI > 200 ? 2 : 1;
		
			_starling = new Starling(STLRootClass, stage, viewPort);
			Const.starlingInstance = _starling;
			_starling.antiAliasing = 16;
			_starling.stage.stageWidth  = width;
			_starling.stage.stageHeight = height;
			_starling.simulateMultitouch  = false;
			_starling.enableErrorChecking = Capabilities.isDebugger;
							
			
			if (!_starling.isStarted)
				_starling.start();
			
				
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, 
			
				function onRootCreated(event:Object, app:STLRootClass):void
				{
					STLConstant.currnetAppRoot = app;
					
					_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
					
					if(debug) _starling.showStatsAt(HAlign.LEFT);
					
					app.start(mainClass);
				});
		}
	
	}
}
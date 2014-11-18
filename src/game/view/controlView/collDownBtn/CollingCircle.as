package game.view.controlView.collDownBtn
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import extend.draw.display.Graphics;
	import extend.draw.display.Shape;
	
	import game.view.event.ControlleEvent;
	
	import starling.events.Event;
	
	/**
	 * 冷却圆圈  
	 * @author admin
	 * 
	 */	
	public class CollingCircle extends Shape
	{
		public var duration:int;
		public var length:int = 18;
		private var tempPoint : Point
		private var graph:Graphics;
		private var startTime:int;
		
		public function CollingCircle(radius:Number)
		{
			length = radius;
			graph = this.graphics;
			tempPoint = new Point(0,-length);
		}
		
		public function start():void
		{
			setTimeout(delayCallShowCoolDown,1000);
			
		}
		
		private function delayCallShowCoolDown():void
		{
			graph.clear();
			startTime = getTimer();
			this.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		private function enterFrameHandler(event:Event):void
		{
			var t:Number = getTimer() - startTime;
			if(t>duration)
			{
				this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
				draw(360);
				this.dispatchEventWith(ControlleEvent.COLL_DOWN_COMPLETE,true);
				return;
			}
			draw(t/duration * 360);
		}
		
		private function draw(angle:Number):void
		{
			var temp:Number = (angle-90)*Math.PI/180;
			graph.beginFill(0x9D9D9F);
			var ca:Number = Math.cos(temp)*length;
			var sa:Number = Math.sin(temp)*length;
			graph.moveTo(0,0);
			graph.lineTo(tempPoint.x,tempPoint.y);
			graph.lineTo(ca,sa);
			graph.lineTo(0,0);
			tempPoint.x = ca;
			tempPoint.y = sa;
			graph.endFill();
		}
	}
}
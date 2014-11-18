package game.physicsWorker
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import citrus.physics.nape.Nape;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	/**
	 * Nape 物理模拟线程
	 * @author songdu
	 * 
	 */	
	public class NapeWorker extends Sprite
	{
		protected var space:Space;
		
		protected var variableStep:Boolean;
		protected var prevTime:int;
		
		protected var velIterations:int = 10;
		protected var posIterations:int = 10;
		protected var customDraw:Boolean = false;
		
		protected var params:Object;
	
		protected function preStep(deltaTime:Number):void {}
		protected function postUpdate(deltaTime:Number):void {}
		
		
		public var _sprites:Vector.<NapeSprite> = null;
		
//		private var _nape:Nape = null;
		
		private var oneWayType:CbType;
		private var teleporterType:CbType;
		
		public function NapeWorker()
		{
			params = {gravity: Vec2.get(0, 600)};			
			super();			
			if (params.velIterations != null)
				velIterations = params.velIterations;
			
			if (params.posIterations != null) 
				posIterations = params.posIterations;			
			if (params.customDraw != null)
				customDraw = params.customDraw;
			this.params = params;
				
			
			_sprites = new Vector.<NapeSprite>();
//			_traceCenter = SysEnterFrameCenter.instance;
//			_nape = new Nape("nape");
		}
		
		protected function init():void
		{
			
		}
		
		
//		public function get nape():Nape
//		{
//			return _nape;
//		}
		/**
		 * 激活物理模拟 
		 * 
		 */		
		public function active():void
		{
//			_traceCenter.register(this);
		}
		
		/**
		 * 暂停物理模拟
		 * 
		 */		
		
		public function pause():void
		{
//			_traceCenter.unRegister(this);
		}
		
		/**
		 * 关闭物理模拟 
		 * 
		 */		
		public function disActive():void
		{
//			_traceCenter.unRegister(this);
			_sprites = null;
		}
		
		/**
		 * 在enterframe里模拟物理 
		 * @param msg
		 * @param msgName
		 * 
		 */		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			var curTime:uint = getTimer();
			var deltaTime:Number = (curTime - prevTime);
			if (deltaTime == 0) 
			{
				return;
			}			
			var noStepsNeeded:Boolean = false;
			
			if (variableStep)
			{
				if (deltaTime > (1000 / 30))
				{
					deltaTime = (1000 / 30);
				}
				
				preStep(deltaTime * 0.001);
				if (space != null) 				
					space.step(deltaTime * 0.001, velIterations, posIterations);
				
				prevTime = curTime;
			}
			else 
			{
				var stepSize:Number = (1000 / stage.frameRate);
				stepSize = 1000/60;
				var steps:uint = Math.round(deltaTime / stepSize);
				
				var delta:Number = Math.round(deltaTime - (steps * stepSize));
				prevTime = (curTime - delta);
				if (steps > 4)				
					steps = 4;
				
				deltaTime = steps * stepSize;
				
				if (steps == 0)
					noStepsNeeded = true;
				
				
				
				while (steps-- > 0)
				{
					preStep(stepSize * 0.001);
					if (space != null)
					{
						space.step(stepSize * 0.001, velIterations, posIterations);
					}
				}
			}	
		}
		
		/**
		 * Add a static object (wall floor etc, can consist of multiple shapes
		 **/
		public function addStaticBody(id:String,shapes:Vector.<Rectangle>):void 
		{
			var border:Body = new Body(BodyType.STATIC);
			for(var i:int = 0; i < shapes.length; i++)
			{
				var rect:Rectangle = shapes[i];
				border.shapes.add(new Polygon(Polygon.rect(rect.x, rect.y, rect.width, rect.height)));
			}
			border.space = space;
		}
		
		/**
		 * Add a dynamic box object
		 **/
		public function addBox(id:String, x:int, y:int, w:int, h:int):void 
		{
			try 
			{
				var block:Polygon = new Polygon(Polygon.box(w, h));
				var box:Body = new Body(BodyType.DYNAMIC);
				box.shapes.add(block);
				box.position.setxy(x, y);
				box.space = space;
			
				var dummySprite:NapeSprite = new NapeSprite(id, w, h);
				_sprites.push(dummySprite);
			}
			catch(e:Error)
			{

			}
		}
		
		

	}
}
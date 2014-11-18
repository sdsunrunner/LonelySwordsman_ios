package utils
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.EnterFrameEvent;
	import starling.filters.DisplacementMapFilter;
	import starling.textures.Texture;

	/**
	 * 效果工具 
	 * @author admin
	 * 
	 */	
	public class EffectUtils
	{
		/**
		 * 水波滤镜 
		 * @param target
		 * 
		 */		
		public static function addReflectionTo(target:DisplayObject):void
		{
			var offset:Number = 0;
			var scale:Number = Starling.contentScaleFactor;
			var width:int = target.width * scale;
			var height:int = target.height * scale;
			var perlinData:BitmapData = new BitmapData(width, height, false);
			perlinData.perlinNoise(200*scale, 20*scale, 2, 5, true, true, 0, true);
			var dispMap:BitmapData = new BitmapData(width, height*2, false);
			dispMap.copyPixels(perlinData,perlinData.rect, new Point(0,0));
			dispMap.copyPixels(perlinData,perlinData.rect, new Point(0,perlinData.height));
			var texture:Texture = Texture.fromBitmapData(dispMap);
			var filter:DisplacementMapFilter = new DisplacementMapFilter(texture, null,
				BitmapDataChannel.RED, BitmapDataChannel.RED, 40, 5);
			target.filter = filter;
			target.addEventListener("enterFrame", function(event:EnterFrameEvent):void
			{
				if (offset > height) offset = 0;
				else offset += event.passedTime * scale * 20;
				filter.mapPoint.y = offset - height;
			});
		}
	}
}
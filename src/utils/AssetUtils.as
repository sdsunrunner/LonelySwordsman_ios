package utils
{
	import flash.geom.Rectangle;
	

	public class AssetUtils
	{
		/**
		 * 由xml路径获取xml  
		 * @param xmlUrl
		 * @return 
		 * 
		 */		
		public static function getAssetNameByUrl(url:String):String
		{
			var assetNameArr:Array = url.split("/");
			var assetName:String = assetNameArr[assetNameArr.length-1];
			assetName = assetName.replace(".xml","");
			assetName = assetName.replace(".png","");
			assetName = assetName.replace(".tmx","");
			assetName = assetName.replace(".jpg","");
			assetName = assetName.replace(".map","");
			assetName = assetName.replace(".avi","");
			assetName = assetName.replace(".atf","");
			return assetName
		}
		
		/**
		 * 获取Tmx视图的边界 
		 * @param tmx
		 * @return 
		 * 
		 */		
		public static function getTmxBounds(tmx:XML):Rectangle
		{
			if(tmx)
			{
				var width:Number = tmx.@width;
				var height:Number = tmx.@height;
				var tileWidth:Number = tmx.@tilewidth;
				var tileHeight:Number = tmx.@tileheight;
				
				return  new Rectangle(0,0,width*tileWidth,height*tileHeight);
			}
			return  new Rectangle(0,0,0,0);
		}
	}
}
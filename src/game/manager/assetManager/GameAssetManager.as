package game.manager.assetManager
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import utils.AssetUtils;
	
	/**
	 * 游戏资源管理器 
	 * @author songdu.greg
	 * 
	 */	
	public class GameAssetManager extends AssetManager
	{
		private static var _instance:GameAssetManager = null;
		
		private var _mapTexture:TextureAtlas = null;
		private var _textureName:String = "";
		private var _point:Point = new Point;		
	
		public function GameAssetManager(code:$,scaleFactor:Number=-1, createMipmaps:Boolean=true)
		{
			super(scaleFactor, createMipmaps);
		}
		
		public static function get instance():GameAssetManager
		{
			return _instance ||= new GameAssetManager(new $(),1,false);
		}
		
		/**
		 * 获取纹理的 BitmapData对象用于碰撞检测
		 * 只适用于png/jpg纹理
		 * @param itemName
		 * @return 
		 * 
		 */		
		public function getBitmapForHitByName(itemName:String):BitmapData
		{
			if("" == _textureName)
				_textureName = AssetUtils.getAssetNameByUrl(ResConst.HURT_HIT_RANG_RES);
			
			var itemRect:Rectangle = getTextureAtlas(_textureName).getRegion(itemName);
			var bmpData:BitmapData = new BitmapData(itemRect.width,itemRect.height);			
			bmpData.copyPixels(bitmapDataForHitDic[_textureName],itemRect, _point);			
			return bmpData;
		}		
		public function getMapTextureAtlas():TextureAtlas
		{
			if(null == _mapTexture)
				_mapTexture = getTextureAtlas("sence_map");
			
			return _mapTexture;
		}		
	}
}

class ${}
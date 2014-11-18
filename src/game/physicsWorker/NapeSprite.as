package game.physicsWorker
{
	import flash.display.Sprite;

	/**
	 * 物理模拟现实对象 
	 * @author songdu
	 * 
	 */	
	public class NapeSprite extends Sprite
	{
		private var _id:String;
		
		public function NapeSprite(id:String,w:Number,h:Number)
		{
			this._id = id;
		}
	}
}
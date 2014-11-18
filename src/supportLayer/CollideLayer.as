package supportLayer
{
	import flash.display.Sprite;
	
	/**
	 * 碰撞检测层 
	 * @author admin
	 * 
	 */	
	public class CollideLayer extends Sprite
	{
		public function CollideLayer()
		{
			super();
			this.alpha = 0.2;
			this.mouseEnabled = false;
		}
	}
}
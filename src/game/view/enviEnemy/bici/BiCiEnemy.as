package game.view.enviEnemy.bici
{
	import citrus.objects.platformer.nape.Enemy;
	
	import frame.commonInterface.IDispose;
	
	import nape.callbacks.InteractionCallback;
	
	import utils.MaterialUtils;
	
	/**
	 * 墙壁上的尖刺 
	 * @author admin
	 * 
	 */	
	public class BiCiEnemy extends Enemy implements IDispose
	{
		private var _view:BiCiEnemyView = null;
		public function BiCiEnemy(name:String, params:Object=null)
		{			
			if(params)
			{
				if(!params.view)
				{
					_view = new BiCiEnemyView();
					params.view = _view;
				}
			}
			
			super(name, params);
			this.initAttributes();
			this.addListeners();
		}
		
		override public function turnAround():void
		{
			
		}
		
		override public function update(timeDelta:Number):void 
		{
			velocity.y = 0;
			velocity.x = 0;
			this.speed = 0;
		}
		
		override protected function createMaterial():void 
		{			
			_material = MaterialUtils.createEnemyMaterial();
		}
		
		override public function hurt():void
		{
			
		}
		
		override public function handleBeginContact(callback:InteractionCallback):void 
		{
			
		}
		
		override protected function endHurtState():void
		{
			
		}
		
		public function dispose():void
		{			
			_view = null;
		}
		
		private function initAttributes():void
		{
		
		}
		
		private function addListeners():void
		{
			
		}
	}
}
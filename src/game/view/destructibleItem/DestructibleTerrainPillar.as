package game.view.destructibleItem
{
	import flash.utils.clearTimeout;
	
	import enum.GameRoleEnum;
	
	import game.manager.dicManager.DicManager;
	import game.view.enemySoldiers.BaseEnemy;
	import game.view.enemySoldiers.EnemyEvent;
	
	import starling.events.Event;
	
	import vo.configInfo.roleConfig.ObjRoleConfigInfo;
	
	/**
	 * 可破坏柱子 
	 * @author admin
	 * 
	 */	
	public class DestructibleTerrainPillar extends BaseEnemy
	{
		private var _view:TerrainPillarView = null;
		private var _configInfo:ObjRoleConfigInfo = null;
		public function DestructibleTerrainPillar(name:String, params:Object=null)
		{
			if(params)
			{
				if(!params.view)
				{
					_view = new TerrainPillarView();
					params.view = _view;
				}
			}
			
			super(name, params);
			this.initAttributes();
			this.addListeners();
		}
		
		private function addListeners():void
		{
			_view.addEventListener(EnemyEvent.REMOVE_ENMY_NOTE,removeEnemyHandler);
		}
		private function initAttributes():void
		{
			_configInfo = getConfigInfo();
			this.speed = _configInfo.maxVelocity;
			_view.maxHp = _configInfo.maxHp;
		}
		
		override public function destroy():void 
		{
			if(_view.currentHp <=0 )
			{
				super.destroy();	
			}
		}
		
		override public function turnAround():void
		{
			
			
		}
		override public function update(timeDelta:Number):void 
		{

		}
		
		
		private function removeEnemyHandler(evt:Event):void
		{
			this.dispose();
		}
		
		override public function dispose():void
		{
			super.destroy();
			_configInfo = null;
			_view.dispose();
		}
		
		private function getConfigInfo():ObjRoleConfigInfo
		{
			return DicManager.instance.getRoleConfigInfoById(GameRoleEnum.TERRAIN_PILLA_ID);
		}
	}
}
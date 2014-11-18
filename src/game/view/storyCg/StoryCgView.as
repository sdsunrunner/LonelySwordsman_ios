package game.view.storyCg
{
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.storyCg.bossDeath.FinallBossDeathCgView;
	import game.view.storyCg.bossDia.FinallBossDiaCgView;
	
	/**
	 * 剧情cg视图 
	 * @author admin
	 * 
	 */	
	public class StoryCgView extends BaseViewer
	{
		private var _cgView:BaseViewer = null;
		
		private var _currnetCgType:String = "";
		
		public function StoryCgView()
		{
			super();
		}
		
		override public function dispose():void
		{
			if(_cgView)
				_cgView.dispose();
			_cgView = null;
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		/**
		 * 显示cg动画 
		 * @param currnetCgType
		 * 
		 */		
		public function showCgView(currnetCgType:String):void
		{
			switch(currnetCgType)
			{
				case CgTypeEnum.TYPE_BOSS_DIA:
					_cgView = new FinallBossDiaCgView();					
					break;
				
				case CgTypeEnum.TYPE_BOSS_DEATH:
					_cgView = new FinallBossDeathCgView();					
					break;
			}
			
			this.addChild(_cgView);
		}
	}
}
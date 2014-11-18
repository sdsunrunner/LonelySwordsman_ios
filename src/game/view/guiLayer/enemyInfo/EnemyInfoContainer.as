package game.view.guiLayer.enemyInfo
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import enum.MsgTypeEnum;
	
	import frame.view.IObserver;
	
	import game.view.models.HeroStatusModel;
	
	import starling.display.Sprite;
	
	import vo.ObjEnemyStatusInfo;
	
	/**
	 * 敌人信息容器 
	 * @author admin
	 * 
	 */	
	public class EnemyInfoContainer extends Sprite implements IObserver
	{
		private var _dataModel:EnemyGuiInfoDataModel = null;
		private var _herodataModel:HeroStatusModel = null;
		
		private var _dataDic:Dictionary = null;
		private var _viewDic:Dictionary = null;
		private var _heroPos:Point = null;
		private var _infoArr:Array = [];		
		private var _minDis:Number = 0;
		public function EnemyInfoContainer()
		{			
			super();
			this.initView();
			this.initModel();
		}	

		public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.ENEMY_INFO_UPDATE)
			{
				_dataDic = data as Dictionary;
				if(null == _dataDic)
				{
					_infoArr = [];
					while(this.numChildren>0)
					{
						this.removeChildAt(0);
					}
					
					for (var key:* in _viewDic)
					{
						delete _viewDic[key];
						_viewDic[key] = null;						
					}
					_viewDic = null;
				}
					
			}
			
			if(msgName == MsgTypeEnum.HERO_POS_UPDATE)
			{
				_heroPos = data as Point;
			}			
			
			this.updateView();
		}		
		
		override public function dispose():void
		{
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			super.dispose();
			_dataModel.unRegister(this);
			_herodataModel.unRegister(this);
			
			this.removeEventListeners();
		}
	
		private function initView():void
		{
			_minDis = Const.SHOW_ENEMY_INFO_DIS;
//			this.scaleX = 1.2;
//			this.scaleY = 1.2;
		}		
		
		private function initModel():void
		{
			_dataModel = EnemyGuiInfoDataModel.instance;
			_dataModel.register(this);
			
			_herodataModel = HeroStatusModel.instance;
			_herodataModel.register(this);
		}
		
		private function updateView():void
		{
			if(null == _viewDic)
				_viewDic = new Dictionary();		
			for (var key:* in _dataDic)
			{
				var data:ObjEnemyStatusInfo = _dataDic[key] as ObjEnemyStatusInfo;
				var enemyInfoView:EnemyInfoItemView = _viewDic[key];
				if(null == enemyInfoView)
				{
					enemyInfoView = new EnemyInfoItemView();
					_viewDic[key] = enemyInfoView;				
					this.addChild(enemyInfoView);	
					_infoArr.push(enemyInfoView);
				}
				enemyInfoView.updateView(data);
			}		
			
			this.updateViewlayout();
		}
		
		private function updateViewlayout():void
		{
			var count:Number = 0;
			for(var i:Number = 0; i < _infoArr.length; i++)
			{
				var itemView:EnemyInfoItemView = _infoArr[i];
				var info:ObjEnemyStatusInfo = itemView.info;
				if(info && info.currentPos && _heroPos)
				{
					var posDis:Number = Point.distance(info.currentPos,_heroPos);
					if(!info.isDead&& posDis < _minDis && info.currentHp>0)
					{					
						itemView.showRoleInfo();
						itemView.y = count*80;
						count++;
					}
					else
						itemView.hideRoleInfo();
				}
				else
					itemView.hideRoleInfo();
			}			
		}
	}
}
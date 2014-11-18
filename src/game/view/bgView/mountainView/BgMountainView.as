package game.view.bgView.mountainView
{
	import flash.geom.Point;
	
	import enum.MsgTypeEnum;
	
	import extend.draw.display.Shape;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.models.HeroMoveStepModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SysEnterFrameCenter;
	import game.view.superView.BaseCycleView;
	import game.view.superView.model.BaseCycleViewMoveDataModel;
	import game.view.superView.model.BaseCycleViewMoveTypeEnum;
	
	import starling.display.Image;
	
	/**
	 * 背景山脉视图 
	 * @author songdu.greg
	 * 
	 */	
	public class BgMountainView extends BaseViewer implements ITrackable
	{
		private var _stageBgImage:Image = null;
		private var _vistaMountainView:BaseCycleView = null;
		private var _mediumshotMountainView:BaseCycleView = null;
		private var _dataModel:BaseCycleViewMoveDataModel = null;
		
		private var _mountainBgView:Shape = null;
		private var _movemodel:HeroMoveStepModel = null;
		private var _heroPosModel:HeroStatusModel = null;
		
		private var _trackCenter:SysEnterFrameCenter = null;

		public function BgMountainView()
		{
			
			super();
			this.initView();
			this.initModel();
			this.setMoveStatus();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_dataModel.unRegister(this);
			_mediumshotMountainView.dispose();
			_vistaMountainView.dispose();
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		override public function initModel():void
		{
			_dataModel = BaseCycleViewMoveDataModel.instance;
			_dataModel.register(this);
			
			_trackCenter = SysEnterFrameCenter.instance;
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_MOVE)
			{
				var num:Number = data as Number;
				if(num!=0)
				{
					_vistaMountainView.updateScencePos(num*Const.VISTA_MOVE_OFFSET_VALUE);
					_mediumshotMountainView.updateScencePos(num*Const.MEDIUM_MOVE_OFFSET_VALUE);
				}
			}
			
			if(msgName == MsgTypeEnum.HERO_POS_UPDATE)
			{
				var heroPos:Point = data as Point;
				if(heroPos)
				{
					_vistaMountainView.y = Const.MOUNTAIN_VIEW_POX_Y-70 - heroPos.y*0.1;
					_vistaMountainView.y = Math.floor(_vistaMountainView.y);
					_mediumshotMountainView.y = _vistaMountainView.height + Const.MOUNTAIN_VIEW_POX_Y - 170 - heroPos.y*0.1;
					_mediumshotMountainView.y = Math.floor(_mediumshotMountainView.y);
				}				
			}
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			_vistaMountainView.updateScencePos(Const.WELCOME_SCENCE_MOVE_SPEED * Const.VISTA_MOVE_OFFSET_VALUE);
			_mediumshotMountainView.updateScencePos(Const.WELCOME_SCENCE_MOVE_SPEED* Const.MEDIUM_MOVE_OFFSET_VALUE);
		}
		
		
		public function resetBgMoveModel():void
		{
			_dataModel.moveType = BaseCycleViewMoveTypeEnum.WELCOME_SCENCE_MOVE;
			this.setMoveStatus();
		}
		
		public function updateBgMode():void
		{
			_movemodel = HeroMoveStepModel.instance;
			_movemodel.register(this);
			
			_heroPosModel = HeroStatusModel.instance;
			_heroPosModel.register(this);
		}
		
		
		public function smothResetView():void
		{
			_trackCenter.unRegister(this);
		}
		
		public function setGameLevPos():void
		{
			_vistaMountainView.y = Const.MOUNTAIN_VIEW_POX_Y-100;
			_mediumshotMountainView.y = _vistaMountainView.height + Const.MOUNTAIN_VIEW_POX_Y - 200;

			_mountainBgView.visible = true;
			_mountainBgView.y = _mediumshotMountainView.y + 100;
		}
		
		private function initView():void
		{
			
			_stageBgImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bgMask"));
			_stageBgImage.x = -50;
			_stageBgImage.width = Const.STAGE_WIDTH + 100;
			_stageBgImage.height = Const.STAGE_HEIGHT;
			
			this.addChild(_stageBgImage);
			
			
			
			
			_vistaMountainView = new VistaMountainView() ;
			_vistaMountainView.y = Const.MOUNTAIN_VIEW_POX_Y;
			_mediumshotMountainView = new MediumshotMountainView();
			_mediumshotMountainView.y = _vistaMountainView.height + Const.MOUNTAIN_VIEW_POX_Y - 100;
			
			
			_mountainBgView = new Shape();
			_mountainBgView.graphics.beginFill(ColorConst.MOUNTAIN_COLOR);
			_mountainBgView.graphics.drawRect(0,0,Const.STAGE_WIDTH,600);
			_mountainBgView.visible = false;
			_mountainBgView.scaleY = 1.2;
			this.addChild(_mountainBgView);
			this.addChild(_vistaMountainView);
			this.addChild(_mediumshotMountainView);	
		}
		
		private function setMoveStatus():void
		{
			if(_dataModel.moveType == BaseCycleViewMoveTypeEnum.WELCOME_SCENCE_MOVE)	
				_trackCenter.register(this);				
		}
	}
}
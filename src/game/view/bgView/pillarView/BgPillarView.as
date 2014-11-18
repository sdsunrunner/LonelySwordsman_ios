package game.view.bgView.pillarView
{
	import enum.MsgTypeEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.models.HeroMoveStepModel;
	
	import starling.display.Image;
	
	/**
	 * 背景柱子视图 
	 * @author admin
	 * 
	 */	
	public class BgPillarView extends BaseViewer
	{
		
		private var _stageBgImage:Image = null;
		private var _mediumShotPillarView:MediumShotPillarView = null;
		private var _vistaPillarView:VistaPillarView = null;
		private var _movemodel:HeroMoveStepModel = null;
		public function BgPillarView()
		{
			super();
			this.initView();
			this.initModel();
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_MOVE)
			{
				var num:Number = data as Number;
				_vistaPillarView.updatePos(num*0.05);
				_mediumShotPillarView.updatePos(num*0.1);
			}
		}
		
		private function initModel():void
		{
			_movemodel = HeroMoveStepModel.instance;
			_movemodel.register(this);
		}
		
		private function initView():void
		{
			_stageBgImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bgMask"));
			_stageBgImage.x = -50;
			_stageBgImage.width = Const.STAGE_WIDTH + 100;
			_stageBgImage.height = Const.STAGE_HEIGHT;
			
			this.addChild(_stageBgImage);
			
			
			
			
			_vistaPillarView = new VistaPillarView();	
			this.addChild(_vistaPillarView);
			
			_mediumShotPillarView = new MediumShotPillarView();
			this.addChild(_mediumShotPillarView);
		}
	}
}
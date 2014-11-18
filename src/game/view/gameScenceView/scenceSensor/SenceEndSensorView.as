package game.view.gameScenceView.scenceSensor
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.gameScenceView.event.ScenceEvent;
	import game.view.models.HeroStatusModel;
	
	import utils.console.infoCh;
	
	/**
	 * 场景结束探测器视图 
	 * @author admin
	 * 
	 */	
	public class SenceEndSensorView extends BaseViewer
	{
		private var _mainAnima:AnimationSequence = null;
		
//		private var _scenceEnd:Bitmap = null;
		private var _gloabPoint:Point = new Point();
		private var _localPoint:Point = new Point();
		private var _heroStatusModel:HeroStatusModel = null;
		private var _heroTestBit:Bitmap = null;
		private var _isEnd:Boolean = false;
		
		private var _heroPos:Point = null;
		public function SenceEndSensorView()
		{
			super();
			this.initView();
			this.initModel();
		}
		
		override public function initModel():void
		{
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_POS_UPDATE && !_isEnd)
			{
				_heroPos = data as Point;
				
				if(Math.abs(_heroPos.x - _gloabPoint.x)<5)
				{
					_isEnd = true;
					infoCh("debug","scence end hit");
					this.dispatchEventWith(ScenceEvent.GAME_SCENCE_END);
				}
			}
		}
		override public function dispose():void
		{
			infoCh("debug","scence end dispose");
			if(_heroStatusModel)
				_heroStatusModel.unRegister(this);	
			_heroStatusModel = null;
			
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
		public function initPos(posX:Number, posY:Number):void
		{
			_localPoint.x = this.x;
			_localPoint.y = this.y;
			_gloabPoint = localToGlobal(_localPoint);
		}
	
		private function initView():void
		{
			var animaName:Array = ["flag"];
			_mainAnima = new AnimationSequence(assetManager.getTextureAtlas("gui_images"),animaName,"flag",Const.GAME_ANIMA_FRAMERATE,true);
			_mainAnima.touchable = false;
			this.addChild(_mainAnima);
		}
	}
}
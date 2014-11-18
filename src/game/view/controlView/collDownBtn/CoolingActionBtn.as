package game.view.controlView.collDownBtn
{	
	import com.greensock.TweenMax;
	
	import enum.RoleActionEnum;
	
	import font.Font;
	import font.Fonts;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	import game.view.event.ControlleEvent;
	
	import playerData.GamePlayerDataProxy;
	import playerData.ObjPlayerInfo;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * 冷却按钮  
	 * @author admin
	 * 
	 */	
	public class CoolingActionBtn extends BaseViewer
	{
		private var _movesIcon:Image = null;
		private var _coolingBg:CollingCircleAnim = null;
		private var _btnType:String = "";
		
		private var fontRegular:Font;
		
		/** About text field. */
		private var infoText:TextField;		
		
		private var _count:Number = 0;
		
		private var _protoData:ProtoDataInfoModel = null;
			
		public function CoolingActionBtn()
		{
			super();	
			_protoData = ProtoDataInfoModel.instance;
		}
		
		public function get count():Number
		{
			return _count;
		}

		/**
		 * 倒计时开始 
		 * @param coolDown
		 * 
		 */		
		public function startColldown(coolDown:Number):void
		{
			_count-=1;
			if(_btnType == RoleActionEnum.RECOVER_MP)
				_protoData.mpProtoCount = _count;
			
			if(_btnType == RoleActionEnum.RECOVER_HP)
				_protoData.hpProtoCount = _count;
			
			_coolingBg.duration = coolDown;
			this.touchable = false;
			TweenMax.to(_coolingBg,0.3,{alpha:0.7});
			
			_coolingBg.start();
			
			this.setCountInfo(_count);
		}
		
		public function initCount(value:Number):void
		{
			_count = value;
			this.setCountInfo(_count);
		}
		
		public function setCountInfo(count:Number):void
		{
			if(_btnType != RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK && ("" != _btnType))
			{
				if(!infoText)
				{
					fontRegular = Fonts.getFont("ScoreValue");
					infoText = new TextField(70, 40, "", fontRegular.fontName, 30, 0xff0000);
					infoText.x = 20;
					infoText.hAlign = HAlign.LEFT;
					infoText.vAlign = VAlign.TOP;
					this.addChild(infoText);
				}
				infoText.text = count.toString();
			}			
		}
		
		/**
		 * 设置显示类型 
		 * @param movesType
		 * 
		 */		
		public function setMovesType(movesType:String):void
		{	
			var playerInfo:ObjPlayerInfo = GamePlayerDataProxy.instance.getPlayerInfo();
			ProtoDataInfoModel.instance.hpProtoCount = playerInfo.storyModeHeroHpProto;
			ProtoDataInfoModel.instance.mpProtoCount = playerInfo.storyModeHeroMpProto;
			
			switch(movesType)
			{
				case RoleActionEnum.RECOVER_HP:
					_btnType = RoleActionEnum.RECOVER_HP;
					_movesIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("hpremovier"));
					this.addChild(_movesIcon);
					_coolingBg = new CollingCircleAnim(0.6);
					
					_coolingBg.x = 0;
					_coolingBg.y = 0;	
					this.initCount(playerInfo.storyModeHeroHpProto);
					break;	
				
				case RoleActionEnum.RECOVER_MP:
					_btnType = RoleActionEnum.RECOVER_MP;
					_movesIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("mprecover"));
					this.addChild(_movesIcon);
					_coolingBg = new CollingCircleAnim(0.6);
					_coolingBg.x = 0;
					_coolingBg.y = 0;			
					this.initCount(playerInfo.storyModeHeroMpProto);
					break;
				
				case RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK:
					_movesIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("heavyAttackBtn"));		
					this.addChild(_movesIcon);
					_coolingBg = new CollingCircleAnim(0.81);
					
					_coolingBg.x = 0;
					_coolingBg.y = 0;
					break;	
				
			}
			if(_coolingBg)
			{
				_coolingBg.alpha = 0;
				this.addChild(_coolingBg);
				this.addListeners();	
			}
			
					
		}
		
		private function addListeners():void
		{
			_coolingBg.addEventListener(ControlleEvent.COLL_DOWN_COMPLETE, coolDownComplete);			
		}
		
		private function coolDownComplete(evt:Event):void
		{
			this.touchable = true;
			if(_coolingBg)
			{
				TweenMax.to(_coolingBg,0.3,{alpha:0});
			}
		}
	}
}
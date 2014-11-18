package game.view.guiLayer
{
	import com.greensock.TweenMax;
	
	import enum.MsgTypeEnum;
	
	import font.Font;
	import font.Fonts;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.controlView.movesBarView.ProtoDataInfoModel;
	import game.view.survivalMode.SurvivalModeDataModel;
	
	import playerData.GamePlayerDataProxy;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * 生存模式信息视图
	 * @author admin
	 * 
	 */	
	public class SurverModeInfoView extends BaseViewer 
	{
		private var _scoreNote:Image = null;
		
		private var _fontRegular:Font;
		
		/** About text field. */
		private var _infoText:TextField;		
		
		private var _count:Number = 0;
		private var _model:SurvivalModeDataModel = null;
//		private var _hpImage:Image = null;
//		private var _mpImage:Image = null;
		private var _value:Number = 0;
		private var _dataInfoModel:ProtoDataInfoModel = ProtoDataInfoModel.instance;
		
		private var _protoValue:Number = 0;
		public function SurverModeInfoView()
		{
			super();
			this.initView();
			this.initModel();
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.SURVER_MODE_SCORE_UPDATE)
			{
				_count = data as Number;
				_infoText.text = _count.toString();
				_value = Math.random();
				if(_count>10 && _count<20)
				{
					if(_value>0.95)
						getMp();
					
					else if(_value>0.8)
						getHp();
				}
				
				if(_count>=20 && _count<35)
				{
					if(_value>0.9)
						getMp();
					
					else if(_value>0.7)
						getHp();
				}
				
				if(_count>=35)
				{
					if(_value>0.8)
						getMp();
					else if(_value>0.6)
						getHp();
				}
			}
		}
		
		private function getHp():void
		{
//			TweenMax.to(this._hpImage, 0.2,{alpha:1, onComplete:resetIcon});
			_protoValue = _dataInfoModel.hpProtoCount+1;
			_dataInfoModel.hpProtoCount = _protoValue;
			saveData();
		}
		
		private function getMp():void
		{
//			TweenMax.to(this._mpImage, 0.2,{alpha:1, onComplete:resetIcon});
			
			_protoValue = _dataInfoModel.mpProtoCount+1;
			_dataInfoModel.mpProtoCount = _protoValue;
			saveData();
		}
		
		private function saveData():void
		{
			GamePlayerDataProxy.instance.saveGamelLevInfo();
		}
		
		private function resetIcon():void
		{
//			TweenMax.to(this._hpImage, 0.2,{alpha:0, delay:1});
//			TweenMax.to(this._mpImage, 0.2,{alpha:0,delay:1});
		}
		
		override public function dispose():void
		{
			_count = 0;
			_fontRegular = null;
			_infoText = null;
			_scoreNote.dispose();
			_scoreNote = null;
			
			_model.resetData();
			_model.unRegister(this);
			_model = null;
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		override public function initModel():void
		{
			_model = SurvivalModeDataModel.instance;
			_model.register(this);
			_model.resetData();
		}
		
		private function initView():void
		{			
			_scoreNote = new Image(assetManager.getTextureAtlas("gui_images").getTexture("score"));
			
			_scoreNote.x = 0;
			_scoreNote.y = 0;
			this.addChild(_scoreNote);
			
			if(!_infoText)
			{
				_fontRegular = Fonts.getFont("ScoreValue");
				_infoText = new TextField(300, 50, "", _fontRegular.fontName, 40, 0xff0000);
				_infoText.x = 130;
				_infoText.y = 10;
				_infoText.text = "0";
				_infoText.hAlign = HAlign.LEFT;
				_infoText.vAlign = VAlign.TOP;
				this.addChild(_infoText);
			}
			
//			_hpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("hp"));
//			_hpImage.x = _scoreNote.x + _scoreNote.width + 10;
//			this.addChild(_hpImage);
//			_hpImage.alpha = 0;
//			
//			_mpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("mp"));
//			_mpImage.x = _scoreNote.x + _scoreNote.width + 10;
//			_mpImage.alpha = 0;
//			this.addChild(_mpImage);
		}
	}
}
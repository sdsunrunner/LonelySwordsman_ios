package game.view.controlView.movesBarView
{
	import flash.events.KeyboardEvent;
	
	import enum.RoleActionEnum;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.controlView.collDownBtn.CoolingActionBtn;
	import game.view.models.ControlleBarStatusModel;
	import game.view.models.HeroStatusModel;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 招式按钮 
	 * @author songdu
	 * 
	 */	
	public class MovesBarView extends BaseViewer
	{
		private var _movesBarBg:Image = null;
		private var _mainBtn:Image = null;
		private var _mainAttackIcon:Image = null;
		private var _upAttackBtn:MovesBtnView = null;
		private var _heavyAttackBtn:CoolingActionBtn = null;
		private var _blockBtn:MovesBtnView = null;
		private var _sunBtnUseHp:CoolingActionBtn = null;
		private var _sunBtnUseMp:CoolingActionBtn = null;
		
		private var _statusModel:ControlleBarStatusModel = null;
		private var _heroStatus:HeroStatusModel = null;
		
		private var _isHeavyAttackReady:Boolean = false;
		
		public function MovesBarView()
		{
			super();
			this.initView();
			this.initModel();
			this.initMoveBtn();
			this.addGestures();
			this.addKeyBoardControll();
		}
		
		public function canUseProto(canUse:Boolean):void
		{
//			_sunBtnUseHp.visible = canUse;
//			_sunBtnUseMp.visible = canUse;
		}
		
		override public function initModel():void
		{
			_statusModel = ControlleBarStatusModel.instance;			
			_heroStatus = HeroStatusModel.instance;
		}
		
		override public function dispose():void
		{
			if(_mainBtn)
				_mainBtn.dispose();
			_mainBtn = null;
			if(_upAttackBtn)
				_upAttackBtn.dispose();
			_upAttackBtn = null;
			if(_heavyAttackBtn)
				_heavyAttackBtn.dispose();
			_heavyAttackBtn = null;
			_statusModel = null;
			if(_blockBtn)
				_blockBtn.dispose();
			_blockBtn = null;

			while(this.numChildren>0)
			{
				this.removeChildAt(0,true);
			}
		}
		
		public function refershHpPtotoCount(count:Number):void
		{
			_sunBtnUseHp.initCount(count);
		}
		
		public function refershMpPtotoCount(count:Number):void
		{
			_sunBtnUseMp.initCount(count);
		}
		
		private function initView():void
		{
			_movesBarBg = new Image(assetManager.getTextureAtlas("gui_images").getTexture("movesBg"));
			_movesBarBg.x = 2;
			_movesBarBg.y = 28;
			this.addChild(_movesBarBg);
			
			_mainAttackIcon = new Image(assetManager.getTextureAtlas("gui_images").getTexture("mainAttack"));
			_mainAttackIcon.x = 100;
			_mainAttackIcon.y = 135;
			this.addChild(_mainAttackIcon);
			
			_upAttackBtn = new MovesBtnView();
			_upAttackBtn.x = 10;
			_upAttackBtn.y = 190;
			this.addChild(_upAttackBtn);
			
			
			_heavyAttackBtn =  new CoolingActionBtn();
			_heavyAttackBtn.x = 10;
			_heavyAttackBtn.y = 90;
			this.addChild(_heavyAttackBtn);
			
			
			_blockBtn =  new MovesBtnView();
			_blockBtn.x = 90;
			_blockBtn.y = 30;
			this.addChild(_blockBtn);
			
			
			_sunBtnUseHp =  new CoolingActionBtn();
			_sunBtnUseHp.x = 140;
			_sunBtnUseHp.y = 20;
//			this.addChild(_sunBtnUseHp);
			
			_sunBtnUseMp = new CoolingActionBtn();
			_sunBtnUseMp.x = 200;
			_sunBtnUseMp.y = 40;
			
//			this.addChild(_sunBtnUseMp);
		}
		
		private function initMoveBtn():void		
		{
			_upAttackBtn.setMovesType(RoleActionEnum.CONTROLLE_BAR_UP_ATTACK);
			_heavyAttackBtn.setMovesType(RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK);			
			_blockBtn.setMovesType(RoleActionEnum.PARRY_AND_ATTACK);
			_sunBtnUseHp.setMovesType(RoleActionEnum.RECOVER_HP);
			_sunBtnUseMp.setMovesType(RoleActionEnum.RECOVER_MP);
		}
		
		
		private function addGestures():void
		{
			_mainAttackIcon.addEventListener(TouchEvent.TOUCH, mainBtnTabHandler);
			_upAttackBtn.addEventListener(TouchEvent.TOUCH, upBtnTabHandler);
			_heavyAttackBtn.addEventListener(TouchEvent.TOUCH, heavyBtnTabHandler);
			_blockBtn.addEventListener(TouchEvent.TOUCH, blockBtnTabHandler);
//			_sunBtnUseHp.addEventListener(TouchEvent.TOUCH,useHpRecoverHandler);
//			_sunBtnUseMp.addEventListener(TouchEvent.TOUCH,useMpRecoverHandler);
		}
		
		private function addKeyBoardControll():void
		{
			Const.appStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			Const.appStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		
		
		private function keyDownHandler(evt:KeyboardEvent):void
		{
			// TODO Auto Generated method stub
			//90--z 88--x c-67 a--65 s--83
			switch(evt.keyCode)
			{
				case 90:
				{
					_statusModel.isReadyToAction = true;
					_statusModel.setMainBtnTouchPhase(TouchPhase.BEGAN);
					_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_MAIN_ATTACK);
					break;
				}
				case 88:
				{
					if(!_isHeavyAttackReady)
					{
						_statusModel.setHeavyAttackBtnTouchPhase(TouchPhase.BEGAN);
						_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK);
						_statusModel.isReadyToAction = true;
						
						_isHeavyAttackReady = true;
					}
					
					break;
				}
					
				case 67:
				{
					_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_UP_ATTACK);
					
					_statusModel.isReadyToAction = true;
					break;
				}
					
				case 65:
				{
					_statusModel.setBlockBtnTouchPhase(TouchPhase.BEGAN);
					_statusModel.noteMoveBtnTap(RoleActionEnum.PARRY_AND_ATTACK);					
					_statusModel.isReadyToAction = true;
					break;
				}
					
				default:
				{
					break;
				}
			}
		}		
		
		private function keyUpHandler(evt:KeyboardEvent):void
		{
			// TODO Auto Generated method stub
			
			//90--z 88--x c-67 a--65 s--83
			switch(evt.keyCode)
			{
				case 90:
				{
					_statusModel.setMainBtnTouchPhase(TouchPhase.ENDED);
					break;
				}
					
				case 88:
				{
					if( _heroStatus.heroCurrentMp > Const.HERO_HEAVY_ATTACK_COST_MP)
					{
						_heavyAttackBtn.startColldown(10);
						_statusModel.setHeavyAttackBtnTouchPhase(TouchPhase.ENDED);
						_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK_REALEASE);
					}
					_isHeavyAttackReady = false;
					break;
				}
					
				case 67:
				{
					
					break;
				}
					
				case 65:
				{
					_statusModel.setBlockBtnTouchPhase(TouchPhase.ENDED);
					_statusModel.noteMoveBtnTap(RoleActionEnum.PARRY_AND_ATTACK_RELEASE);
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function mainBtnTabHandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this)
			if(touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					_statusModel.isReadyToAction = true;
					_statusModel.setMainBtnTouchPhase(TouchPhase.BEGAN);
					_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_MAIN_ATTACK);
				}
				if (touch.phase == TouchPhase.ENDED)
				{
					_statusModel.setMainBtnTouchPhase(TouchPhase.ENDED);
				}
			}
		}
		
		private function heavyBtnTabHandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this);
			if(touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					_statusModel.setHeavyAttackBtnTouchPhase(TouchPhase.BEGAN);
					_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK);
					_statusModel.isReadyToAction = true;
				}
				if (touch.phase == TouchPhase.ENDED)
				{
					if( _heroStatus.heroCurrentMp > Const.HERO_HEAVY_ATTACK_COST_MP)
					{
						_heavyAttackBtn.startColldown(10);
						_statusModel.setHeavyAttackBtnTouchPhase(TouchPhase.ENDED);
						_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_HEAVY_ATTACK_REALEASE);
					}
				}
			}
		}
		
		
		private function upBtnTabHandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this);
			if(touch&&touch.phase == TouchPhase.BEGAN)
			{
				_statusModel.noteMoveBtnTap(RoleActionEnum.CONTROLLE_BAR_UP_ATTACK);
				
				_statusModel.isReadyToAction = true;
			}
		}
		
		private function blockBtnTabHandler(evt:TouchEvent):void
		{
			var touch:Touch = evt.getTouch(this);
			if(touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					_statusModel.setBlockBtnTouchPhase(TouchPhase.BEGAN);
					_statusModel.noteMoveBtnTap(RoleActionEnum.PARRY_AND_ATTACK);					
					_statusModel.isReadyToAction = true;

				}
				if (touch.phase == TouchPhase.ENDED)
				{
					_statusModel.setBlockBtnTouchPhase(TouchPhase.ENDED);
					_statusModel.noteMoveBtnTap(RoleActionEnum.PARRY_AND_ATTACK_RELEASE);
				}
			}
		}
		
		private function useHpRecoverHandler(evt:TouchEvent):void
		{
			if(_heroStatus.checkCanUseHpPro())
			{
				var touch:Touch = evt.getTouch(this);
				if(touch&&touch.phase == TouchPhase.BEGAN)
				{
					if(_sunBtnUseHp.count>0)
					{
						_sunBtnUseHp.startColldown(10000);	
						_statusModel.noteUseProp(RoleActionEnum.RECOVER_HP);
					}
					else
						noteShowStore();
				}
			}		
		}
		
		private function useMpRecoverHandler(evt:TouchEvent):void
		{
			if(_heroStatus.checkCanUseMHpPro())
			{
				var touch:Touch = evt.getTouch(this);
				if(touch&&touch.phase == TouchPhase.BEGAN)
				{
					if( _sunBtnUseMp.count>0 )
					{
						_sunBtnUseMp.startColldown(15000);
						_statusModel.noteUseProp(RoleActionEnum.RECOVER_MP);
					}
					else
						noteShowStore();
				}
			}	
		}
		
		private function blobkBtnTabHandler():void
		{
//			_statusModel.notParryBack(
		}
		
		private function noteShowStore():void
		{
//			this.dispatchEventWith(ControlleEvent.SHOW_STORE,true);
		}
	}
}
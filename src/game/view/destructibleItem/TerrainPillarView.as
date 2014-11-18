package game.view.destructibleItem
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.MsgTypeEnum;
	
	import frame.sys.track.ITrackable;
	import frame.view.IObserver;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.models.EnviItemsInfoModel;
	import game.view.models.HeroStatusModel;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.display.Image;
	import starling.utils.deg2rad;
	
	import utils.HitTest;
	
	import vo.attackInfo.ObjEnviHitInfo;
	import vo.attackInfo.ObjHitInfo;
	
	/**
	 * 可破坏柱子  
	 * @author admin
	 * 
	 */	
	public class TerrainPillarView extends BaseViewer implements ITrackable,IObserver
	{
		private var _pillarImage:Image = null;	
		private var _smokeAnima:AnimationSequence = null;
		private var _hurtBitMap:Bitmap = null;
		private var _hitBitMap:Bitmap = null;
		private var _gloabPoint:Point = new Point();
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _heroStatusModel:HeroStatusModel = null;
		private var _maxHp:Number = 0;
		private var _currentHp:Number = 0;
		private var _enemyHitInfo:ObjHitInfo = null;
		private var _enviItemsInfoModel:EnviItemsInfoModel = null;
		private var _hitInfo:ObjEnviHitInfo = null;
	
		private var _currentAnimaName:String = "";
		
		private var _mcDic:Dictionary = null;
		public function TerrainPillarView()
		{
			super();
			this.initView();
			this.initModel();
			
		}

		public function get currentHp():Number
		{
			return _currentHp;
		}

		override public function dispose():void
		{
			_heroStatusModel.unRegister(this);
			_enterFrameCenter.unRegister(this);
			super.dispose();
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			this.removeEventListeners();
			_enemyHitInfo = null;
			_gloabPoint = null;
			if(_pillarImage)
				_pillarImage.dispose();
			_pillarImage = null;			
			if(_smokeAnima)
				_smokeAnima.dispose();
			_smokeAnima = null;		
			
			if(_hitBitMap)
				Const.collideLayer.removeChild(_hitBitMap);	
			_hitBitMap = null;
		}
		
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName == MsgTypeEnum.HERO_ATTACK)
			{
				_enemyHitInfo = data as ObjHitInfo;
				if(_enemyHitInfo.attackHurtValue == 0)
					_enemyHitInfo = null;
				if(_enemyHitInfo)
					this.checkEnemyAttact(_enemyHitInfo);
			}
		}
		
		/**
		 * 显示毁伤效果 
		 * 
		 */		
		private function showDestroyEffect():void
		{
			Const.collideLayer.removeChild(_hurtBitMap);	
			_hurtBitMap = null;
			
			_smokeAnima.pauseAnimation(true);
			_smokeAnima.visible = true;
			TweenMax.to(_pillarImage, 3, {shortRotation:{rotation:deg2rad(-90)},ease:Expo.easeIn, onComplete:noteRemoveItem});
			TweenMax.to(_hitBitMap, 3, {rotation:-90,ease:Expo.easeIn, onUpdate:function():void
			{
			
			}});
			
			_currentAnimaName = "expsmoke";
		}
		
		public function set maxHp(value:Number):void
		{
			_maxHp = value;
			_currentHp = _maxHp;
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			_gloabPoint = localToGlobal(new Point(this._pillarImage.x,this._pillarImage.y));
			
			if(_hurtBitMap)
			{
				_hurtBitMap.x = _gloabPoint.x-30;
				_hurtBitMap.y = _gloabPoint.y-150;
			}
			_hitBitMap.x = _gloabPoint.x;
			_hitBitMap.scaleX = 0.5;
			_hitBitMap.y = _gloabPoint.y-55;
			_hitInfo = new ObjEnviHitInfo();
			_hitInfo.enViHitValue = 1000;
			_hitInfo.enViHitItemname = "TerrainPillar";
			_hitInfo.hitBounds = this._hitBitMap;	
			_enviItemsInfoModel.noteHitRange(_hitInfo);
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
			}
		}
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_heroStatusModel = HeroStatusModel.instance;
			_heroStatusModel.register(this);
			
			_enviItemsInfoModel = EnviItemsInfoModel.instance;			
		}
		
		private function initView():void
		{
			_pillarImage =  new Image(assetManager.getTextureAtlas("scence_effect").getTexture("destructibleTerrainPillar"));
			_pillarImage.x = 180;
			_pillarImage.y = 320;
			_pillarImage.pivotX = _pillarImage.width>>1;
			_pillarImage.pivotY =  _pillarImage.height;
			this.addChild(_pillarImage);
			
			var animaName:Array = ["expsmoke"];			
			_smokeAnima = new AnimationSequence(assetManager.getTextureAtlas("scence_effect"),animaName,"expsmoke",Const.GAME_ANIMA_FRAMERATE,false);
			_mcDic = _smokeAnima.mcSequences;
			_smokeAnima.y = 90;
			_smokeAnima.x = -90;
			_smokeAnima.rotation = deg2rad(-30);
			this.addChild(_smokeAnima);
			_smokeAnima.pauseAnimation(false);
			_smokeAnima.visible = false;
			
			_hurtBitMap = new Bitmap();
			_hurtBitMap.bitmapData = assetManager.getBitmapForHitByName("pillarHurt");
			Const.collideLayer.addChild(_hurtBitMap);		
			
			_hitBitMap = new Bitmap();	
			_hitBitMap.bitmapData = assetManager.getBitmapForHitByName("pillarHit");
			Const.collideLayer.addChild(_hitBitMap);	
		}
		
		private function noteRemoveItem():void
		{
			this._heroStatusModel.noteShakWorld(true,1000,true);
			this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
		}
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(_hurtBitMap && hitInfo.hitBounds)
			{
				if(HitTest.complexHitTestObject(_hurtBitMap,hitInfo.hitBounds))
				{
					if(_currentHp > 0)
					{
						_currentHp -= hitInfo.attackHurtValue;
						
						this._heroStatusModel.noteShakWorld(true,_enemyHitInfo.attackMoveId,true);						
						if(_currentHp<=0)
							this.showDestroyEffect();
					}
				}
			}
		}
	}
}
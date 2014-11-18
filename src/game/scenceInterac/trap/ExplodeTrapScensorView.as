package game.scenceInterac.trap
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import enum.MsgTypeEnum;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.enemySoldiers.EnemyEvent;
	import game.view.models.HeroStatusModel;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.display.Image;
	import starling.utils.deg2rad;
	
	import utils.HitTest;
	
	import vo.attackInfo.ObjHitInfo;
	
	/**
	 * 爆炸探测器视图 
	 * @author admin
	 * 
	 */	
	public class ExplodeTrapScensorView extends BaseViewer implements ITrackable
	{
		private var _sensor:Bitmap = null;
		private var _gloabPoint:Point = new Point();
		private var _enterFrameCenter:SysEnterFrameCenter = null;
		private var _heroStatus:HeroStatusModel = null;
		private var _trapStatusModel:TrapStatusMsg = null;
		private var _itemName:String = "";
		private var _heroPos:Bitmap = null;
		private var _enemyHitInfo:ObjHitInfo = null;
		private var _currentHp:Number = 20;
		
		private var _pillarImage:Image = null;
		
		private var _smokeAnima:AnimationSequence = null;
		private var _currentAnimaName:String = "";
		private var _mcDic:Dictionary = null;
		public function ExplodeTrapScensorView()
		{
			initView();
			initModel();
		}
		
		public function set itemName(value:String):void
		{
			_itemName = value;
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean=false):void
		{
			_gloabPoint = localToGlobal(new Point(this.x,this.y));
			if(_sensor)
			{
				_sensor.x = _gloabPoint.x+190;
				_sensor.y = _gloabPoint.y+300;
			}
			
			if(_mcDic&&_mcDic[_currentAnimaName])
			{
				soundExpressions.playActionSound(_currentAnimaName,_mcDic[_currentAnimaName].currentFrame);
			}
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
			
			if(msgName == MsgTypeEnum.HERO_ENEMY_ATTACK_HIT)
			{
				_enemyHitInfo = data as ObjHitInfo;
				if(_enemyHitInfo.attackHurtValue == 0)
					_enemyHitInfo = null;
				if(_enemyHitInfo)
					this.checkEnemyAttact(_enemyHitInfo);
			}
		}
		
		override public function dispose():void
		{
			_enterFrameCenter.unRegister(this);
			_enterFrameCenter = null
			
			_heroStatus.unRegister(this);
			_heroStatus = null;
			
			if(_sensor)
			{
				Const.collideLayer.removeChild(_sensor);
				_sensor.bitmapData.dispose();
				_sensor = null;
			}
			
			if(_smokeAnima)
			{
				while(_smokeAnima.numChildren>0)
				{
					_smokeAnima.removeChildAt(0,true);
				}
				_smokeAnima.destroy();
				_smokeAnima.dispose();
				_smokeAnima = null;
			}
			
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
		}
		
		override public function initModel():void
		{
			_enterFrameCenter = SysEnterFrameCenter.instance;
			_enterFrameCenter.register(this);
			
			_heroStatus = HeroStatusModel.instance;
			_heroStatus.register(this);
			
			_trapStatusModel = TrapStatusMsg.instance;
		}
		
		
		/**
		 * 显示毁伤效果 
		 * 
		 */		
		private function showDestroyEffect():void
		{
			Const.collideLayer.removeChild(_sensor);	
			_sensor = null;
			
			_smokeAnima.pauseAnimation(true);
			_smokeAnima.visible = true;
			_currentAnimaName = "expsmoke";
		}
		
		private function initView():void
		{
			_sensor = new Bitmap();
			_sensor.bitmapData = assetManager.getBitmapForHitByName("mechanismSensor");
			Const.collideLayer.addChild(_sensor);
			
			_pillarImage =  new Image(assetManager.getTextureAtlas("scence_effect").getTexture("destructibleTerrainPillar"));
			_pillarImage.x = 65;
			_pillarImage.y = 40;
			_pillarImage.pivotX = _pillarImage.width>>1;
			_pillarImage.pivotY =  0;
			this.addChild(_pillarImage);
			
			_pillarImage.scaleX = 0.3;
			_pillarImage.scaleY = 0.3;
			
			var animaName:Array = ["expsmoke"];			
			_smokeAnima = new AnimationSequence(assetManager.getTextureAtlas("scence_effect"),animaName,"expsmoke",Const.GAME_ANIMA_FRAMERATE,true);
			_mcDic = _smokeAnima.mcSequences;
			_smokeAnima.y = -20;
			_smokeAnima.x = 0;
			this.addChild(_smokeAnima);
			_smokeAnima.pauseAnimation(false);
			_smokeAnima.visible = false;
			_smokeAnima.scaleX = .5;
			_smokeAnima.scaleY = .5;
			_smokeAnima.onAnimationComplete.add(smokeAnimaComplete);
		}
		
		private function smokeAnimaComplete(name:String):void
		{
			this.visible = false;
			this.dispatchEventWith(EnemyEvent.REMOVE_ENMY_NOTE);
			_trapStatusModel.noteScensorActive(_itemName);
		}	
		
		private function checkEnemyAttact(hitInfo:ObjHitInfo):void
		{
			if(_sensor && hitInfo.hitBounds)
			{
				if(HitTest.complexHitTestObject(_sensor,hitInfo.hitBounds))
				{
					if(_currentHp > 0)
					{
						_currentHp -= hitInfo.attackHurtValue;
						this._heroStatus.noteShakWorld(true,_enemyHitInfo.attackMoveId,true);						
						if(_currentHp<=0)
						{
							showDestroyEffect();
						}
					}
				}
			}
		}
	}
}
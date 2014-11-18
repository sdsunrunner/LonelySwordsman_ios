package game.view.storyCg.bossDeath
{
	import com.greensock.TweenMax;
	
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import extend.draw.display.Shape;
	
	import frame.sys.track.ITrackable;
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	import game.view.models.SysEnterFrameCenter;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;
	
	/**
	 * 最终boss死亡cg 
	 * @author admin
	 * 
	 */	
	public class FinallBossDeathCgView extends BaseViewer implements ITrackable
	{
		private var _bgView:BossDeathPillaView = null;
		private var _heroHitGroupName:Array = ["heroHitGroup","heroFinallAttack"];
		private var _heroHitGroup:AnimationSequence = null;
		private var _heroHitGroupTexture:TextureAtlas = null;
		
		private var _bossHurtName:Array = ["bossBeenHit","cgBossDeath","failBossRunAway"];
		private var _bossHurtTexture:TextureAtlas = null;		
		private var _bossBeenHitAnima:AnimationSequence = null;
		
		private var _groudShap:Shape = null;
		private var _blackMask:Shape = null;
		private var _whiteMask:Shape = null;
		
		private var _heroStand:Image = null;
		private var _bossFailSit:Image = null;
		private var _failBoss:Image = null;
		
		private var _scenceContainer:BaseViewer = null;
		
		private var _gameEnd:Image = null;
		private var _trackMessage:SysEnterFrameCenter = null;
		private var _currentAnimaName:String = "";
		private var _mcDic:Dictionary = null;		
		private var _currentMc:MovieClip = null;		
		
		
		public function FinallBossDeathCgView()
		{
			super();
			this.initView();
			this.initModel();
			this.touchable = false;
		}
		
		public function track(msg:Object, msgName:String, delayFlag:Boolean = false):void
		{
			if(_mcDic)
			{
				_currentMc = _mcDic[_currentAnimaName] as MovieClip;			
				if(_currentMc)
				{
					if(_currentAnimaName == "heroHitGroup")
					{
						if(_currentMc.currentFrame<10)
							soundExpressions.playActionSound(_currentAnimaName,_currentMc.currentFrame);
						else if(_currentMc.currentFrame>10 && _currentMc.currentFrame<40)
							soundExpressions.playActionSound("heroHitGroup_1",_currentMc.currentFrame);
						else if(_currentMc.currentFrame>40)
							soundExpressions.playActionSound("heroHitGroup_2",_currentMc.currentFrame);
					}
					else
						soundExpressions.playActionSound(_currentAnimaName,_currentMc.currentFrame);
				}
			}			
		}
		
		private function initModel():void
		{
			_trackMessage = SysEnterFrameCenter.instance;
			_trackMessage.register(this);
		}
		
		private function initView():void
		{
			_scenceContainer = new BaseViewer();
			this.addChild(_scenceContainer);	
			
			_bgView = new BossDeathPillaView();
			_scenceContainer.addChild(_bgView);
			_blackMask = new Shape();
			_blackMask.graphics.beginFill(0x000000);
			_blackMask.graphics.drawRect(-10,-10,Const.STAGE_WIDTH+20, Const.STAGE_HEIGHT+20);
			this.addChild(_blackMask);
			
			_groudShap = new Shape();
			_groudShap.graphics.beginFill(0x000000);
			_groudShap.graphics.drawRect(0,0,Const.STAGE_WIDTH,Const.STAGE_HEIGHT*1/3);
			_groudShap.y = Const.STAGE_HEIGHT*2/3;
			_scenceContainer.addChild(_groudShap);
			_bgView.y = _groudShap.y - _bgView.height + 20;
			this._heroStand = new Image(assetManager.getTextureAtlas("bossDeathCg").getTexture("heroStand"));
			this._heroStand.y = _groudShap.y-this._heroStand.height;
			this._heroStand.x = Const.STAGE_WIDTH*1/3 + 30;
			
			_scenceContainer.addChild(this._heroStand);
			
			_bossFailSit = new Image(assetManager.getTextureAtlas("bossDeathCg").getTexture("bosssitImage"));
			_bossFailSit.y = _groudShap.y-this._bossFailSit.height + 5;
			_bossFailSit.x = this._heroStand.x+80 + 5;
			_scenceContainer.addChild(this._bossFailSit);
			
			TweenMax.to(_blackMask,1,{alpha:0,delay:1, onComplete:showHeroHitGroup});			
		}
		
		
		private function addListeners():void
		{
			_heroHitGroup.onAnimationComplete.add(animaComplete);	
			_bossBeenHitAnima.onAnimationComplete.add(animaComplete);	
		}
		
		/**
		 * 英雄连击动画 
		 * 
		 */		
		private function showHeroHitGroup():void
		{
			soundExpressions.stopPreSound();
			_bossFailSit.visible = false;
			_heroStand.visible = false;
			_heroHitGroupTexture = assetManager.getTextureAtlas("bossDeathCg");
			_heroHitGroup = new AnimationSequence(_heroHitGroupTexture,_heroHitGroupName,"heroHitGroup",Const.GAME_CG_ANIMA_FRAMERATE,false);
			_heroHitGroup.y = _groudShap.y-_heroHitGroup.height+20;
			_heroHitGroup.x = Const.STAGE_WIDTH*1/3;			
			_scenceContainer.addChild(_heroHitGroup);
			_mcDic = _heroHitGroup.mcSequences;
			this._currentAnimaName = "heroHitGroup";
			
			_bossHurtTexture = assetManager.getTextureAtlas("bossDeathCg");
			_bossBeenHitAnima = new AnimationSequence(_bossHurtTexture,_bossHurtName,"bossBeenHit",Const.GAME_CG_ANIMA_FRAMERATE,false);
			_bossBeenHitAnima.y = _groudShap.y-_bossBeenHitAnima.height;
			_bossBeenHitAnima.x = _heroHitGroup.x+110;
			_scenceContainer.addChild(_bossBeenHitAnima);
			
			this.addListeners();
		}
		
		private function animaComplete(name:String):void
		{
			if(name == "heroHitGroup")
			{
				TweenMax.killAll();
				TweenMax.to(_bossBeenHitAnima,0.5,{x:_heroHitGroup.x+150});
				setTimeout(showFlash,700);
			}
			if(name == "heroFinallAttack")
			{
				showBossDeath();
			}
			if(name == "failBossRunAway")
			{
				if(_bossBeenHitAnima)
					_bossBeenHitAnima.visible = false;
				TweenMax.to(_blackMask,1,{alpha:1, onComplete:showGameEndTxt});
			}
		}
		
		private function showFlash():void
		{
			setTimeout(showFinallAttackReady,500);
			_whiteMask = new Shape();
			_whiteMask.graphics.beginFill(0xffffff);
			_whiteMask.graphics.drawRect(-10,-10,Const.STAGE_WIDTH+20, Const.STAGE_HEIGHT+20);
			this.addChild(_whiteMask);
			setTimeout(addExpSound,10);
		}
		
		private function showFinallAttackReady():void
		{
			TweenMax.killAll();
			TweenMax.to(_whiteMask,0.3,{alpha:0});
			_heroHitGroup.x+=80;
			_heroHitGroup.y-= 60;
			_heroHitGroup.changeAnimation("heroFinallAttack",false);		
			this._currentAnimaName = "heroFinallAttack";
		}	
		
		private function showBossDeath():void
		{
			TweenMax.killAll();
			TweenMax.to(_bossBeenHitAnima,0.1,{x:_bossBeenHitAnima.x+50, onComplete:showBossDeathAnima});			
		}
		
		private function showBossDeathAnima():void
		{
			TweenMax.killAll();
			_bossBeenHitAnima.y-=100;
			TweenMax.to(_whiteMask,0.5,{alpha:1,delay:0.3});
			_bossBeenHitAnima.changeAnimation("cgBossDeath", false);
			
			setTimeout(showBossFail,1000);
		}
		
		private function showBossFail():void
		{
			addSound();
			TweenMax.killAll();
			TweenMax.to(_whiteMask,0.5,{alpha:0,delay:0.5});
			_scenceContainer.removeChild(_heroHitGroup);
			
			var wallShap:Shape = new Shape();
			wallShap.graphics.beginFill(0x000000);
			wallShap.graphics.drawRect(0,0,300,Const.STAGE_HEIGHT*2/3);
			wallShap.x = Const.STAGE_WIDTH - wallShap.width;
			wallShap.y = Const.STAGE_HEIGHT - wallShap.height;
			_scenceContainer.addChild(wallShap);
			
			_failBoss = new Image(assetManager.getTextureAtlas("bossDeathCg").getTexture("failBoss"));
			_failBoss.x = wallShap.x -_failBoss.width;
			_failBoss.y = _groudShap.y - _failBoss.height+5;
			
			_heroStand.visible = true;
			this._heroStand.x = _failBoss.x-this._heroStand.width-20;
			this._heroStand.y = _groudShap.y - _heroStand.height;
			
			_scenceContainer.addChild(this._failBoss);
			setTimeout(showBossDistortion,3000);
		}
		
		private function showBossDistortion():void
		{			
			TweenMax.to(_failBoss,5,{scaleX:0.8,x:_failBoss.x-10, onComplete:showBossDistortion2});
		}
		private function showBossDistortion2():void
		{
			TweenMax.to(_failBoss,5,{scaleY:2,y:_failBoss.y-45,x:_failBoss.x+5,onComplete:showBossSkip});
		}
		
		private function showBossSkip():void
		{
			_failBoss.visible = false;
			_bossBeenHitAnima.x = _heroHitGroup.x+150;
			_bossBeenHitAnima.changeAnimation("failBossRunAway",false);
		}
		
		private function showGameEndTxt():void
		{
			_gameEnd =  new Image(assetManager.getTextureAtlas("bossDeathCg").getTexture("end"));
			_gameEnd.x = (Const.STAGE_WIDTH - _gameEnd.width)/2;
			_gameEnd.y = (Const.STAGE_HEIGHT - _gameEnd.height)/2;
			_gameEnd.alpha = 0;
			
			this.addChild(_gameEnd);
			TweenMax.to(_gameEnd,3,{alpha:1, delay:1, onComplete:showEndTxtFade});
		}
		
		private function showEndTxtFade():void
		{
			TweenMax.to(_gameEnd,2,{alpha:0, delay:1, onComplete:noteGameEnd});			
		}
		private function noteGameEnd():void
		{
			this.dispatchEventWith(MainScenceEvent.GAME_END, true);	
		}
		
		private function addSound():void
		{
			soundExpressions.playBossDiaCgBgSound();
		}
		
		private function addExpSound():void
		{
			soundExpressions.playBossDiaCgExpBgSound();
		}
		
		
	}
}
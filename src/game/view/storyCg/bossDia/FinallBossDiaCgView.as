package game.view.storyCg.bossDia
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.utils.setTimeout;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	/**
	 * 最后boss对话剧情 
	 * @author admin
	 * 
	 */	
	public class FinallBossDiaCgView extends BaseViewer
	{
		private var _bgMask:Image = null;
		
		private var _hightLightBoss:Image = null;
		private var _bgImageBottom:Image = null;
		private var _sitImageBottom:Image = null;
		private var _sitBossImage:Image = null;
		private var _bossSitImage:Image = null;
		private var _heroIdelImage:Image = null;
		private var _bigSitBoss:Image = null;
		private var _bigBossSit:Image = null;
		private var _scence2Container:Sprite = null;
		
		private var _bigHeroIdelImage:Image = null;
		private var _bossHeightLightImage:Image = null;
		private var _bossAnima:AnimationSequence = null;
		private var _animaTexture:TextureAtlas = null;	
		private var _bgBlue:Image = null;
		private var _bgWhite:Image = null;
		private var _animaName:Array = ["bossFlashStand","bossHeightLightShow"];
		
		private var _tweenMax:TweenMax = null;
		private var _scence1Container:Sprite = null;
		
		private var _mediumShotPillarView:CgMediumShotPillarView = null;
		private var _vistaPillarView:CgVistaPillarView = null;
		public function FinallBossDiaCgView()
		{
			super();
			
			this.touchable = false;
			this.showBgMask();
		}
		
		override public function dispose():void
		{
			if(_scence2Container)
			{
				_scence2Container.unflatten();
				while(_scence2Container.numChildren)
				{
					_scence2Container.removeChildAt(0,true);
				}
			}
			
			TweenMax.killAll();
			if(_bgImageBottom)
				_bgImageBottom.dispose();
			
			if(_hightLightBoss)
				_hightLightBoss.dispose();		
			if(_bossSitImage)
				_bossSitImage.dispose();
			if(_heroIdelImage)
				_heroIdelImage.dispose();
			if(_bossHeightLightImage)
				_bossHeightLightImage.dispose();
			if(_bossAnima)
			{
//				_bossAnima.destroy();
				
				_bossAnima.dispose();
//				_bossAnima.removeAllAnimations();
				while(_bossAnima.numChildren>0)
				{
					_bossAnima.removeChildAt(0,true);
				}
				
				_bossAnima = null;
			}
			
			_animaTexture = null;
			while(this.numChildren > 0 )
			{
				this.removeChildAt(0,true);
			}
		}	
		
		private function addListeners():void
		{
			_bossAnima.onAnimationComplete.add(animaComplete);			
		}
		
		private function showBgMask():void
		{
			_bgMask = new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			
			_bgMask.width = Const.STAGE_WIDTH + 100;
			_bgMask.height = Const.STAGE_HEIGHT + 100;
			_bgMask.x = -50;
			_bgMask.y = -50;
			if(_tweenMax)
				_tweenMax.kill();	
			
			this.addChild(_bgMask);
			_tweenMax = TweenMax.to(_bgMask,5,{alpha:0});

			_vistaPillarView = new CgVistaPillarView();
			_vistaPillarView.y = Const.STAGE_HEIGHT - 100;
			this.addChild(_vistaPillarView);
			
			
			_mediumShotPillarView = new CgMediumShotPillarView();
			_mediumShotPillarView.y = Const.STAGE_HEIGHT;
			this.addChild(_mediumShotPillarView);
			
			
			_scence1Container = new Sprite();
			this.addChild(_scence1Container);
			_scence1Container.y = Const.STAGE_HEIGHT+200;
			
			this.initScnece1();
			_scence1Container.flatten();
			
			
		}
		
		private function addSound():void
		{
			soundExpressions.playBossDiaCgBgSound();
		}
		
		private function addExpSound():void
		{
			soundExpressions.playBossDiaCgExpBgSound();
		}
		/**
		 * 初始场景 
		 * 
		 */		
		private function initScnece1():void
		{			
			_bgImageBottom =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			_bgImageBottom.x = -10;
			_bgImageBottom.width = Const.STAGE_WIDTH + 20;
			_bgImageBottom.y = Const.STAGE_HEIGHT - 200;
			_bgImageBottom.height = Const.STAGE_HEIGHT/2;
			_bgImageBottom.y = 400;
			
			_scence1Container.addChild(_bgImageBottom);
			
			_sitImageBottom = new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			_sitImageBottom.x = 600;
			_sitImageBottom.width = Const.STAGE_WIDTH/2;
			_sitImageBottom.y = Const.STAGE_HEIGHT - 200;
			_sitImageBottom.height = Const.STAGE_HEIGHT/2;
			_sitImageBottom.y = 200;
			_scence1Container.addChild(_sitImageBottom);
			
			_bossSitImage = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("sitboss"));
			_bossSitImage.x = 650;
			_bossSitImage.y = 125;
			_scence1Container.addChild(_bossSitImage);			
			
			_sitBossImage =  new Image(assetManager.getTextureAtlas("finalBoss").getTexture("sitBossImage"));
			_sitBossImage.x = 645;	
			_sitBossImage.y = 120;
			_scence1Container.addChild(_sitBossImage);	
			
			_heroIdelImage = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("heroImage"));
			_heroIdelImage.y = _bgImageBottom.y - _heroIdelImage.height;
			_heroIdelImage.x = Const.STAGE_WIDTH*(1/3);		
			_scence1Container.addChild(_heroIdelImage);
			
			
			TweenMax.to(_scence1Container,3,{y:0,delay:1});
			TweenMax.to(_mediumShotPillarView,3,{y:50,delay:1});
			TweenMax.to(_vistaPillarView,3,{y:100,delay:1});
			
			setTimeout(showScnece2,7000);
			
			setTimeout(addSound,500);
		}
		
		/**
		 * 第二个场景 
		 * 
		 */		
		private function showScnece2():void
		{
			TweenMax.killAll();
		
			while(_scence1Container.numChildren>0)
			{
				_scence1Container.removeChildAt(0,true);				
			}
			this.removeChild(_scence1Container);			
			_scence1Container = null;
			
			_scence2Container = new Sprite();
			this.addChild(_scence2Container);
			
			
			_bgImageBottom =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			_bgImageBottom.x = -10;
			_bgImageBottom.width = Const.STAGE_WIDTH*2;
			_bgImageBottom.y = Const.STAGE_HEIGHT - 100;
			_bgImageBottom.height = Const.STAGE_HEIGHT/2;			
			_scence2Container.addChild(_bgImageBottom);
			_bigHeroIdelImage =  new Image(assetManager.getTextureAtlas("finalBoss").getTexture("bigHero"));
			_bigHeroIdelImage.y = _bgImageBottom.y - _bigHeroIdelImage.height;
			_bigHeroIdelImage.x = Const.STAGE_WIDTH*1/3;
			
			_scence2Container.addChild(_bigHeroIdelImage);
			
			
			_bigSitBoss = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("bigSitBoss"));
			_bigSitBoss.x = 1100;
			_bigSitBoss.y = 155;
			_scence2Container.addChild(_bigSitBoss);
			
			_bigBossSit = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("bigBossSit"));
			_bigBossSit.x = 1070;
			_bigBossSit.y = 145;
			_scence2Container.addChild(_bigBossSit);	
			
			_sitImageBottom = new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));	
			_sitImageBottom.width = Const.STAGE_WIDTH/2;
			_sitImageBottom.height = 500;
			_sitImageBottom.x = 1050;
			_sitImageBottom.y = 300;
			_scence2Container.addChild(_sitImageBottom);
			_scence2Container.flatten();
			
			
			_mediumShotPillarView.scaleX = 1.5;
			_mediumShotPillarView.x += 20;
			_mediumShotPillarView.scaleY = 1.5;
			_vistaPillarView.scaleX = 1.5;
			_vistaPillarView.scaleY = 1.5;
			
			setTimeout(showScnece3,3000);
		}		
		
		private function showScnece3():void
		{
			TweenMax.killAll();
			TweenMax.to(_scence2Container,2,{x:-500,y:20});	
			TweenMax.to(_mediumShotPillarView,2,{x:-100,scaleX:1.7,scaleY:1.7});	
			TweenMax.to(_vistaPillarView,2,{x:-50,scaleX:1.7,scaleY:1.7});
			
			setTimeout(showBossStand,4000);
		}
		
		private function showBossStand():void
		{
			_scence2Container.unflatten();
			_bigBossSit.visible = false;
			_bigBossSit.dispose();			
			_scence2Container.removeChild(_bigBossSit);				
			
			_animaTexture = assetManager.getTextureAtlas("finalBoss");
			_bossAnima = new AnimationSequence(_animaTexture,_animaName,"bossFlashStand",Const.GAME_CG_ANIMA_FRAMERATE,false);
			_bossAnima.x = 610;
			_bossAnima.y = 0;
			this.addChild(_bossAnima);
			this.addListeners();
		}		
		
		private function animaComplete(name:String):void
		{
			if(name == "bossFlashStand")
			{
				_heroIdelImage.dispose();
				this.removeChild(_heroIdelImage,true);
				
				_sitBossImage.dispose();		
				this.removeChild(_sitBossImage,true);
				
				_bossSitImage.dispose();
				this.removeChild(_bossSitImage,true);
				
				_sitImageBottom.dispose();				
				this.removeChild(_sitImageBottom,true);
				
				_bgImageBottom.y = Const.STAGE_HEIGHT-150;
				
				while(_scence2Container.numChildren>0)
				{
					_scence2Container.removeChildAt(0,true);
				}
				this.removeChild(_scence2Container);
				_scence2Container = null;
				
				showBossHeightLightAnima();				
			}
			
			if(name == "bossHeightLightShow")
			{
				
				setTimeout(showBossHeightLight,1000);
			}
		}
		
		
		private function showBossHeightLightAnima():void
		{	
			setTimeout(addExpSound,1200);
			_bgImageBottom =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("blackMask"));
			_bgImageBottom.x = -10;
			_bgImageBottom.width = Const.STAGE_WIDTH + 20;
			_bgImageBottom.height = 300;
//			_bgImageBottom.y = Const.STAGE_HEIGHT - 170;
			
			_bgImageBottom.y = Const.STAGE_HEIGHT - 240;
			this.addChild(_bgImageBottom);
			
			_bossAnima.x = 450;
			if(Const.STAGE_HEIGHT<700)
				_bossAnima.y = 20;
			else
				_bossAnima.y = 150;
			_bossAnima.changeAnimation("bossHeightLightShow",false);	
			
			
			_mediumShotPillarView.scaleX = 1.8;
			_mediumShotPillarView.x = 20;
			_mediumShotPillarView.y-=20;
			_mediumShotPillarView.scaleY = 1.8;
			_vistaPillarView.scaleX = 1.8;
			_vistaPillarView.scaleY = 1.8;
			_vistaPillarView.y-=10;
		}
		
		private function showBossHeightLight():void
		{	
			_bgImageBottom.y = Const.STAGE_HEIGHT - 80;
			while(_bossAnima.numChildren>0)
			{
				_bossAnima.removeChildAt(0,true);
			}
			this.removeChild(_bossAnima,true);
			_bossAnima.removeAllAnimations();
			_bossAnima.dispose();
			_bossAnima.destroy();
			
			_bgBlue = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("bgBlue"));
			_bgBlue.x = 380;
			_bgBlue.y = 190;
			_bgBlue.scaleX = 1.5;
			_bgBlue.scaleY = 1.5;
			this.addChild(_bgBlue);	
			
			
			_hightLightBoss =  new Image(assetManager.getTextureAtlas("finalBoss").getTexture("heightLightBoss"));
			_hightLightBoss.x = 450;
			if(Const.STAGE_HEIGHT<700)
				_hightLightBoss.y = 190;
			else
				_hightLightBoss.y = 317;
			
			this.addChild(_hightLightBoss);	
			
			_mediumShotPillarView.scaleX = 2;
			_mediumShotPillarView.x = -30;
			_mediumShotPillarView.y-=20;
			_mediumShotPillarView.scaleY = 2;
			_vistaPillarView.scaleX = 2;
			_vistaPillarView.scaleY = 2;
			_vistaPillarView.y-=10;
			_vistaPillarView.x -=20;
			showFlash();
		}
		
		private function showFlash():void
		{
			_bgWhite = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("bgwhite"));
			_bgWhite.width = Const.STAGE_WIDTH+100;
			_bgWhite.height = Const.STAGE_HEIGHT+100;
			_bgWhite.x = -50;
			_bgWhite.y = -50;
			_bgWhite.alpha = 0;
			this.addChild(_bgWhite);
			if(_tweenMax)
				_tweenMax.kill();
			
			_tweenMax = TweenMax.to(_bgWhite,0.2,{alpha:1,ease:Back.easeIn,onComplete:hideFlash});	
		}
		
		private function hideFlash():void
		{
			_bossHeightLightImage = new Image(assetManager.getTextureAtlas("finalBoss").getTexture("bossHeightLight"));
		
			this.addChild(_bossHeightLightImage);	
			_bossHeightLightImage.x = _hightLightBoss.x+1;
			_bossHeightLightImage.y = _hightLightBoss.y+2;		
			
			if(_tweenMax)
				_tweenMax.kill();
			_tweenMax = TweenMax.to(_bgWhite,0.3,{alpha:0,ease:Back.easeOut,delay:0.2,onComplete:showBossFlash});	
		}
		
		private function showBossFlash():void
		{
			if(_tweenMax)
				_tweenMax.kill();
			_tweenMax = TweenMax.to(_bossHeightLightImage,2,{alpha:0,delay:0.2,ease:Back.easeInOut});	
			TweenMax.to(_bgBlue,2,{alpha:0,delay:0.5,onComplete:bossHide});	
		}
		
		private function bossHide():void
		{
			TweenMax.killAll();

			TweenMax.to(_hightLightBoss,2,{scaleX:0.6,scaleY:0.6,onComplete:hideScence});	
			TweenMax.to(_mediumShotPillarView,2,{scaleX:1.5,scaleX:1.5});	
			TweenMax.to(_vistaPillarView,2,{scaleX:1.5,scaleX:1.5});			
			TweenMax.to(_bgImageBottom,2,{y:Const.STAGE_HEIGHT - 230});
		}
		
		private function hideScence():void
		{
			this.removeChild(_mediumShotPillarView);
			this.removeChild(_vistaPillarView);
			
			TweenMax.killAll();
			_tweenMax = TweenMax.to(_bgMask,3,{alpha:1,onComplete:noteScenceEnd});
		}
		
		private function noteScenceEnd():void
		{
			this.dispatchEventWith(MainScenceEvent.CG_SCENCE_END,true);
		}
	}
}
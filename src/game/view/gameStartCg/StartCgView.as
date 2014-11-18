package game.view.gameStartCg
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.utils.setTimeout;
	
	import citrus.view.starlingview.AnimationSequence;
	
	import extend.draw.display.Shape;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	import game.view.gameStartCg.startCg.FarAwayBgView;
	import game.view.gameStartCg.startCg.NearByBg;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	/**
	 * 开场cg视图 
	 * @author admin
	 * 
	 */	
	public class StartCgView extends BaseViewer
	{
		private var _farAway:FarAwayBgView = null;
		private var _nearby:NearByBg = null;
		private var _bottom:Shape = null;
		
		private var _bossAnimaName:Array = ["bossIdel","bossStartWalk","bossWalk","bossKill"];
		private var _bossAnima:AnimationSequence = null;
		private var _bossAnimaTexture:TextureAtlas = null;
		
		
		private var _yeomanmaName:Array = ["yeoman"];
		private var _yeomanAnima:AnimationSequence = null;
		private var _yeomanAnimaTexture:TextureAtlas = null;
		
		private var _note:Image = null;
		private var _blackMask:Shape = new Shape();
		
		private var _mainScenceContainer:Sprite = null;
		
		public function StartCgView()
		{
			super();
			this.initView();
			
		}
		
		private function addListeners():void
		{
			_bossAnima.onAnimationComplete.add(animaComplete);	
		}
		private function animaComplete(name:String):void
		{
			if(name == "bossStartWalk")
				doBossWalkLoop();
			
			if(name == "yeoman")
			{
				setTimeout(doBossKill,2000);
			}
			
			if(name == "bossKill")
			{
				
			}
		}
		
		private function doBossWalkLoop():void
		{
			_bossAnima.changeAnimation("bossWalk",true);
		}
		
		private function initView():void
		{
			_mainScenceContainer = new Sprite();
			_mainScenceContainer.y = -200;
			_mainScenceContainer.x = -100;
			this.addChild(_mainScenceContainer);
			
			
			_note = new Image(assetManager.getTextureAtlas("start_cg").getTexture("fiveYears"));
			_note.x = (Const.STAGE_WIDTH - _note.width)>>1 ;
			_note.y = Const.STAGE_HEIGHT*1/3 - 50;
			this.addChild(_note);
			_note.alpha = 0;
			TweenLite.to(_note, 5,{alpha:1});
			setTimeout(showMainScence,3000);
			
			setTimeout(addSound, 1600);
			
		}
		
		private function addSound():void
		{
			soundExpressions.playStartCgBgSound();
		}
		
		private function showMainScence():void
		{
			_bottom = new Shape();
			_bottom.graphics.beginFill(0x000000);
			_bottom.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT*1/5);
			_bottom.y = Const.STAGE_HEIGHT-100 - _bottom.height;
			
			var sp:Shape = new Shape();
			sp.graphics.beginFill(0x000000);
			sp.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT*1/5);
			_mainScenceContainer.addChild(sp);
			sp.y = _bottom.y + _bottom.height;
			
			
			_farAway = new FarAwayBgView();
			_farAway.y = _bottom.y - _farAway.height;
			_mainScenceContainer.addChild(_farAway);
			
			_nearby = new NearByBg();
			_nearby.y = _bottom.y - _nearby.height;
			_mainScenceContainer.addChild(_nearby);
			
			
			_bossAnimaTexture = assetManager.getTextureAtlas("start_cg");
			_bossAnima = new AnimationSequence(_bossAnimaTexture,_bossAnimaName,"bossIdel",Const.GAME_CG_ANIMA_FRAMERATE,false);
			_bossAnima.x = (Const.STAGE_WIDTH - _bossAnima.width)/2;
			if(Const.STAGE_HEIGHT<700)
				_bossAnima.y = Const.STAGE_HEIGHT-100 - _bossAnima.height-128;
			else
				_bossAnima.y = Const.STAGE_HEIGHT-100 - _bossAnima.height-153;
			_mainScenceContainer.addChild(_bossAnima);
			
			_mainScenceContainer.addChild(_bottom);
			_mainScenceContainer.alpha = 0;
			setTimeout(showAnima1,5);			
			this.addListeners();
			
			TweenLite.to(_mainScenceContainer, 2,{alpha:1});
			TweenLite.to(_note, 3,{alpha:0,delay:2});
			_mainScenceContainer.scaleX = 1.5;
			_mainScenceContainer.scaleY = 1.5;
		}
		
		private function showAnima1():void
		{
			TweenMax.to(_farAway,5,{x:50, onComplete:showYeomanAnima});
			TweenMax.to(_nearby,5,{x:100});
			_bossAnima.x -=8;
			_bossAnima.changeAnimation("bossStartWalk",false);
		}
		
		private function showYeomanAnima():void
		{
			_bossAnima.changeAnimation("bossIdel",false);
			
			_yeomanAnimaTexture = assetManager.getTextureAtlas("start_cg");
			_yeomanAnima = new AnimationSequence(_yeomanAnimaTexture,_yeomanmaName,"yeoman",Const.GAME_CG_ANIMA_FRAMERATE,false);
			_yeomanAnima.x = _bossAnima.x - 250;
			if(Const.STAGE_HEIGHT<700)
				_yeomanAnima.y = Const.STAGE_HEIGHT-100 - _yeomanAnima.height-120;
			else
				_yeomanAnima.y = Const.STAGE_HEIGHT-100 - _yeomanAnima.height-148;
			
			_mainScenceContainer.addChild(_yeomanAnima);	
			
			_yeomanAnima.onAnimationComplete.add(animaComplete);	
		}
		
		private function doBossKill():void
		{
			_blackMask = new Shape();
			_blackMask.graphics.beginFill(0x000000);
			_blackMask.graphics.drawRect(0,0,Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
			_blackMask.alpha = 0;
			this.addChild(_blackMask);
			
			_bossAnima.x -= 7;
			if(Const.STAGE_HEIGHT<700)
				_bossAnima.y = Const.STAGE_HEIGHT-100 - _bossAnima.height-195;
			else
				_bossAnima.y = Const.STAGE_HEIGHT-100 - _bossAnima.height-220;
			
			
			_bossAnima.changeAnimation("bossKill", false);			
			TweenMax.to(_blackMask,2,{alpha:1,delay:1, onComplete:noteScenceEnd});
		}
		
		private function noteScenceEnd():void
		{
			this.dispatchEventWith(MainScenceEvent.GAME_START_CG_END,true);
		}
	}
}
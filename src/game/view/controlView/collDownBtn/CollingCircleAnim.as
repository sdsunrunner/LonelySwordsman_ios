package game.view.controlView.collDownBtn
{
	import citrus.view.starlingview.AnimationSequence;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.ControlleEvent;
	
	import starling.textures.TextureAtlas;
	
	/**
	 * 圆形遮罩 
	 * @author admin
	 * 
	 */	
	public class CollingCircleAnim extends BaseViewer
	{
		private var _manAnima:AnimationSequence = null;
		private var _animaName:Array = ["circelMask"];
		private var _animaTexture:TextureAtlas = null;
		
		private var _scale:Number = 0;
		private var _duration:Number = 0;
		public function CollingCircleAnim(scale:Number)
		{
			_scale = scale;
			super();
		}
		
		public function set duration(value:Number):void
		{
			_duration = value;
		}
		
		public function start():void		
		{
			removeAnima();
			
			_animaTexture = assetManager.getTextureAtlas("gui_images");
			_manAnima = new AnimationSequence(_animaTexture,_animaName,"circelMask",_duration,false);
		
			_manAnima.scaleX = _scale;
			_manAnima.scaleY = _scale;
			this.addChild(_manAnima);
			
			_manAnima.onAnimationComplete.add(animaComplete);
		}
		
		private function animaComplete(name:String):void
		{
			removeAnima();
			this.dispatchEventWith(ControlleEvent.COLL_DOWN_COMPLETE);
		}
		
		private function removeAnima():void
		{
			while(this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			if(_manAnima)
			{
				_manAnima.removeAllAnimations();
			}
			_manAnima = null;
		}
	}
}
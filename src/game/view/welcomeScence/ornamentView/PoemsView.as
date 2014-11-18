package game.view.welcomeScence.ornamentView
{
	import flash.utils.setTimeout;
	
	import frame.view.viewDelegate.BaseViewer;
	
	import game.view.event.MainScenceEvent;
	
	import starling.display.Image;
	
	/**
	 * 诗歌视图 
	 * @author songdu.greg
	 * 
	 */	
	public class PoemsView extends BaseViewer
	{
		private var _verse1:Image = null;
		private var _verse2:Image = null;
		private var _verse3:Image = null;
		private var _verse4:Image = null;
		
		public function PoemsView()
		{
			super();
			this.initView();
			this.touchable = false;
			setTimeout(showPoems,1000);
			
		}
		
		private function initView():void
		{
			_verse1 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("verse1"));			
			_verse2 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("verse2"));
			_verse3 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("verse3"));
			_verse4 = new Image(assetManager.getTextureAtlas("gui_images").getTexture("verse4"));
			
			
			_verse1.y = 130;
			_verse1.alpha = 0;
			
			
			_verse2.y = _verse1.y + 40;
			_verse2.alpha = 0;
			
		
			_verse3.y = _verse2.y + 40;
			_verse3.alpha = 0;
			
		
			_verse4.y = _verse3.y + 40;
			_verse4.alpha = 0;
			
			this.addChild(_verse1);
			this.addChild(_verse2);
			this.addChild(_verse3);
			this.addChild(_verse4);
		}
		
		private function noteViewReady():void
		{
			this.dispatchEventWith(MainScenceEvent.NOTE_VIEW_READY, true);
		}
		
		private function showPoems():void
		{
			noteViewReady();
//			TweenMax.to(_verse1,1,{y:100, alpha:1,onComplete:function():void
//			{
//				TweenMax.to(_verse2,1,{y:_verse1.y + 40,alpha:1,onComplete:function():void
//				{
//					TweenMax.to(_verse3,1,{y:_verse2.y + 40,alpha:1,onComplete:function():void
//					{
//						TweenMax.to(_verse4,1,{y:_verse3.y + 40,alpha:1,onComplete:function():void
//						{
//
//						}
//						}
//						)
//					}
//					})
//				}
//				});
//			}
//			}
//			);
		}
	}
}
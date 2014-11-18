package game.view.guiLayer.enemyInfo
{
	import frame.view.viewDelegate.BaseViewer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import vo.ObjEnemyStatusInfo;
	
	/**
	 * 敌人状态 
	 * @author admin
	 * 
	 */	
	public class EnemyInfoItemView extends BaseViewer
	{
		private var _bgImage:Image = null;//一般
		private var _langbgImage:Image = null;//长血条
		private var _bgImageSmall:Image = null;//最小
		private var _bgImageWithMp:Image = null;//mp
		
		private var _info:ObjEnemyStatusInfo = null;
		private var _headContainer:Sprite = null;
		private var _headImage:Image = null;
		
		private var _hpImage:Image = null;
		private var _shortImage:Image = null;
		private var _longImage:Image = null;
		private var _bossHpImage:Image = null;
		private var _bossMpImage:Image = null;
		
		private var _oldHpValue:Number = 0;
		private var _oldMpValue:Number = 0;
		private var _scaParam:Number = 1;
		public function EnemyInfoItemView()
		{
			super();
			this.initView();
		}
		
		public function get info():ObjEnemyStatusInfo
		{
			return _info;
		}

		public function updateView(info:ObjEnemyStatusInfo):void
		{
			_info = info;
			
			if(_info.currentHp<0)
				_info.currentHp = 0;
			
			if(_info.currentMp<0)
				_info.currentMp = 0;
			
			if(_oldHpValue != _info.currentHp)
			{
				this.setheadImage();
				
				_hpImage.scaleX = -1*info.currentHp/info.enemyConfigInfo.maxHp ;	
				_shortImage.scaleX = -1*info.currentHp/info.enemyConfigInfo.maxHp ;	

				_longImage.scaleX = -1*info.currentHp/info.enemyConfigInfo.maxHp ;	
				_bossHpImage.scaleX = -1*info.currentHp/info.enemyConfigInfo.maxHp ;	

				_oldHpValue =  _info.currentHp;
			}
			
			
			if(_oldMpValue != _info.currentMp)
			{
				this.setheadImage();				
				_bossMpImage.scaleX = -1*info.currentMp/info.enemyConfigInfo.maxMp ;
				_oldMpValue =  _info.currentMp;
			}
//			trace("_info.currentHp:"+_info.currentHp);
			
			if(_info.currentHp<1)
			{
				_hpImage.visible = false;
				_shortImage.visible = false;
				_longImage.visible = false;
				_bossHpImage.visible = false;
			}
		}		
		
		public function showRoleInfo():void
		{
//			TweenMax.to(this, 3, {x:0,ease:Elastic.easeOut});
			this.x = 0;
		}
		
		public function hideRoleInfo():void
		{
//			TweenMax.to(this, 1, {x:this.width*2, ease:Elastic.easeOut});
			
			if(_info.enemyConfigInfo.statusBarType != "3")
			{
				this.x = this.width*2;
			}
			else
			{
				if(_info.currentHp<6)
				{
					_hpImage.visible = false;
					_shortImage.visible = false;
					_longImage.visible = false;
					_bossHpImage.visible = false;
				}
			}
		}
		
		private function initView():void
		{
			_bgImage =  new Image(assetManager.getTextureAtlas("gui_images").getTexture("enemyHpBg"));
			_bgImage.x = 0;
			this.addChild(_bgImage);			
			
			_langbgImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("enemyStatusBg2"));
			_langbgImage.x = -1*(_langbgImage.width - _bgImage.width)
			this.addChild(_langbgImage);
			
			_bgImageSmall = new Image(assetManager.getTextureAtlas("gui_images").getTexture("enemyStatusBg3"));
			_bgImageSmall.x = -1*(_bgImageSmall.width - _bgImage.width);
			this.addChild(_bgImageSmall);
			
			_bgImageWithMp = new Image(assetManager.getTextureAtlas("gui_images").getTexture("BossStatusBg"));
			_bgImageWithMp.x = -1*(_bgImageWithMp.width - _bgImage.width);
			this.addChild(_bgImageWithMp);
			
			_headContainer = new Sprite();
			_headContainer.x = 130;
			_headContainer.y = 5;
			this.addChild(_headContainer);			
			
			_hpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("enemyHpbar"));
			_hpImage.y = 27;
			_hpImage.scaleX = -1;
			_hpImage.x = 109;
			this.addChild(_hpImage);
			
			_shortImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("shortHpValue"));
			_shortImage.y = 27;
			_shortImage.scaleX = -1;
			_shortImage.x = 110;
			this.addChild(_shortImage);
			
			_longImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("longHpBar"));
			_longImage.y = 27;
			_longImage.scaleX = -1;
			_longImage.x = 110;
			this.addChild(_longImage);
			
			_bossHpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bossHpBar"));
			_bossHpImage.y = 21.5;
			_bossHpImage.scaleX = -1;
			_bossHpImage.x = 100;
			this.addChild(_bossHpImage);
			
			
			_bossMpImage = new Image(assetManager.getTextureAtlas("gui_images").getTexture("bossMpBar"));
			_bossMpImage.y = 45.5;
			_bossMpImage.scaleX = -1;
			_bossMpImage.x = 98;
			this.addChild(_bossMpImage);
			
			this.x = this.width*2;
		}
		
		private function setheadImage():void
		{
			if(null == _headImage && _info&&_info.enemyConfigInfo&&_info.enemyConfigInfo.headName!="")
			{
				_headImage =  new Image(assetManager.getTextureAtlas("gui_images").getTexture(_info.enemyConfigInfo.headName));				
				_headContainer.addChild(_headImage);
				
				//狗
				if(_info.enemyConfigInfo.statusBarType == "0")
				{
					 _bgImage.visible = false;
					 _langbgImage.visible = false;
					 _bgImageSmall.visible = true;
					 _bgImageWithMp.visible = false;
					 _headImage.x = -12;
					 
					 _hpImage.visible = false;
					_shortImage.visible = true;
					_longImage.visible = false;
					 _bossHpImage.visible = false;
					 _bossMpImage.visible = false;
				}
				
				//高大
				if(_info.enemyConfigInfo.statusBarType == "2")
				{
					_bgImage.visible = false;
					_langbgImage.visible = true;
					_bgImageWithMp.visible = false;
					_bgImageSmall.visible = false;
					_headImage.x = -5;
					_headImage.y = 3;
					_hpImage.visible = false;
					_shortImage.visible = false;
					_longImage.visible = true;
					_bossHpImage.visible = false;
					_bossMpImage.visible = false;
				}
				//基础士兵
				if(_info.enemyConfigInfo.statusBarType == "1")
				{
					_bgImage.visible = true;
					_langbgImage.visible = false;
					_bgImageSmall.visible = false;
					_bgImageWithMp.visible = false;
					_headImage.x = 3;
					
					_hpImage.visible = true;
					_shortImage.visible = false;
					_longImage.visible = false;
					_bossHpImage.visible = false;
					_bossMpImage.visible = false;
				}
				//boss
				if(_info.enemyConfigInfo.statusBarType == "3")
				{
					_bgImage.visible = false;
					_langbgImage.visible = false;
					_bgImageSmall.visible = false;
					_bgImageWithMp.visible = true;
					_headImage.y = -10;
					_headImage.x = -20;
					
					_hpImage.visible = false;
					_shortImage.visible = false;
					_longImage.visible = false;
					_bossHpImage.visible = true;
					_bossMpImage.visible = true;
				}
				
				if(_info.enemyConfigInfo.statusBarType == "4")
				{
					_bgImage.visible = false;
					_langbgImage.visible = false;
					_bgImageSmall.visible = false;
					_bgImageWithMp.visible = true;
					_headImage.y = 0;
					_headImage.x = -20;
					
					_hpImage.visible = false;
					_shortImage.visible = false;
					_longImage.visible = false;
					_bossHpImage.visible = true;
					_bossMpImage.visible = true;
				}
			}
		}
		
		private function resetPos():void
		{
			this.x = 0;
		}
	}
}
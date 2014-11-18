package  game.view.gameScenceView.viewLayers
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Cubic;
	
	import flash.utils.setTimeout;
	
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.physics.nape.Nape;
	import citrus.utils.Mobile;
	import citrus.utils.objectmakers.ObjectMakerStarling;
	import citrus.view.starlingview.StarlingCamera;
	
	import enum.MsgTypeEnum;
	
	import frame.commonInterface.IDispose;
	
	import game.scenceInterac.ladder.LadderPlatform;
	import game.view.boss.BaseEnemyHero;
	import game.view.enemySoldiers.BaseEnemy;
	import game.view.models.HeroStatusModel;
	import game.view.superView.baseGameview.BaseGameLevView;
	
	import starling.textures.TextureAtlas;
	
	import utils.AssetUtils;
	import utils.configs.DicRoleAttackConfigUtil;
	
	import vo.ObjShakWorldInfo;
	import vo.attackInfo.ObjAttackMoveConfig;
	
	/**
	 * @author songdu
	 * 
	 */	
	public class ScenceCeView extends BaseGameLevView 
	{
		private var _tmxXml:XML = null;
		private var _scenceBgView:CitrusSprite = null;
		private var _mapMapOrnamentView:CitrusSprite = null;
		
		private var _ladder:LadderPlatform = null;
		private var _heroStatus:HeroStatusModel = null;
		
		
		private var _shakWorldInfo:ObjShakWorldInfo = null;
		private var _range:Number = 0;
		private var _time:Number = 0;
		
		private var _camera:StarlingCamera = null;
		private var _isDisPosed:Boolean = false;
		public function ScenceCeView()
		{
			
			super();
			this.initModel();	
		}
		
		public function setTmx(tmxXml:XML):void
		{
			
			_tmxXml = tmxXml;
			this.bounds = AssetUtils.getTmxBounds(_tmxXml);
		}
		
		public function addlevMapOrnamentView(ornamentView:CitrusSprite):void
		{
			_mapMapOrnamentView = ornamentView;
		}
		
		public function addScenceBgView(bgView:CitrusSprite):void
		{
			_scenceBgView = bgView;
		}
		
		public function pauseEnemy():void
		{
			for each(var obj:CitrusObject in this.objects)
			{
				if(obj&&obj.name != "nape")
				{
					if(obj is BaseEnemy)
						BaseEnemy(obj).pause();	
					
					if(obj is BaseEnemyHero)
						BaseEnemyHero(obj).pause();
				}
			}	
		}
		
		public function resumeEnemy():void
		{
			for each(var obj:CitrusObject in this.objects)
			{
				if(obj&&obj.name != "nape")
				{
					if(obj is BaseEnemy)
						BaseEnemy(obj).resume();
					
					if(obj is BaseEnemyHero)
						BaseEnemyHero(obj).resume();					
				}
			}	
		}
		
		override public function infoUpdate(data:Object, msgName:String):void
		{
			if(msgName ==  MsgTypeEnum.SHAK_WORLD)
			{
				_shakWorldInfo = data as ObjShakWorldInfo;
				this.setShakWoldInfo(_shakWorldInfo.attackMoveId);
				this.shakeWorld();
			}
		}
		
		override public function initModel():void
		{
			super.initModel();
			_heroStatus = HeroStatusModel.instance;
			_heroStatus.register(this);
		}
		
		override public function dispose():void
		{
			if(!_isDisPosed)
			{
				_isDisPosed = true;
				if(_heroStatus)
					_heroStatus.unRegister(this);
				_heroStatus = null;
				
				if(_mapMapOrnamentView)
					this.remove(_mapMapOrnamentView);
				
				if(_scenceBgView)
					this.remove(_scenceBgView);
				for each(var obj:CitrusObject in this.objects)
				{
					if(obj&&obj.name != "nape")
					{
						this.remove(obj);
						
						if(obj is IDispose)
							IDispose(obj).dispose();	
						if(obj)
						{
							obj.destroy();
							obj = null;
						}						
					}
				}
				
				super.dispose();
				super.destroy();
			}
		}
		
		override public function initialize():void
		{
//			try
//			{
				super.initialize();			
				add(new Nape("nape"));
				
				var sTextureAtlas:TextureAtlas = assetManager.getMapTextureAtlas();
				ObjectMakerStarling.FromTiledMap(_tmxXml, sTextureAtlas,true);
				super.initCamera();
				this.add(_mapMapOrnamentView);	
				_camera = this.getCamera();	
//			}
//			catch(error:Error)
//			{
//				trace("build map error!");
//			}
		}
		
		
		public function heroDeadCameraZoom():void
		{
			_camera.zoom(1.3);
			_camera.zoomEasing = 0.08;
		}
		
		private function resetCamera():void
		{
			
			if(Mobile.isIpad())
				_camera.zoom(1/(1.03*Const.BASE_CAMERA_ZOOM));
			else
				_camera.zoom(1/(1.05*Const.BASE_CAMERA_ZOOM));
			
			_camera.zoomEasing = 0.5;
		}
		private function shakeWorld():void
		{
			
			var value:Number = 0;
			if(_shakWorldInfo.isHit)
			{
				_range = _range+_range/3;
				_time = _time+_time/3;
			}
				
			if(_shakWorldInfo.faceForward)
				value = -1*_range;
			else
				value = _range;
			if(value)
				TweenMax.to(this,_time, {x:value, ease:Circ.easeOut,onComplete:reset});
		}
		
		private function reset():void
		{
			this.x = 0;
		}
		
		private function setShakWoldInfo(moveId:Number):void
		{
			var moveConfig:ObjAttackMoveConfig =  DicRoleAttackConfigUtil.getAttackMoveConfigById(moveId);
			if(moveConfig)
			{
				var dataArr:Array = moveConfig.shakeWordInfo.split(",");
				if(dataArr&&dataArr.length>0)
				{
					_range = dataArr[0];
					_time = dataArr[1];
				}				
			}
		}
	}
}



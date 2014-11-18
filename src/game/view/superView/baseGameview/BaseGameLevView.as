package game.view.superView.baseGameview
{
	import flash.geom.Rectangle;
	
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.platformer.nape.Hero;
	import citrus.view.starlingview.StarlingCamera;
	
	import frame.view.viewInterface.IViewer;
	
	import game.manager.CEEngineManager;
	import game.manager.assetManager.GameAssetManager;
	import game.manager.physicsWorld.PhysicSpaceManager;
	import game.view.models.HeroMoveStepModel;
	
	/**
	 * 基础关卡视图
	 * @author songdu
	 * 
	 */	
	public class BaseGameLevView extends StarlingState implements IViewer
	{
		private var _assetManager:GameAssetManager = null;
		private var _spaceManager:PhysicSpaceManager = null;
		private var _ceEngineManager:CEEngineManager = null;
		
		private var _bounds:Rectangle;
		private var _hero:Hero;
		private var _camera:StarlingCamera;
		
		private var _model:HeroMoveStepModel = null;
		
		private static const BASE_ZOOM:Number = 1.5;
		
		public function BaseGameLevView()
		{
			super();
		}
		
		public function set bounds(value:Rectangle):void
		{
			_bounds = value;
		}

		public function initModel():void
		{
			_model = HeroMoveStepModel.instance;
			_model.register(this);
		}
		
		public function infoUpdate(data:Object, msgName:String):void
		{
			
		}
		
		override public function dispose():void
		{
//			super.dispose();
			if(_model)
				_model.unRegister(this);
			_model = null;
			_hero = null;
			_camera = null;
		}
	
		override public function initialize():void
		{
			super.initialize();
			
			spaceManager.activeNapeWorker();
			
			if(null == _bounds)
				_bounds = new Rectangle(0, 0, Const.STAGE_WIDTH, Const.STAGE_HEIGHT);
		}
		
		public function initCamera():void
		{
			_hero = getObjectByName("swordsman") as Hero;
			_camera = view.camera as StarlingCamera;
			
			
				_camera.setUp(_hero, new MathVector(Const.STAGE_WIDTH / 3+50 , Const.STAGE_HEIGHT / 2 + 50), _bounds, new MathVector(0.5, 0.5));

			_camera.allowRotation = false;
			_camera.allowZoom = true;
			_camera.zoom(Const.BASE_CAMERA_ZOOM);
		}
		
		public function getCamera():StarlingCamera
		{
			return _camera;
		}
		
		/**
		 * 快捷获取资源管理器 
		 * @return 
		 * 
		 */		
		final public function get assetManager():GameAssetManager
		{
			if (_assetManager == null)
				_assetManager = GameAssetManager.instance;
			return _assetManager;
		}
		
		/**
		 * 快捷获取物理空间管理器 
		 * @return 
		 * 
		 */		
		final public function get spaceManager():PhysicSpaceManager
		{
			if (_spaceManager == null)
				_spaceManager = PhysicSpaceManager.instance;
			return _spaceManager;
		}
		
		/**
		 * 快捷获取ceengine管理器 
		 * @return 
		 * 
		 */		
		final public function get ceEngineManager():CEEngineManager
		{
			if (_ceEngineManager == null)
				_ceEngineManager = CEEngineManager.instance;
			return _ceEngineManager;
		}
	}
}
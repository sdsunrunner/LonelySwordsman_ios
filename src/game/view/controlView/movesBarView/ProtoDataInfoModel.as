package game.view.controlView.movesBarView
{
	
	/**
	 * 道具素具模型 
	 * @author admin
	 * 
	 */	
	public class ProtoDataInfoModel
	{
		private static var _instance:ProtoDataInfoModel = null;
		
		private var _hpProtoCount:Number = 0;
		private var _mpProtoCount:Number = 0;
		private var _isHeroLock:Boolean = false;
		
		public function ProtoDataInfoModel(code:$)
		{
			
		}

		public function get mpProtoCount():Number
		{
			return _mpProtoCount;
		}

		public function set mpProtoCount(value:Number):void
		{
			_mpProtoCount = value;
		}

		public function get hpProtoCount():Number
		{
			return _hpProtoCount;
		}

		public function set hpProtoCount(value:Number):void
		{
			_hpProtoCount = value;
		}

		public static function get instance():ProtoDataInfoModel
		{
			return _instance ||=  new ProtoDataInfoModel(new $);
		}
	}
}

class ${}
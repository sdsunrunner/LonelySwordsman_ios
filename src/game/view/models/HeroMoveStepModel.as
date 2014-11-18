package game.view.models
{
	import flash.utils.Dictionary;
	
	import enum.MsgTypeEnum;
	
	import frame.view.viewModel.MessageCenter;
	
	/**
	 * 英雄移动数据模型 
	 * @author admin
	 * 
	 */	
	public class HeroMoveStepModel extends MessageCenter
	{
		private static var _instance:HeroMoveStepModel = null;
		private static var _moveDic:Dictionary = null;
		
		
		private var _heroBasePosX:Number = 0;
		
		public function HeroMoveStepModel(code:$)
		{
			super();
			this.initMoveDic();
		}

		public static function get instance():HeroMoveStepModel
		{
			return _instance ||= new HeroMoveStepModel(new $);
		}
		
		/**
		 * 英雄移动消息 
		 * @param animaName
		 * @param frameLab
		 * 
		 */		
		public function heroMove(animaName:String, frameLab:Number,heroPos:Number,faceForward:Boolean = false):void
		{
			var moveNum:Number = 0;
			if(_moveDic[animaName + "_" + frameLab])
				moveNum = _moveDic[animaName + "_" + frameLab];	
			this.msgName = MsgTypeEnum.HERO_MOVE;	
			
			if(faceForward)
				moveNum = -1*moveNum;
			else
				moveNum = 1*moveNum;
			
			this.msg = moveNum;
			this.notify();
		}
		
		public function heroBeenHitMove(movePos:Number,faceForward:Boolean = false, bgNeedMove:Boolean = true):void
		{
//			var moveNum:Number = 0;
//			if(faceForward)
//				moveNum = -1*movePos;
//			else
//				moveNum = 1*movePos;
//			this.msgName = MsgTypeEnum.HERO_MOVE;	
//			this.msg = moveNum;
//			this.notify();
		}
		
		public function heroRun(heroPos:Number,faceForward:Boolean = false):void
		{			
			if(heroPos != _heroBasePosX)
			{
				var moveNum:Number = 0;
				if(_moveDic["RunAnima"])
					moveNum = _moveDic["RunAnima"];
				
				this.msgName = MsgTypeEnum.HERO_MOVE;	
				
				if(faceForward)
					moveNum = -1*moveNum;
				else
					moveNum = 1*moveNum;
				
				this.msg = moveNum;
				this.notify();	
			}
			_heroBasePosX = heroPos;
		}
		
		private function initMoveDic():void
		{
			_moveDic = new Dictionary();
			//"RunAnima"
			_moveDic["RunAnima"] = 3;
			//RunEnd
			_moveDic["RunEnd_1"] = 5;
			_moveDic["RunEnd_2"] = 3;
			_moveDic["RunEnd_3"] = 3;
			_moveDic["RunEnd_4"] = 2;
			_moveDic["RunEnd_5"] = 2;
			_moveDic["RunEnd_6"] = 2;
			_moveDic["RunEnd_7"] = 0;
			_moveDic["RunEnd_8"] = 0;
			_moveDic["RunEnd_9"] = -2;
			_moveDic["RunEnd_10"] = -5;
			_moveDic["RunEnd_11"] = -3;
			_moveDic["RunEnd_12"] = -2;
			_moveDic["RunEnd_13"] = 0;
			_moveDic["RunEnd_14"] = 0;
			_moveDic["RunEnd_15"] = 0;
			
			//RunStart
			_moveDic["RunStart_1"] = 1;
			_moveDic["RunStart_2"] = 2;
			_moveDic["RunStart_3"] = 3;
			
			//HeavyAttack
			_moveDic["HeavyAttack_1"] = 1;
			_moveDic["HeavyAttack_2"] = 2;
			_moveDic["HeavyAttack_3"] = 3;
			_moveDic["HeavyAttack_10"] = -5;
			_moveDic["HeavyAttack_11"] = -4;
			_moveDic["HeavyAttack_12"] = -3;
			_moveDic["HeavyAttack_13"] = -3;
			//Hurt
			_moveDic["Hurt_1"] = 0;
			_moveDic["Hurt_2"] = -1;
			_moveDic["Hurt_3"] = -2;
			_moveDic["Hurt_4"] = -3;
			_moveDic["Hurt_5"] = -3;
			_moveDic["Hurt_6"] = -1;
			_moveDic["Hurt_7"] = -1;
			_moveDic["Hurt_8"] = -1;
			_moveDic["Hurt_9"] = -1;
			_moveDic["Hurt_10"] = -1;
			_moveDic["Hurt_11"] = 1;
			_moveDic["Hurt_12"] = 2;
			_moveDic["Hurt_13"] = 2;
		}
		
	}
}

class ${}
package game.manager
{
	import citrus.core.SoundManager;
	
	import game.manager.dicManager.DicManager;
	
	import vo.configInfo.ObjAnimaSoundConfig;
	import vo.configInfo.ObjSoundFileConfig;

	/**
	 * 音效表现 
	 * @author songdu
	 * 
	 */	
	public class SoundExpressions
	{
		private static var _instance:SoundExpressions = null;
		
		private var _soundManager:SoundManager = null;
	
		private var _isPlaying:Boolean = false;
		private var _playingSoundId:String = "";
		public function SoundExpressions(code:$)
		{
			_soundManager = SoundManager.getInstance();
		}
		
		public static function get instance():SoundExpressions
		{
			return _instance ||= new SoundExpressions(new $);
		}
		
		
		public function playStartCgBgSound():void
		{
			_soundManager.stopAllPlayingSounds();
			var soundConfigInfo:ObjSoundFileConfig
				= DicManager.instance.getStratCgSoundConfig();
			_soundManager.addSound(Const.START_CG_BG_SOUND,soundConfigInfo.fileName);
			_soundManager.playSound(Const.START_CG_BG_SOUND,.6,1);
		}
		
		public function stopPreSound():void
		{
			this.stopSound(_playingSoundId);
		}
		
		public function stopPlayingSound():void
		{
			_soundManager.stopAllPlayingSounds();
		}
		
		public function playBossDiaCgBgSound():void
		{
			_soundManager.stopAllPlayingSounds();
			var soundConfigInfo:ObjSoundFileConfig
				= DicManager.instance.getBossDiaCgSoundConfig();
			_soundManager.addSound(Const.BOSS_DIA_CG_BG_SOUND,soundConfigInfo.fileName);
			_soundManager.playSound(Const.BOSS_DIA_CG_BG_SOUND,.6,1);
		}
		
		public function playBossDiaCgExpBgSound():void
		{
			var soundConfigInfo:ObjSoundFileConfig
				= DicManager.instance.getBossDiaCgExpSoundConfig();
			_soundManager.addSound(Const.BOSS_DIA_CG_BG_EXP_SOUND,soundConfigInfo.fileName);
			_soundManager.playSound(Const.BOSS_DIA_CG_BG_EXP_SOUND,.6,1);
		}
		
		/**
		 * 播放欢迎场景音效 
		 * 
		 */		
		public function playWelcomeScenceSound():void
		{
			_soundManager.stopAllPlayingSounds();
			var soundConfigInfo:ObjSoundFileConfig
				= DicManager.instance.getWelcomeBgSoundConfig();
			_soundManager.addSound(Const.WEL_COME_SCENCE_BG_SOUND,soundConfigInfo.fileName);
			_soundManager.playSound(Const.WEL_COME_SCENCE_BG_SOUND,.6);
		}	
		
		
		/**
		 * 播放关卡背景音效 
		 * @param soundId
		 * 
		 */		
		public function playGameLevBgSound(soundId:String,fileName:String):void
		{
			if(!_soundManager.soundIsPlaying(soundId))
			{
				_soundManager.addSound(soundId,fileName);
				_soundManager.playSound(soundId);
				_playingSoundId = soundId;
			}
			
			if(soundId != _playingSoundId)
				stopSound(_playingSoundId);
		}
		
		public function stopSound(soundId:String):void
		{
			_soundManager.stopSound(soundId);
		}
		
		/**
		 * 播放动作音效 
		 * @param animaName
		 * @param currentFrame
		 * 
		 */		
		public function playActionSound(animaName:String,currentFrame:Number):void
		{
			var soundConfigInfo:ObjAnimaSoundConfig
				= DicManager.instance.getAnimaSoundConfigByAnimaName(animaName,currentFrame);
			
			if(soundConfigInfo)	
			{
				if(!_isPlaying&&soundConfigInfo.startFrame.indexOf( currentFrame)>-1)	
				{
					_soundManager.playSound(soundConfigInfo.soundId,1,1);
					_isPlaying = true;
				}
				else
					_isPlaying = false;
			}
			else
			{
				_isPlaying = false;
				CONFIG::DEBUG
				{
					trace("can not get sound config info:" + animaName);
				}
			
			}
		}
	}
}

class ${}
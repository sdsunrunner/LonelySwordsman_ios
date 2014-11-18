package game.command.sound
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	
	import vo.configInfo.ObjSoundFileConfig;
	
	/**
	 * 构建音效命令 
	 * @author songdu
	 * 
	 */	
	public class BuildRoleSoundCommand extends GameBaseCommand
	{
		override public function excute(note:INotification):void
		{
			var preLoadFile:Vector.<ObjSoundFileConfig> 
				= this.dicManager.getPreLoadSoundConfigInfo();
				
			for each(var soudConfig:ObjSoundFileConfig in preLoadFile)
				this.soundManager.addSound(soudConfig.soundId,soudConfig.fileName);
			
			this.soundManager.preLoadSounds();
		}
	}
}
package game.command.effect
{
	import enum.CameraEffectTypeEnum;
	
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseCommand;
	import game.manager.CEEngineManager;
	import game.view.gameScenceView.viewLayers.ScenceCeView;
	
	/**
	 * 镜头推进命令 
	 * @author admin
	 * 
	 */	
	public class ZoomCameraCommand extends GameBaseCommand
	{
		private var _scenceCeView:ScenceCeView = null;
		
		override public function excute(note:INotification):void
		{	
			var type:String = note.data as String;
			if(CEEngineManager.instance.ceEngine&&CEEngineManager.instance.ceEngine.state)
			{
				_scenceCeView = ScenceCeView(CEEngineManager.instance.ceEngine.state);
			}
			
			if(_scenceCeView)
			{
				_scenceCeView.visible = true;
				if(uiDelegate.gameLevViewController)
					uiDelegate.gameLevViewController.zoomCloseShotView();
				switch(type)
				{
					case CameraEffectTypeEnum.HERO_DEATH_CAMERA_ZOOM:
						_scenceCeView.heroDeadCameraZoom();						
						break;
				}
			}
			
		}
	}
}
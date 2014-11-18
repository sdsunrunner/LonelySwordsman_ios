package  frame.command.cmdInterface
{
	
	/**
	 * cm 命令接口  
	 * @author songdu.greg
	 * 
	 */	
	public interface ICommand
	{
		function excute(note:INotification):void;
	}
}
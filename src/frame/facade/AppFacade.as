package frame.facade
{
	import flash.utils.Dictionary;
	
	import frame.command.cmdInterface.ICommand;
	
	/**
	 * 命令Facade
	 * @author songdu.greg
	 * 
	 */	
	public class AppFacade
	{
		private var _facade:Dictionary = null;/*String ICommand*/
	
		private static var _instance:AppFacade = null;
//==============================================================================
// Public Functions
//==============================================================================
		public function AppFacade(code:$)
		{
			_facade = new Dictionary(false);
		}
		
		public static function get instance():AppFacade
		{
			return _instance ||= new AppFacade(new $);
		}
		
		/**
		 * 注册命令 
		 * @param commandType
		 * @param command
		 * 
		 */		
		public function addCommand(commandType:String,command:Class):void
		{
			if(_facade[commandType])
				throw new Error(commandType + "has been registed");
			_facade[commandType] = command;
		}
		
		/**
		 * 实例化一个命令
		 * @param commandType
		 * @return 
		 * 
		 */		
		public function instanceCommandByType(commandType:String):ICommand
		{
			var commansClassRef:Class = _facade[commandType];
			var commandInstance:ICommand = new commansClassRef();
			
			return commandInstance;
		}
		
		/**
		 * 检查command是否注册 
		 * @param commandType
		 * @return 
		 * 
		 */		
		public function hasCommand(commandType:String):Boolean
		{
			if(_facade[commandType])
				return true;
			return false;
		}
	}
}
class ${}

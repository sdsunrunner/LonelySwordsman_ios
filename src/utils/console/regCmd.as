package  utils.console
{
	import com.junkbyte.console.Cc;

	public function regCmd(n:String, callBack:Function, desc:String = ""):void
	{
		CONFIG::IMPOLDER
		{
			Cc.addSlashCommand(n, callBack, desc);
		}
	}
}
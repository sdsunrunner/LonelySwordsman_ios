package  utils.console
{
	import com.junkbyte.console.Cc;

	public function logCh(ch:String, ...args):void
	{
		CONFIG::IMPOLDER
		{
			Cc.logch(ch, args);
		}
	}
}
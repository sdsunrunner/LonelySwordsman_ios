package  utils.console
{
	import com.junkbyte.console.Cc;
	public function errorCh(ch:*, ...args):void
	{
		CONFIG::IMPOLDER
		{
			Cc.errorch(ch, args);
		}
	}
}
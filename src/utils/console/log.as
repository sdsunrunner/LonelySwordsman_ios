package  utils.console
{
	import com.junkbyte.console.Cc;
	

	public function log(...args):void
	{
		CONFIG::IMPOLDER
		{
			Cc.log(args);
		}
	}
}
package  utils.console
{
	import com.junkbyte.console.Cc;
	public function infoCh(ch:*, ...args):void
	{
		CONFIG::IMPOLDER
		{
			args.unshift(ch);
			Cc.infoch.apply(null, args);
		}
	}
}
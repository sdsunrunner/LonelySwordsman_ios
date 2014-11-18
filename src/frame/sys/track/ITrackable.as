package frame.sys.track
{
	public interface ITrackable
	{
		function track(msg:Object, msgName:String, delayFlag:Boolean = false):void;
	}
}
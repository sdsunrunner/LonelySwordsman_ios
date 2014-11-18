package frame.view
{
	import flash.events.Event;
	
	/**
	 * 层管理事件 
	 * @author songdu.greg
	 * 
	 */	
	public class LayerEvent extends Event
	{
		public static const REMOVED_FORM_LAYER:String = "REMOVED_FORM_LAYER";
//==============================================================================
// Public Functions
//==============================================================================
		public function LayerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}	
//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Event
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-	
	}
}
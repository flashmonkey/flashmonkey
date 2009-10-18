package org.flashmonkey.flash.connection.events
{
	import flash.events.Event;

	public class Red5Event extends Event
	{
		/** dispatched after a NetConnection is successfully connected. **/
		public static const CONNECTED			: String	= "connected";
		
		/** dispatched after a NetConnection is closed. **/
		public static const DISCONNECTED		: String	= "disconnected";
		
		public static const REJECTED : String = "rejected";
		
		public function Red5Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
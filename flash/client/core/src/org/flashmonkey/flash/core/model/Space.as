package org.flashmonkey.flash.core.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	[RemoteClass]
	public class Space
	{
		[Bindable]
		public var name:String;

		[Bindable]
		public var children:IList = new ArrayCollection();

	}
}
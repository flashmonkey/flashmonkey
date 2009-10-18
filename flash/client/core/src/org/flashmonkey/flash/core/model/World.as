package org.flashmonkey.flash.core.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	[RemoteClass]
	public class World
	{
		[Bindable]
		public var name:String;
		
		[Bindable]
		public var files:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var spaces:IList = new ArrayCollection();
	}
}
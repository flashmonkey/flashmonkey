package org.flashmonkey.flash.gestures
{
	public class GestureEntry
	{
		[Bindable]
		public var label:String;

		[Bindable]
		public var thumbnailImage:*;
		
		[Bindable]
		public var fullImage:String;
		
		public function GestureEntry(label:String = null, thumbnailImage:Class = null, fullImage:String = null)
		{
			this.label = label;
			this.thumbnailImage = thumbnailImage;
			this.fullImage = fullImage;
		}
	}
}
package org.flashmonkey.flash.pv3d
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.events.Event;
	
	import org.flashmonkey.flash.api.IAvatar;
	import org.flashmonkey.flash.api.ISynchronisedObject;

	public class BuildAvatarOperation extends AbstractOperation
	{
		protected var _avatarOperation:IOperation;
		
		protected var _syncObjectOperation:IOperation;
		
		protected var _displayObjectOperation:IOperation;
		
		protected var _avatar:IAvatar;
		
		public function BuildAvatarOperation(avatarOperation:IOperation, syncObjectOperation:IOperation, displayObjectOperation:IOperation)
		{
			super();
			
			_avatarOperation = avatarOperation;
			_syncObjectOperation = syncObjectOperation;
			_displayObjectOperation = displayObjectOperation;
		}
		
		public override function execute():void
		{
			_avatarOperation.addEventListener(Event.COMPLETE, onAvatarOperationComplete);
			_avatarOperation.execute();
		}
		
		protected function onAvatarOperationComplete(e:Event):void 
		{
			_avatarOperation.removeEventListener(Event.COMPLETE, onAvatarOperationComplete);
			
			_avatar = IAvatar(_avatarOperation.result);
			
			_syncObjectOperation.addEventListener(Event.COMPLETE, onSyncObjectOperationComplete);
			_syncObjectOperation.execute();
		}
		
		protected function onSyncObjectOperationComplete(e:Event):void 
		{
			_syncObjectOperation.removeEventListener(Event.COMPLETE, onSyncObjectOperationComplete);
			_avatar.object = ISynchronisedObject(_syncObjectOperation.result);
			
			_displayObjectOperation.addEventListener(Event.COMPLETE, onDisplayObjectOperationComplete);
			_displayObjectOperation.execute();
		}
		
		protected function onDisplayObjectOperationComplete(e:Event):void 
		{
			_displayObjectOperation.removeEventListener(Event.COMPLETE, onDisplayObjectOperationComplete);
			trace("DISPLAY OBJECT: " + _displayObjectOperation.result);
			_avatar.object.displayObject = _displayObjectOperation.result;
			
			handleComplete(new Event(Event.COMPLETE));
		}
		
		public override function get result():*
		{
			return _avatar;
		}
	}
}
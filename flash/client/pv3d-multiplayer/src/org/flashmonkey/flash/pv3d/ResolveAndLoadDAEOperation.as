package org.flashmonkey.flash.pv3d
{
	import com.joeberkovitz.moccasin.service.AbstractOperation;
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import flash.events.Event;
	
	import org.flashmonkey.flash.connection.messages.SendMessageOperation;
	import org.flashmonkey.flash.pv3d.operations.ResolveAvatarLocationMessage;
	import org.papervision3d.objects.parsers.DAE;

	public class ResolveAndLoadDAEOperation extends AbstractOperation
	{
		private var _sendOperation:SendMessageOperation;
		
		private var _model:DAE;
		
		public override function get result():*
		{
			return _model
		}
		
		public function ResolveAndLoadDAEOperation(sendOperation:SendMessageOperation)
		{
			super();
			
			_sendOperation = sendOperation;
		}
		
		public override function execute():void
		{
			_sendOperation.addEventListener(Event.COMPLETE, onLocationResolved);
			_sendOperation.execute();
		}
		
		protected function onLocationResolved(e:Event):void 
		{
			var location:String = ResolveAvatarLocationMessage(_sendOperation.message).location;
			
			var loadOperation:IOperation = new DAEDisplayObject3DOperation(location, 180);
			loadOperation.addEventListener(Event.COMPLETE, onModelLoaded);
			loadOperation.execute();
		}
		
		protected function onModelLoaded(e:Event):void 
		{
			var operation:IOperation = IOperation(e.target);
			_model = DAE(operation.result);
			
			handleComplete(new Event(Event.COMPLETE));
		}
	}
}
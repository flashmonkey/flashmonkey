package org.flashmonkey.flash.pv3d.service
{
	import com.joeberkovitz.moccasin.service.IOperation;
	
	import org.flashmonkey.flash.api.AvatarType;
	import org.flashmonkey.flash.api.IAvatarService;
	import org.flashmonkey.flash.api.connection.IClient;
	import org.flashmonkey.flash.api.connection.messages.IMessage;
	import org.flashmonkey.flash.connection.messages.SendMessageOperation;
	import org.flashmonkey.flash.pv3d.AvatarOperation;
	import org.flashmonkey.flash.pv3d.BuildAvatarOperation;
	import org.flashmonkey.flash.pv3d.ResolveAndLoadDAEOperation;
	import org.flashmonkey.flash.pv3d.SimpleDisplayObject3DOperation;
	import org.flashmonkey.flash.pv3d.SynchronisedObjectOperation;
	import org.flashmonkey.flash.pv3d.objects.ColouredCube;
	import org.flashmonkey.flash.pv3d.operations.ResolveAvatarLocationMessage;

	public class PaperworldAvatarService implements IAvatarService
	{
		private var _client:IClient;
		
		public function PaperworldAvatarService(client:IClient)
		{
			_client = client;
		}

		public function getAvatar(type:AvatarType, properties:Object):IOperation
		{
			return new AvatarOperation(type);
		}
		
		public function getAvatarAsync(type:AvatarType, properties:Object):IOperation
		{
			return new BuildAvatarOperation(getAvatar(type, properties), 
											getSynchronisedObject(type, properties), 
											getDisplayObject(type, properties));
		}
		
		public function getSynchronisedObject(type:AvatarType, properties:Object):IOperation
		{
			return new SynchronisedObjectOperation();
		}
		
		public function getDisplayObject(type:AvatarType, properties:Object):IOperation
		{
			/*var displayObject:* = properties["displayObject"];
			
			if (displayObject is DisplayObject3D)
			{
				return new SimpleDisplayObject3DOperation(DisplayObject3D(displayObject));
			}
			else if (displayObject is String)
			{
				return new DAEDisplayObject3DOperation(String(displayObject), 180);
			}
			
			return null;*/
			
			var operation:IOperation;
			
			if (properties != null)
			{
				if (properties["id"] != null)
				{
					var id:String = properties["id"] as String;
					var message:IMessage = new ResolveAvatarLocationMessage(id);
					var sendOperation:SendMessageOperation = _client.sendToServer(message) as SendMessageOperation;
					operation = new ResolveAndLoadDAEOperation(sendOperation);
				} 
				else if (properties["displayObject"] != null) 
				{
					operation = new SimpleDisplayObject3DOperation(new ColouredCube());
				}
			}
			
			return operation;
		}
		
	}
}
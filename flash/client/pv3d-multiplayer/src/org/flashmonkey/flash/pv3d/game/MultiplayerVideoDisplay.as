package org.flashmonkey.flash.pv3d.game
{
	import flash.display.DisplayObjectContainer;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import mx.core.Container;
	
	import org.flashmonkey.flash.api.connection.INetConnection;
	import org.flashmonkey.flash.connection.events.Red5Event;
	import org.flashmonkey.flash.core.game.display.IDisplay;

	public class MultiplayerVideoDisplay implements IDisplay
	{
		protected var _video:Video;
		
		public function get video():Video 
		{
			return _video;
		}
		
		protected var _connection:INetConnection;
		
		protected var _streamName:String;
		
		public function set streamName(value:String):void 
		{
			_streamName = value;
		}
		
		protected var _netStream:NetStream;
		
		public function MultiplayerVideoDisplay(connection:INetConnection, streamName:String)
		{
			super();
			
			_connection = connection;
			_streamName = streamName;
			
			init();
		}
		
		protected function init():void 
		{
			_video = new Video();
			
			if (_connection.connected)
			{
				createNetStream();
			}
			else
			{
				_connection.addEventListener(Red5Event.CONNECTED, createNetStream);
			}
		}
		
		protected function createNetStream(e:Event = null):void
		{
			_connection.removeEventListener(Red5Event.CONNECTED, createNetStream);
			
			_netStream = new NetStream(NetConnection(_connection));
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				
			_video.attachNetStream(_netStream);
			
			if (_streamName)
			{
				_netStream.play(_streamName);
			}
		}
		
		public function set target(value:DisplayObjectContainer):void
		{
			try 
			{
				value.addChild(_video);
			}
			catch (e:Error) 
			{
			}
		}
		
		public function get scene():Object
		{
			return null;
		}
		
		public function render(tpf:Number):void
		{
		}
		
		private function netStatusHandler(event:NetStatusEvent):void 
		{
            switch (event.info.code) 
            {
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + _streamName);
                    break;
            }
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void 
        {
            // ignore AsyncErrorEvent events.
        }

	}
}
/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package org.flashmonkey.flash.pv3d.scenes 
{
	import org.flashmonkey.flash.api.IPaperworldObject;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedAvatar;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedScene;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.scenes.Scene3D;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedScene implements ISynchronisedScene 
	{
		private var logger : ILogger = LoggerFactory.getLogger( "Paperworld(PV3D)" );

		protected var _scene : Scene3D;

		public function get scene() : *
		{
			return _scene;
		}

		public function set scene(value : *) : void
		{
			_scene = value;
		}

		public function SynchronisedScene(scene : Scene3D = null)
		{
			super( );
			
			_scene = scene || new Scene3D();
		}

		public function addAvatar(avatar:ISynchronisedAvatar) : ISynchronisedAvatar
		{			
			trace(avatar);
			trace(avatar.object);
			logger.info( "adding " + IPaperworldObject( avatar.object ).displayObject );
			
			var object:IPaperworldObject = IPaperworldObject( avatar.object );
			
			if (object && object.displayObject && object.displayObject is DisplayObject3D)
			{
				_scene.addChild(object.displayObject);
				
				return avatar;
			}
			
			return null;	
		}

		public function removeAvatar(avatar:ISynchronisedAvatar) : ISynchronisedAvatar
		{
			var object:IPaperworldObject = IPaperworldObject( avatar.object );
			
			if (object && object.displayObject && object.displayObject is DisplayObject3D)
			{
				_scene.removeChild( object.displayObject );
				
				return avatar;
			}
			
			return null;
		}
	}
}

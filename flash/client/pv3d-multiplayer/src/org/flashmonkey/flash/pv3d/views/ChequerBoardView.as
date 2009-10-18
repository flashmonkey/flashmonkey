package org.flashmonkey.flash.pv3d.views 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.papervision3d.core.view.IView;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.Viewport3D;
	import org.flashmonkey.flash.api.multiplayer.ISynchronisedScene;
	import org.flashmonkey.flash.pv3d.scenes.SynchronisedScene;		

	/**
	 * @author Trevor
	 */
	public class ChequerBoardView extends BasicView implements IView 
	{
		[Embed(source="Chequer.png")] 
		private var ChequerImage : Class; 

		public var syncScene : ISynchronisedScene;

		public var floorScene : Scene3D;

		public var floorViewport : Viewport3D;

		public var floor : DisplayObject3D;

		private var $width : Number;

		private var $height : Number;

		public var zoomAmount : Number = 10;

		public function ChequerBoardView(width : Number = 1000, height : Number = 1000, viewportWidth : Number = 640, viewportHeight : Number = 480, scaleToStage : Boolean = true, interactive : Boolean = false, cameraType : String = "Free") 
		{
			super( viewportWidth, viewportHeight, scaleToStage, interactive, cameraType );		
			
			$width = width;
			$height = height;	
			
			syncScene = new SynchronisedScene(scene);
			
			initialise();
		}

		public function initialise() : void 
		{
			initialiseFloor( );
			initialiseCamera( );
			
			addEventListeners( );
		}

		protected function initialiseFloor() : void 
		{
			floorViewport = new Viewport3D( 640, 480, true, false);
			addChildAt( floorViewport, 0 );
			
			floorScene = new Scene3D( );
			
			var chequer : Bitmap = new ChequerImage( );
			var chequerWidth : Number = chequer.width;
			var chequerHeight : Number = chequer.height;
			
			var material : BitmapMaterial = new BitmapMaterial( chequer.bitmapData );
			material.tiled = true;
			material.maxU = $width / chequerWidth;
			material.maxV = $height / chequerHeight;
			
			floor = new Plane( material, $width, $height, 5, 5 );

			floor.pitch( 90 );
			
			floorScene.addChild( floor );
		}

		protected function initialiseCamera() : void 
		{
			camera.moveUp( 500 );
			camera.lookAt( floor );
		}

		protected function addEventListeners() : void
		{
			viewport.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
		}

		protected function onMouseWheel(event : MouseEvent) : void 
		{
			camera.moveForward( event.delta > 0 ? zoomAmount : -zoomAmount );
		}

		override protected function onRenderTick(event : Event = null) : void
		{
			renderer.renderScene( floorScene, _camera, floorViewport );
			
			super.onRenderTick( event );
		}
	}
}

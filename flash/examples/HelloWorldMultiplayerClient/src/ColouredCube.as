package  
{
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;		

	/**
	 * @author Trevor
	 */
	public class ColouredCube extends Cube 
	{
		public function ColouredCube(colour : int = 0xFFCC00, width : Number = 500, depth : Number = 500, height : Number = 500, segmentsS : int = 1, segmentsT : int = 1, segmentsH : int = 1, insideFaces : int = 0, excludeFaces : int = 0)
		{
			super( new MaterialsList( {all:	new ColorMaterial( colour )} ), width, depth, height, segmentsS, segmentsT, segmentsH, insideFaces, excludeFaces );
		}
	}
}

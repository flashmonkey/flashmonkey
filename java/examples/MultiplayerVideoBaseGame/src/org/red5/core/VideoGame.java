package org.red5.core;
import java.awt.image.BufferedImage;
import java.nio.ByteBuffer;

import jmetest.flagrushtut.lesson9.Lesson9;

import com.jme.image.Image;
import com.jme.renderer.Renderer;
import com.jme.util.geom.BufferUtils;

public class VideoGame extends Lesson9 {

	private BufferedImage screenContents;
	
	private boolean dirty = true;
	
	public VideoGame() {

	}
	
	@Override
	protected void render(float interpolation) {
		
		Renderer renderer = display.getRenderer();
		
        // Clear the screen
		renderer.clearBuffers();
        //display.getRenderer().draw(scene);
        /** Have the PassManager render. */
        passManager.renderPasses(renderer);
        
		if (dirty)
		{
			final int width = renderer.getWidth();
			final int height = renderer.getHeight();
			final ByteBuffer buff = BufferUtils.createByteBuffer(width * height * 3);
			renderer.grabScreenContents(buff, Image.Format.RGB8, 0, 0, width, height);
			final int w = width;
			final int h = height;
	
			BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	
			// Grab each pixel information and set it to the BufferedImage info.
			for (int x = 0; x < w; x++) {
				for (int y = 0; y < h; y++) {
	
					int index = 3 * ((h - y - 1) * w + x);
					int argb = (((int) (buff.get(index + 0)) & 0xFF) << 16) // r
							| (((int) (buff.get(index + 1)) & 0xFF) << 8) // g
							| (((int) (buff.get(index + 2)) & 0xFF)); // b
	
					img.setRGB(x, y, argb);
				}
			}
			
			screenContents = img;
		}
	}
	
	public BufferedImage getScreenContents() {
		dirty = true;
		return screenContents;
	}
}

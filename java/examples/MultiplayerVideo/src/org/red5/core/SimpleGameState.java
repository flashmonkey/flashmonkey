package org.red5.core;

import java.awt.image.BufferedImage;
import java.nio.ByteBuffer;

import com.jme.image.Image;
import com.jme.renderer.Renderer;
import com.jme.system.DisplaySystem;
import com.jme.util.geom.BufferUtils;
import com.jmex.game.state.DebugGameState;
import com.xuggle.red5.demo.VideoTranscoderDemo;

public class SimpleGameState extends DebugGameState {
	
	VideoTranscoderDemo simulation;
	
	public SimpleGameState(VideoTranscoderDemo simulation) {
		super();
		
		this.simulation = simulation;
	}
	
	public void render(float tpf) {
    	super.render(tpf);
    	
    	Renderer renderer = DisplaySystem.getDisplaySystem().getRenderer();
    	
    	renderer.clearBuffers();
    	renderer.draw(rootNode);
    	
    	final int width = renderer.getWidth();
		final int height = renderer.getHeight();
		
		final ByteBuffer buff = BufferUtils.createByteBuffer(width * height * 3);
        renderer.grabScreenContents(buff, Image.Format.RGB8, 0, 0, width, height);
        final int w = width;
        final int h = height;
                            
    	BufferedImage frame = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        // Grab each pixel information and set it to the BufferedImage info.
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                
                int index = 3 * ((h- y - 1) * w + x);
                int argb = (((int) (buff.get(index+0)) & 0xFF) << 16) //r
                         | (((int) (buff.get(index+1)) & 0xFF) << 8)  //g
                         | (((int) (buff.get(index+2)) & 0xFF));      //b

                frame.setRGB(x, y, argb);
            }
        }
        
        simulation.setScreenContents(frame);
	}
}

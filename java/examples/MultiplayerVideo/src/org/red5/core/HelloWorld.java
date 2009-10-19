package org.red5.core;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.concurrent.Callable;
import java.util.logging.Level;

import javax.imageio.ImageIO;

import com.jme.image.Image;
import com.jme.renderer.OffscreenRenderer;
import com.jme.renderer.Renderer;
import com.jme.util.GameTaskQueue;
import com.jme.util.GameTaskQueueManager;
import com.jme.util.Timer;
import com.jme.util.geom.BufferUtils;
import com.jmex.game.StandardGame;
import com.jmex.game.state.GameStateManager;
import com.xuggle.mediatool.IMediaWriter;
import com.xuggle.mediatool.ToolFactory;
import com.xuggle.xuggler.ICodec;
import com.xuggle.xuggler.IContainer;
import com.xuggle.xuggler.IPixelFormat;
import com.xuggle.xuggler.IRational;
import com.xuggle.xuggler.IStream;
import com.xuggle.xuggler.IStreamCoder;

import static java.util.concurrent.TimeUnit.MILLISECONDS;
import static com.xuggle.xuggler.Global.DEFAULT_TIME_UNIT;

public class HelloWorld extends StandardGame {

	final long frameRate = DEFAULT_TIME_UNIT.convert(15, MILLISECONDS);
	
	private OffscreenRenderer osRenderer;
	
	private SimpleGameState gameState;
	
	private Timer timer = Timer.getTimer();
	
	private float acc = 0f;
	
	private long nextFrameTime = 0;
	
	private float framerate = 1 / 10;
	
	private IMediaWriter writer;
	
	private BufferedImage screenContents;
	
	public HelloWorld() {
		super("Test Headless", StandardGame.GameType.GRAPHICAL);
	}
	
	public void takeScreenShot(String filename) {
		Callable<?> exe = new Screenshot(display, filename);
        GameTaskQueueManager.getManager().getQueue(GameTaskQueue.RENDER).enqueue(exe);
	}
	
	public void grabScreenContents() {
		Callable<?> exe = new ScreenGrab(this, display.getRenderer());
        GameTaskQueueManager.getManager().getQueue(GameTaskQueue.RENDER).enqueue(exe);
	}
	
	protected void render(float interpolation) {
		super.render(interpolation);
		
		grabScreenContents();
		
		/*if (acc > framerate) {
			System.out.println(acc + " " + framerate);
			
	        
	        writer.encodeVideo(0, frame, nextFrameTime, 
	                DEFAULT_TIME_UNIT);
	        
	        nextFrameTime += interpolation;
			
			acc = 0.0f;
		}
		
		acc += interpolation;
	}*/
	}
	
	public BufferedImage getScreenContents() {
		return screenContents;
	}
	
	public void setScreenContents(BufferedImage screenContents) {
		this.screenContents = screenContents;
	}
	
}

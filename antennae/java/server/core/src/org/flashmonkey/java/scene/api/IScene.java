package org.flashmonkey.java.scene.api;

import java.util.List;

import org.flashmonkey.java.avatar.api.IAvatar;

public interface IScene {

	public IAvatar addChild(IAvatar child);
	
	public IAvatar removeChild(IAvatar child);
	
	public List<IAvatar> getChildren();
}

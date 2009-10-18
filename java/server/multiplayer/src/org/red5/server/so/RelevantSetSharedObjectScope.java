package org.red5.server.so;

import org.red5.server.api.IScope;
import org.red5.server.api.persistence.IPersistenceStore;

public class RelevantSetSharedObjectScope extends SharedObjectScope {

	public RelevantSetSharedObjectScope(IScope parent, String name, boolean persistent,
			IPersistenceStore store) {
		super(parent, name, persistent, store);

		// Create shared object wrapper around the attributes
		//String path = parent.getContextPath();
		//if ("".equals(path) || path.charAt(0) != '/') {
		//	path = '/' + path;
		//}
        // Load SO
        //so = (SharedObject) store.load(TYPE + path + '/' + name);
		// Create if it doesn't exist
        //if (so == null) {
			so = new RelevantSetSharedObject(attributes, name, path, persistent, store);
            // Save
			store.save(so);
		//} else {
            // Rename and set path
            so.setName(name);
			so.setPath(path);
		//}
	}
}

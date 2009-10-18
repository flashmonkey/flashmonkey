package org.flashmonkey.flash.core.command
{
	import org.flashmonkey.flash.utils.library.ExternalLibraryManager;
	import org.flashmonkey.flash.utils.library.LibraryManager;
	
	import flash.display.Loader;
	
	import org.springextensions.actionscript.mvcs.command.AbstractLoadCompleteCommand;
	
	public class SkinLoadCompleteCommand extends AbstractLoadCompleteCommand
	{
		override public function execute():void 
		{
			var loader:Loader = Loader(loadOperation.result);
			
			(LibraryManager.instance as ExternalLibraryManager).registerSkinFile(loader);
		}
	}
}
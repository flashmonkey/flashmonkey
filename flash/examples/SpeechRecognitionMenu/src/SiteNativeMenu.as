package
{
	/*import com.infrared5.sitebuilder.authoring.controller.SiteController;
	import com.infrared5.sitebuilder.authoring.editor.SiteMoccasinEditor;
	import com.joeberkovitz.moccasin.document.UndoHistory;
	import com.joeberkovitz.moccasin.editor.MoccasinEditor;
	import com.joeberkovitz.moccasin.event.ControllerEvent;
	import com.joeberkovitz.moccasin.event.SelectEvent;
	import com.joeberkovitz.moccasin.event.UndoEvent;*/
	
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import mx.controls.FlexNativeMenu;

	[Event(name="close", type="flash.events.Event")]
	public class SiteNativeMenu extends FlexNativeMenu
	{
		//private var _editor:SiteMoccasinEditor;
	    //public var appController:SiteController;
	    private var isWin:Boolean = false;
		private var isMac:Boolean = false;

		public function SiteNativeMenu()
		{ 
		
			super();
			
		}

        public function keyEquivalentModifiers(item:Object):Array
        {
        	isWin = (Capabilities.os.indexOf("Windows") >= 0);
            isMac = (Capabilities.os.indexOf("Mac OS") >= 0);
            
        	
            var result:Array = new Array();
            
            var keyEquivField:String = this.keyEquivalentField;
            var altKeyField:String;
            var ctrlKeyField:String;
            var shiftKeyField:String;
            if (item is XML)
            {
                altKeyField = "@altKey";
                ctrlKeyField = "@ctrlKey";
                shiftKeyField = "@shiftKey";
            }
            else if (item is Object)
            {
                altKeyField = "altKey";
                ctrlKeyField = "ctrlKey";
                shiftKeyField = "shiftKey";
            }
            
            if (item[keyEquivField] == null || item[keyEquivField].length == 0)
            {
                return result;
            }
            
            if (item[altKeyField] != null && item[altKeyField] == true)
            {
                if (isWin)
                {
                    result.push(Keyboard.ALTERNATE);
                }
            }
         
            if (item[ctrlKeyField] != null && item[ctrlKeyField] == true)
            {
            	
                if (isWin)
                {
                    result.push(Keyboard.CONTROL);
                }
                else if (isMac)
                {
                	
                    result.push(Keyboard.COMMAND);
                }
            }
            
            if (item[shiftKeyField] != null && item[shiftKeyField] == true)
            {
                result.push(Keyboard.SHIFT);
            }
            
            return result;
        }

		
		 protected function getMenuItem(menuName:String, itemName:String):NativeMenuItem
        {
        	
            for each (var child:NativeMenuItem in this.nativeMenu.items)
            {
            	
                if (child.data.name == menuName)
                {
                	
                    for each (var item:NativeMenuItem in child.submenu.items)
                    {
                    	                    		
                        if (item.data && item.data.name == itemName)
                        {
                            return item as NativeMenuItem;
                        } 
                    }
                } 
            }
            return null;
        }
	    
	    protected function setItemEnabled(menuName:String, itemName:String, enabled:Boolean):void
        {
            getMenuItem(menuName, itemName).enabled = enabled;
        }
        
        protected function setItemToggled(menuName:String, itemName:String, toggled:Boolean):void
        {
            getMenuItem(menuName, itemName).checked = toggled;
        }
        
        protected function setItemLabel(menuName:String, itemName:String, label:String):void
        {
            getMenuItem(menuName, itemName).label = label;
        }
	    
	    
	   /* [Bindable]
        public function get editor():MoccasinEditor
        {
            return _editor;
        }*/
        
        /*public function set editor(e:MoccasinEditor):void
        {
            if (editor != null)
            {
                _editor.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, handleEditorPropertyChange);
                _editor.controller.removeEventListener(ControllerEvent.DOCUMENT_CHANGE, handleDocumentChange);
                _editor.controller.removeEventListener(SelectEvent.CHANGE_SELECTION, handleChangeSelection);
            }
            _editor = e as SiteMoccasinEditor;
            if (editor != null)
            {
                _editor.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, handleEditorPropertyChange);
                _editor.controller.addEventListener(ControllerEvent.DOCUMENT_CHANGE, handleDocumentChange);
                _editor.controller.addEventListener(SelectEvent.CHANGE_SELECTION, handleChangeSelection);
            }
            if (editor.controller.document != null)
            {
                handleDocumentChange(null);
            }
            
            appController = _editor.controller as SiteController;
            
            updateMenuItems();
        }
        
        protected function handleEditorPropertyChange(e:PropertyChangeEvent):void
        {
           //trace("got a property change", e.property);
            if (e.property == "selectedObject")
            {
                setItemEnabled("edit", "link", e.newValue ? true : false);
                updateMenuItems();
            }
        }
        
        private function handleUndoChange(e:UndoEvent):void
        {
            updateUndoItems();
        }
        
         private function updateUndoItems():void
        {
        	
            var history:UndoHistory = _editor.controller.document.undoHistory;
            setItemEnabled("edit", "undo", history.canUndo);
            setItemLabel("edit", "undo", "Undo " + history.undoName);
            setItemEnabled("edit", "redo", history.canRedo);
            setItemLabel("edit", "redo", "Redo " + history.redoName); 
        }
        
         private function handleDocumentChange(e:ControllerEvent):void
        {
        	
            _editor.controller.document.undoHistory.addEventListener(UndoEvent.UNDO_HISTORY_CHANGE, handleUndoChange);
            updateMenuItems();
        }
        
        protected function updateMenuItems():void
        {
        	
//        	setItemEnabled("edit", "link", false);
            if (editor.controller.document != null)
            {
                updateUndoItems();
            }
            
        }
       
        
        protected function handleChangeSelection(e:SelectEvent):void
        {
            // override to provide context sensitive menu
            
            
            
        }*/
	    
	    public function handleCommand(commandName:String):void
        {
        	trace("Command handling");
            switch(commandName)
            {
            case "new":
            trace("NEW Clicked");
            	//_editor.selectNewSiteDirectory();
            	break;
            case "open":
                //_editor.selectSiteDirectory();
                break;
            case "close":
            	//_editor.closeSite();
            	break;
            case "link":
                //_editor.selectLinkPath();
                break;
            case "preview":
               // _editor.previewSite();
                break;
            case "saveTemplate":
               // _editor.saveTemplate();
                break;
            case "loadTemplate":
               // _editor.loadTemplate();
                break;
            case "publishSite":
               // _editor.publishSite();
                break;
            case "ftpSite":
            	//_editor.addChildFTP();
            	break;
            	
            case "bringToFront":
           		//appController.bringToFront();
                break;
            case "sendToBack":
            	//appController.sendToBack();
            	break;
            case "ftpSettings":
            	//_editor.showFTPSettings();
            	break;
            	
            case "save":
               // _editor.saveDocument();
                break;
                
            case "saveas":
            	//_editor.saveDocumentAs();
            	break;
                
            case "print":
                //_editor.printDocument();
                break;
                
            case "undo":
                //_editor.controller.undo();
                break;
                
            case "redo":
                //_editor.controller.redo();
                break;
                
            case "selectall":
            	//appController.selectAll();
            	break;
                
            case "cut":
                //_editor.controller.document.undoHistory.openGroup("Cut");
                //_editor.controller.cutClipboard();
                break;
                
            case "copy":
	            //_editor.controller.copyClipboard();	            
                break;
                
            case "paste":
               // _editor.controller.document.undoHistory.openGroup("Paste");
                //_editor.controller.pasteClipboard();
             	
                break;
                
            case "delete":
                //_editor.controller.document.undoHistory.openGroup("Delete");
                //_editor.controller.removeSelection();
                break;
          
          	case "exit":          	
          		dispatchEvent(new Event(Event.CLOSE));
          		break;
          		
          	case "about":
          		//_editor.showAbout();
          		break;
          		
          	case "helpcontents":
          		//_editor.showHelp();
          		break;
          		
          	case "import":
          		//_editor.showComponentManager();
          		break;
          		
            default:      
                break;//super.handleCommand(commandName);
            }
        }
		
	}
}
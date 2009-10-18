package org.flashmonkey.flash.utils.xml
{	
	import flash.errors.IllegalOperationError;
		
	public class AbstractNodeParser implements INodeParser
	{
		protected var xmlDefinitionsParser:IXMLDefinitionsParser;
		
		protected var nodeNames:Array = [];
		
		public function AbstractNodeParser(xmlDefinitionsParser:IXMLDefinitionsParser, nodeName:String)
		{
			this.xmlDefinitionsParser = xmlDefinitionsParser;
			this.nodeNames.push(nodeName);
		}

	    public function addNodeNameAlias(alias:String):void {
	      nodeNames.push(alias);
	    }

	    public function canParse(node:XML):Boolean {
	      return (nodeNames.indexOf(node.name().localName.toLowerCase()) != -1);
	    }

	    public function getNodeNames():Array {
	      return this.nodeNames;
	    }

	    public function parse(node:XML):Object {
	      throw new IllegalOperationError("parse() is abstract");
	    }
	}
}
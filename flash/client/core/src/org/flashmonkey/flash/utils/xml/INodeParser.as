package org.flashmonkey.flash.utils.xml
{	
	public interface INodeParser
	{
		/**
	     * Determines if the given node can be parsed.
	     *
	     * @param node  The node to be checked.
	     *
	     * @return true if this implementation can parse the given node.
	     */
	    function canParse(node:XML):Boolean;
	
	    /**
	     * Will parse the given node. The type of the result depends
	     * on the implementation of the node parser.
	     *
	     * @param node  The node that will be parsed
	     *
	     * @return the parsed node
	     */
	    function parse(node:XML):Object;
	
	    /**
	     * Will add an alias that this node parser will react upon. It has direct influence
	     * on the result of the canParse method.
	     *
	     * @param alias    Alternative nodename that can be parsed by this parser
	     *
	     * @see #canParse
	     */
	    function addNodeNameAlias(alias:String):void;
	
	    /**
	     * Return an array containing the node names this parser can parse
	     */
	    function getNodeNames():Array;
	}
}
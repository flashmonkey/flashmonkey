package org.flashmonkey.flash.utils
{
	import mx.collections.ArrayCollection;
	
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;
	import org.springextensions.actionscript.mvcs.service.operation.IOperation;
	import org.springextensions.actionscript.mvcs.service.operation.event.AsyncOperationErrorEvent;
	import org.springextensions.actionscript.mvcs.service.operation.event.AsyncOperationResultEvent;
	import org.springextensions.actionscript.mvcs.service.operation.events.OperationProgressEvent;
	import org.springextensions.actionscript.mvcs.service.operation.events.OperationSequenceEvent;
	import org.springextensions.actionscript.mvcs.service.operation.events.ProgressSourceEvent;
   
    public class AsyncOperationSequence extends AbstractOperation
    {
        public var failOnFault:Boolean = true;
        public var currentOperation:IOperation;
       
        protected var operations:Array = [];
       
        protected var completeOperations:Array = [];
       
        private var _opCollection:ArrayCollection;
        
        private var _autoReset:Boolean = false;
       
        override public function get progress():Number
        {
            var p:Number = 0;
           
            for each (var operation:IOperation in _opCollection)
            {
                p += operation.progress;
            }
           
            return p / _opCollection.length;
        }
       
        public function AsyncOperationSequence(autoReset:Boolean = false)
        {
            super();
            
            _autoReset = autoReset;
        }
       
        override public function execute():void {
            dispatchEvent(new ProgressSourceEvent(ProgressSourceEvent.PROGRESS_START, this, ""));
            executeNextCommand();
        }       
       
        public function executeNextCommand():void
        {
            if (operations.length > 0) {
                var firstOperation:IOperation = IOperation(operations.shift());
                if (!firstOperation.canAct())
                {
                    operations.push(firstOperation);
                    execute();
                }
                else
                {
                    executeOperation(firstOperation);
                }
            }
            else
            {
              	if (_autoReset)
            	{
            		operations = completeOperations.concat();
            		completeOperations = [];
            	}
            	
                dispatchResult(this);
            }
        }
       
        public function addOperation(operation:IOperation):void {
            if (operation != null)
            {
                operations.push(operation);
                _opCollection = new ArrayCollection(operations);
            }
        }
       
        protected function executeOperation(operation:IOperation):void {
            operation.addResultListener(onOperationResult);
            operation.addErrorListener(onOperationFault);
            operation.addProgressListener(onOperationProgress);
            currentOperation = operation;
            dispatchEvent(new OperationSequenceEvent(OperationSequenceEvent.EXECUTE_OPERATION, operation));
            operation.execute();
        }
       
        private function onOperationResult(event:AsyncOperationResultEvent):void {
            completeOperations.push(currentOperation);
            execute();
        }
       
        private function onOperationProgress(event:OperationProgressEvent):void
        {
            dispatchEvent(new OperationProgressEvent(progress));
        }
       
        private function onOperationFault(event:AsyncOperationErrorEvent):void {
            if (failOnFault) {
                dispatchEvent(new OperationSequenceEvent(OperationSequenceEvent.ERROR, currentOperation));
            }
            else {
                execute();
            }
        }
    }
}
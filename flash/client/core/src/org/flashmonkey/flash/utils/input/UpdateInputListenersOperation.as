package org.flashmonkey.flash.utils.input
{
	import org.springextensions.actionscript.mvcs.service.operation.AbstractOperation;

	public class UpdateInputListenersOperation extends AbstractOperation
	{
		private var _userInput:IUserInput;
		
		public function UpdateInputListenersOperation(userInput:IUserInput)
		{
			super(this);
			
			_userInput = userInput;
		}
		
		public override function execute():void
		{
			//_userInput.updateListeners();
			
			dispatchResult(this);
		}
	}
}
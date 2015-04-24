library command_result;

class CommandResult
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final bool isSucceeded;
	final String message;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	CommandResult(this.isSucceeded, [this.message]);
}
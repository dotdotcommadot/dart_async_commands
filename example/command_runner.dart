import 'dart:async';
import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';

class LoginCommand extends AsyncCommand
{
	LoginCommand() : super("LoginCommand");
	
	Future<CommandResult> execute()
	{
		var timer = new Timer(new Duration(seconds: 1), (){
  		var now = new DateTime.now();
  		print(now.toString());
  		complete(true);
  	});
		
		return future;
	}
}

void main()
{

	// Trigger single command
	new LoginCommand().execute()
		.then((result) => print("End of Single Command"));
	
	
	// Trigger Chain of Commands: When Order is Relevant
	new LoginCommand().execute()
		.then((result) => result.isSucceeded? new LoginCommand().execute() : result)
		.then((result) => result.isSucceeded? new LoginCommand().execute() : result)
		.then((result) => result.isSucceeded? new LoginCommand().execute() : result)
		.then((result) => print("End of Chain of Commands: When Order is Relevant"));

	
	// Trigger Chain of Commands: When Order is Irrelevant
	List<Future> chain = [new LoginCommand().execute(), 
	                      new LoginCommand().execute(), 
	                      new LoginCommand().execute()];
	
	Future.wait(chain)
		.then( (List<CommandResult> results) 
	{
		results.forEach((CommandResult result) => print(result.isSucceeded.toString()));
		print("End of Chain of Commands: When Order is Irrelevant");
	});
}

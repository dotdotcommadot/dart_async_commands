import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';
import 'login_command.dart';
import 'print_hello_world_hook.dart';
import 'blocking_guard.dart';
import 'non_blocking_guard.dart';

void main()
{
	/*// Trigger Chain of Commands: When Order is Relevant
	new LoginCommand().execute()
		.then((result) => result.isSucceeded? new LoginCommand().execute() : result)
		.then((result) => result.isSucceeded? new LoginCommand().execute() : result)
		.then((result) => result.isSucceeded? new LoginCommand().execute() : result)
		.then((result) => print("End of Chain of Commands: When Order is Relevant"));

	
	// Trigger Chain of Commands: When Order is Irrelevant
	// NOTE: the body of the execution method will be run synchronously.
	// Only the completing of the commands is asynchronously.
	List<Future> chain = [new LoginCommand().execute(), 
	                      new LoginCommand().execute(), 
	                      new LoginCommand().execute()];
	
	Future.wait(chain)
		.then( (List<CommandResult> results) 
	{
		results.forEach((CommandResult result) => print(result.isSucceeded.toString()));
		print("End of Chain of Commands: When Order is Irrelevant");
	});*/


	// Trigger Chain of Commands: When Order is Irrelevant
	// NOTE: the body of the execution method will be run synchronously.
	// Only the completing of the commands is asynchronously.
	CommandRunner runner = new CommandRunner();

	runner.addAll([
    new LoginCommand()
      .withHooks([new PrintHelloWorldHook()])
      .withGuards([new NonBlockingGuard()]),

     new LoginCommand()
      .withHooks([new PrintHelloWorldHook()])
      .withGuards([new NonBlockingGuard()]),

     new LoginCommand()
      .withHooks([new PrintHelloWorldHook()])
      .withGuards([new NonBlockingGuard()])
  ]);

	runner.run()
		.then((List<CommandResult> results) => results.where((R) => !R.isSucceeded).forEach((R) => print(R.message)));
}

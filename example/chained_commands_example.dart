import 'commands/login_command.dart';

void main()
{
  // 1: Basic Example of Commands Chained by the Futures '.then' API
	runBasicExample();
}

void runBasicExample()
{
	new LoginCommand().run()
		.then((result) => result.isSucceeded? new LoginCommand().run() : result)
		.then((result) => result.isSucceeded? new LoginCommand().run() : result)
		.then((result) => result.isSucceeded? new LoginCommand().run() : result)
		.then((result) => print("End of Example 1"));
}

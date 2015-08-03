import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';
import 'commands/login_command.dart';
import 'hooks/print_hello_world_hook.dart';
import 'guards/check_one_and_one_is_two_guard.dart';
import 'guards/check_one_and_one_is_three_guard.dart';

void main()
{
	// 1. Basic Example
	runBasicExample();

	// 2. Example with Hook and Guard
	runExampleWithHookAndGuard();

	// 3. Example with Hook and Blocking Guard
	runExampleWithHookAndBlockingGuard();

	// 4. Example with For loop
	runExampleWithForLoop();
}

void runBasicExample()
{
	CommandRunner runner = new CommandRunner();

	runner.add(new LoginCommand());

	runner.run()
		.then((List<CommandResult> results) => results.where((R) => !R.isSucceeded).forEach((R) => print(R.message)));
}

void runExampleWithHookAndGuard()
{
	CommandRunner runner = new CommandRunner();

	runner.addAll([
		new LoginCommand()
			.withHooks([new PrintHelloWorldHook()])
			.withGuards([new CheckOneAndOneIsTwoGuard()]),

		new LoginCommand()
			.withHooks([new PrintHelloWorldHook()])
			.withGuards([new CheckOneAndOneIsTwoGuard()])
	]);

	runner.run()
		.then((List<CommandResult> results) => results.where((R) => !R.isSucceeded).forEach((R) => print(R.message)));
}

void runExampleWithHookAndBlockingGuard()
{
	CommandRunner runner = new CommandRunner();

	runner.addAll([
		// non blocking
		new LoginCommand()
			.withHooks([new PrintHelloWorldHook()])
			.withGuards([new CheckOneAndOneIsTwoGuard()]),

		// blocking
		new LoginCommand()
			.withHooks([new PrintHelloWorldHook()])
			.withGuards([new CheckOneAndOneIsThreeGuard()]),

		// non blocking
		new LoginCommand()
			.withHooks([new PrintHelloWorldHook()])
			.withGuards([new CheckOneAndOneIsTwoGuard()])
	]);

	runner.run()
		.then((List<CommandResult> results) => results.where((R) => !R.isSucceeded).forEach((R) => print(R.message)));
}

void runExampleWithForLoop()
{
	CommandRunner runner = new CommandRunner();

	for (int i = 0; i < 3; i++)
	{
		runner.add(
			new LoginCommand()
			.withHooks([new PrintHelloWorldHook()])
			.withGuards([new CheckOneAndOneIsTwoGuard()])
		);
	}

	runner.run()
		.then((List<CommandResult> results) => results.where((R) => !R.isSucceeded).forEach((R) => print(R.message)));
}

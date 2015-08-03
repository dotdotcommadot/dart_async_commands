import 'commands/login_command.dart';
import 'hooks/print_hello_world_hook.dart';
import 'guards/check_one_and_one_is_two_guard.dart';
import 'guards/check_one_and_one_is_three_guard.dart';

void main()
{
  // 1: Basic example
  runBasicExample();

  // 1: Example With Hook and Guard That Doesn't Prevent Execution
  runExampleWithHookAndGuard();

  // 1: Example With Hook and Guard That Prevents Execution
  runExampleWithHookAndBlockingGuard();
}

void runBasicExample()
{
  new LoginCommand().run()
    .then((result) => print("End of Example 1"));
}

void runExampleWithHookAndGuard()
{
  new LoginCommand()
    .withHooks([new PrintHelloWorldHook()])
    .withGuards([new CheckOneAndOneIsTwoGuard()])
    .run()
    .then((result) => print("End of Example 2"));
}

void runExampleWithHookAndBlockingGuard()
{
  new LoginCommand()
    .withHooks([new PrintHelloWorldHook()])
    .withGuards([new CheckOneAndOneIsThreeGuard()])
    .run()
    .then((result) => print("End of Example 3: ${result.message}"));
}

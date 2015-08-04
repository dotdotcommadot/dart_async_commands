part of async_commands_test_suite;

class TestCommandA extends AsyncCommand
{
  final bool shouldSucceed;
  final String message;

  TestCommandA(this.shouldSucceed, [this.message]) : super('TestCommandA');

  @override
  Future<CommandResult> execute()
  {
    complete(shouldSucceed, message);

    return future;
  }
}
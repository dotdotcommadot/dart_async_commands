part of async_commands_test_suite;

class IncrementIterationsHook extends Hook
{
  @override
  Future execute()
  {
    iterations += 1;

    complete();

    return future;
  }
}
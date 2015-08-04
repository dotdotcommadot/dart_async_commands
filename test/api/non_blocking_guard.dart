part of async_commands_test_suite;

class NonBlockingGuard extends Guard
{
  @override
  bool execute()
  {
    return true;
  }
}
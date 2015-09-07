part of async_commands_test_suite;

class BlockingGuard extends Guard
{
  @override
  bool execute()
  {
    reasonOfFailure = "I'm supposed to block things";
    return false;
  }
}
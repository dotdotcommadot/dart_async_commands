part of async_commands_test_suite;

HookTest()
{
  setUp(()
  {
    iterations = 0;
  });

  test('Adding Hook to Command Should Execute Hook', ()
  {
    new TestCommandA(true)
    .withHooks([new IncrementIterationsHook()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(true));
      expect(commandResult.message, isNull);
      expect(iterations, equals(1));
    });
  });

  test('Adding Multiple Hooks to Command Should Execute Multiple Hook', ()
  {
    new TestCommandA(true)
    .withHooks([new IncrementIterationsHook(), new IncrementIterationsHook()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(true));
      expect(commandResult.message, isNull);
      expect(iterations, equals(2));
    });
  });

  test('Adding Multiple Hooks to Command Should Execute Multiple Hook', ()
  {
    new TestCommandA(true)
    .withHooks([new IncrementIterationsHook(), new IncrementIterationsHook()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(true));
      expect(commandResult.message, isNull);
      expect(iterations, equals(2));
    });
  });
}
part of async_commands_test_suite;

GuardTest()
{
  setUp(()
  {
    iterations = 0;
  });

  test('Adding Non Blocking Guard To Command Should Allow Command To Execute', ()
  {
    new TestCommandA(true)
    .withGuards([new NonBlockingGuard()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(true));
      expect(commandResult.message, isNull);
    });
  });

  test('Adding Blocking Guard To Command Should Prevent Command From Executing', ()
  {
    new TestCommandA(true)
    .withGuards([new BlockingGuard()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(false));
      expect(commandResult.message, isNotNull);
    });
  });

  test('Adding Non Blocking Guard To Command Should Allow Hook To Execute', ()
  {
    new TestCommandA(true)
    .withGuards([new NonBlockingGuard()])
    .withHooks([new IncrementIterationsHook()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(true));
      expect(commandResult.message, isNull);
      expect(iterations, equals(1));
    });
  });

  test('Adding Blocking Guard To Command Should Prevent Hook From Executing', ()
  {
    new TestCommandA(true)
    .withGuards([new BlockingGuard()])
    .withHooks([new IncrementIterationsHook()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(false));
      expect(commandResult.message, isNotNull);
      expect(iterations, equals(0));
    });
  });

  test('Adding Blocking Guard To Command Should Interrupt Command Runner From Executing', ()
  {
    new CommandRunner()
      ..addAll([
        new TestCommandA(true)
          .withGuards([new BlockingGuard()]),
        new TestCommandA(true)
          .withGuards([new NonBlockingGuard()])])
      ..run()
    .then((List<CommandResult> commandResults)
    {
      expect(commandResults.length, equals(1));

      commandResults.forEach((CommandResult commandResult)
      {
        expect(commandResult.isSucceeded, equals(false));
        expect(commandResult.message, isNotNull);
      });
    });
  });

  test('Exiting Blocking Guard With reasonOfFailure Should Return reasonOfFailure', ()
  {
    new TestCommandA(true)
    .withGuards([new BlockingGuard()])
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(false));
      expect(commandResult.message, equals("I'm supposed to block things"));
    });
  });
}
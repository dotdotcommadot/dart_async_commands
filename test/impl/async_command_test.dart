part of async_commands_test_suite;

AsyncCommandTest()
{
  test('Running Command Should Return Result', ()
  {
    new TestCommandA(true)
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(true));
      expect(commandResult.message, isNull);
    });
  });

  test('Running Failed Command Should Return Failed Result', ()
  {
    new TestCommandA(false)
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(false));
      expect(commandResult.message, isNull);
    });
  });

  test('Completing Command With Message Should Return Message in Result', ()
  {
    new TestCommandA(false, "Command Failed")
    .run()
    .then((CommandResult commandResult) {
      expect(commandResult.isSucceeded, equals(false));
      expect(commandResult.message, isNotNull);
    });
  });
}
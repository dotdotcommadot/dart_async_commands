part of async_commands_test_suite;

CommandRunnerTest()
{
  test('Running One Command Should Return One Result', ()
  {
    new CommandRunner()
      ..add(new TestCommandA(true))
      ..run()
      .then((List<CommandResult> commandResults)
      {
        expect(commandResults.length, equals(1));

        commandResults.forEach((CommandResult commandResult)
        {
          expect(commandResult.isSucceeded, equals(true));
          expect(commandResult.message, isNull);
        });
      });
  });

  test('Running Two Commands With Add Method Should Return Two Results', ()
  {
    new CommandRunner()
      ..add(new TestCommandA(true))
      ..add(new TestCommandA(true))
      ..run()
      .then((List<CommandResult> commandResults)
      {
        expect(commandResults.length, equals(2));

        commandResults.forEach((CommandResult commandResult)
        {
          expect(commandResult.isSucceeded, equals(true));
          expect(commandResult.message, isNull);
        });
      });
  });

  test('Running Two Commands With AddAll Method Should Return Two Results', ()
  {
    new CommandRunner()
      ..addAll([new TestCommandA(true), new TestCommandA(true)])
      ..run()
      .then((List<CommandResult> commandResults)
      {
        expect(commandResults.length, equals(2));

        commandResults.forEach((CommandResult commandResult)
        {
          expect(commandResult.isSucceeded, equals(true));
          expect(commandResult.message, isNull);
        });
      });
  });

  test('Running Failing Command Should Block Execution', ()
  {
    new CommandRunner()
      ..addAll([new TestCommandA(false), new TestCommandA(true)])
      ..run()
      .then((List<CommandResult> commandResults)
      {
        expect(commandResults.length, equals(1));

        commandResults.forEach((CommandResult commandResult)
        {
          expect(commandResult.isSucceeded, equals(false));
          expect(commandResult.message, isNull);
        });
      });
  });

  test('Running Failing Command With IgnoreFailedStatus Should Not Block Execution', ()
  {
    new CommandRunner(ignoreFailedStatus: true)
      ..addAll([new TestCommandA(false), new TestCommandA(true)])
      ..run()
      .then((List<CommandResult> commandResults)
      {
        expect(commandResults.length, equals(2));

        expect(commandResults.first.isSucceeded, false);
        expect(commandResults.last.isSucceeded, true);
      });
  });

  test('Completing Command With Message Should Return Message in Result', ()
  {
    new CommandRunner()
      ..addAll([new TestCommandA(true, "succeeded with message"), new TestCommandA(false, "failed with message")])
      ..run()
      .then((List<CommandResult> commandResults)
      {
        expect(commandResults.length, equals(2));

        commandResults.forEach((CommandResult commandResult)
        {
          expect(commandResult.message, isNotNull);
        });
      });
  });
}
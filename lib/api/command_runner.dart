part of async_commands;

class CommandRunner
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  AsyncCommand runningCommand;

  bool get isRunning => runningCommand != null;

  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final Logger _log                   = new Logger('CommandRunner');

  final List<AsyncCommand> _mappings  = [];

  final List<CommandResult> _results  = [];

  final Completer _completer          = new Completer();

  final ignoreFailedStatus;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  CommandRunner({this.ignoreFailedStatus: false});

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void add(AsyncCommand command)
  {
    if (!isRunning)
      _mappings.add(command);
    else
      throw new ConcurrentModificationError(command);
  }

  void addAll(List<AsyncCommand> commands)
  {
    if (!isRunning)
      _mappings.addAll(commands);
    else
      throw new ConcurrentModificationError();
  }

  Future<List<CommandResult>> run()
  {
    _execute();

    return _completer.future;
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void _execute()
  {
    runningCommand = _mappings.removeAt(0);

    runningCommand.run()
      .then(_onExecuted);
  }

  void _onExecuted(CommandResult result)
  {
    _results.add(result);

    if (!result.isSucceeded && !ignoreFailedStatus)
    {
      _close("Execution stopped");
    }
    else
    {
      if (_mappings.length > 0)
        _execute();
      else
        _close("Execution completed succesfully");
    }
  }

  void _close(String message)
  {
    _log.info(message);
    _completer.complete(_results);
  }
}
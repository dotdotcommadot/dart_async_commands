library command_runner;

import 'dart:async';
import 'package:logging/logging.dart';
import 'package:dotdotcommadot_commands/impl/command_result.dart';
import 'package:dotdotcommadot_commands/api/async_command.dart';

class CommandRunner
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  Logger _log                   = new Logger('CommandRunner');
  List<AsyncCommand> _mappings  = [];
  Completer _completer          = new Completer();
  List<CommandResult> _results  = [];
  bool _isRunning               = false;
  AsyncCommand _currentCommand;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  CommandRunner();

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void add(AsyncCommand command)
  {
    if (!_isRunning)
      _mappings.add(command);
    else
      throw new ConcurrentModificationError(command);
  }

  void addAll(List<AsyncCommand> commands)
  {
    if (!_isRunning)
      _mappings.addAll(commands);
    else
      throw new ConcurrentModificationError(command);
  }

  Future<List<CommandResult>> run()
  {
    _isRunning = true;
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
    _currentCommand = _mappings.removeAt(0);

    _currentCommand.execute()
      .then(_onExecuted);
  }

  void _onExecuted(CommandResult result)
  {
    _results.add(result);

    if (!result.isSucceeded)
    {
      _close("Execution stopped due to error");
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
    _isRunning = false;

    _log.info(message);
    _completer.complete(_results);
  }
}
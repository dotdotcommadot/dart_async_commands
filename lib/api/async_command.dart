library async_command;

import 'dart:async';
import 'package:logging/logging.dart';
import 'package:dotdotcommadot_commands/impl/command_result.dart';

abstract class AsyncCommand
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final String commandName;
	
	Logger log;
	
	final Completer _completer = new Completer();
	
	Future<CommandResult> get future => _completer.future;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	AsyncCommand(this.commandName)
	{
		log = new Logger(commandName);
	}
	
	
  //-----------------------------------
  //
  // Override Methods
  //
  //-----------------------------------

	void complete(bool isSucceeded, [String message, Error error, StackTrace stackTrace]) 
	{
		if (isSucceeded)
			log.info('Command completed succesfully');
		else if(!isSucceeded && error == null)
			log.severe(message);
		else if(!isSucceeded && error != null)
			log.shout(message, error, stackTrace);
		
		_completer.complete(new CommandResult(isSucceeded, message));
	}

	Future<CommandResult> execute();
}
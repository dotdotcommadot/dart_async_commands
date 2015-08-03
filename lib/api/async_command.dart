part of dotdotcommadot_commands;

abstract class AsyncCommand
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

	//-----------------------------------
	// commandName
	//-----------------------------------

	final String commandName;

	//-----------------------------------
	// log
	//-----------------------------------
	
	Logger log;

	//-----------------------------------
	// future
	//-----------------------------------

	Future<CommandResult> get future => _completer.future;

  //-----------------------------------
  // hooks
  //-----------------------------------

  List<Hook> hooks;

  //-----------------------------------
  // hasHooks
  //-----------------------------------

  bool get hasHooks => hooks != null && hooks.length > 0;

  //-----------------------------------
  // guards
  //-----------------------------------

  List<Guard> guards;

  //-----------------------------------
  // hasGuards
  //-----------------------------------

  bool get hasGuards => guards != null && guards.length > 0;

	//-----------------------------------
	//
	// Private Properties
	//
	//-----------------------------------

	//-----------------------------------
	// _completer
	//-----------------------------------
	
	final Completer _completer = new Completer();
	
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
  // Public Methods
  //
  //-----------------------------------

	//-----------------------------------
	// complete()
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

	//-----------------------------------
	// addHooks()
	//-----------------------------------

	AsyncCommand withHooks(List<Hook> hooks)
	{
		this.hooks = hooks;
    return this;
	}

	//-----------------------------------
	// addGuards()
	//-----------------------------------

  AsyncCommand withGuards(List<Guard> guards)
	{
		this.guards = guards;
    return this;
	}

	//-----------------------------------
	// run()
	//-----------------------------------

	Future<CommandResult> run()
	{
    Completer C = new Completer();

		if (_checkGuards())
		{
      _runHooks()
        .then((_) => execute())
        .then((CommandResult result) => C.complete(result));
		}
		else
		{
      C.complete(new CommandResult(false, 'Running of $commandName was prevented by guard'));
		}

    return C.future;
  }

  Future _runHooks()
  {
    if (hasHooks)
    {
      HookRunner hookRunner = new HookRunner(hooks);
      return hookRunner.run();
    }
    else
    {

      return new Future.value();
    }
  }

  bool _checkGuards()
  {
    bool canContinue = true;

    if (hasGuards)
    {
      for (final Guard guard in guards)
      {
        canContinue = guard.execute();

        if (!canContinue)
          break;
      };
    }

    return canContinue;
  }

	//-----------------------------------
	// complete()
	//-----------------------------------

	Future<CommandResult> execute();
}
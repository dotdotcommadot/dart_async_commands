part of async_commands;

class HookRunner
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  final List<Hook> hooks;

  Hook runningHook;

  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final Completer _completer = new Completer();

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  HookRunner(this.hooks);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  Future run()
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
    runningHook = hooks.removeAt(0);

    runningHook.execute()
      .then(_onExecuted);
  }

  void _onExecuted(dynamic value)
  {
    if (hooks.length > 0)
      _execute();
    else
      _completer.complete();
  }
}
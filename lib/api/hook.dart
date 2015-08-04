part of async_commands;

abstract class Hook
{
  final Completer _completer = new Completer();

  Future get future => _completer.future;

  void complete()
  {
    _completer.complete();
  }

  Future execute();
}
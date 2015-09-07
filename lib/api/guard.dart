part of async_commands;

abstract class Guard
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  String reasonOfFailure;

  //-----------------------------------
  //
  // Override Methods
  //
  //-----------------------------------

  bool execute();
}
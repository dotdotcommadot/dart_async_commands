library login_command;

import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';
import 'dart:async';

class LoginCommand extends AsyncCommand
{
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  LoginCommand() : super('LoginCommand');

  //---------------------------------
  //
  // Override Methods
  //
  //---------------------------------

  @override
  Future<CommandResult> execute()
  {
    new Timer(new Duration(seconds: 1), ()
    {
      print('... running LoginCommand ...');
      complete(true);
    });

    return future;
  }
}
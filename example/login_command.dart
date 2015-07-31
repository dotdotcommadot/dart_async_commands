library login_command;

import 'dart:async';
import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';

class LoginCommand extends AsyncCommand
{
  LoginCommand() : super("LoginCommand");

  Future<CommandResult> execute()
  {
    new Timer(new Duration(seconds: 1), (){
      print('running LoginCommand');
      complete(true);
    });

    return future;
  }
}
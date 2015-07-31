import 'dart:async';
import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';
import 'login_command.dart';

void main()
{
  // Trigger single command
  new LoginCommand().execute()
    .then((result) => print("End of Single Command"));
}

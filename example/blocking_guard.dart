library blocking_guard;

import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';

class BlockingGuard extends Guard
{
  @override
  bool execute()
  {
    return (1 + 1 == 3);
  }
}
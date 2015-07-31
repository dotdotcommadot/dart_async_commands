library non_blocking_guard;

import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';

class NonBlockingGuard extends Guard
{
  @override
  bool execute()
  {
    return (1 + 1 == 2);
  }
}
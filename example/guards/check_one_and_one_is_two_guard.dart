library check_one_and_one_is_two_guard;

import 'package:async_commands/async_commands.dart';

class CheckOneAndOneIsTwoGuard extends Guard
{
  @override
  bool execute()
  {
    return (1 + 1 == 2);
  }
}
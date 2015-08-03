library check_one_and_one_is_three_guard;

import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';

class CheckOneAndOneIsThreeGuard extends Guard
{
  @override
  bool execute()
  {
    return (1 + 1 == 3);
  }
}
library print_hello_world_hook;

import 'dart:async';
import 'package:async_commands/async_commands.dart';

class PrintHelloWorldHook extends Hook
{
  @override
  Future execute()
  {
    print('Hello World');

    complete();
    return future;
  }
}
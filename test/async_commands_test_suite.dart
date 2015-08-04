library async_commands_test_suite;

import 'dart:async';
import 'package:test/test.dart';
import 'package:dotdotcommadot_commands/dotdotcommadot_commands.dart';

part 'api/blocking_guard.dart';
part 'api/increment_iterations_hook.dart';
part 'api/non_blocking_guard.dart';
part 'api/test_command_a.dart';
part 'impl/async_command_test.dart';
part 'impl/command_runner_test.dart';
part 'impl/guard_test.dart';
part 'impl/hook_test.dart';

// Globally used properties
int iterations = 0;

main()
{
  group("Async Command Test: ", AsyncCommandTest);
  group("Command Runner Test: ", CommandRunnerTest);
  group("Hook Test: ", HookTest);
  group("Guard Test: ", GuardTest);
}
// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  static m0(title) => "Task \"${title}\" deleted";

  static m1(title) => "Task \"${title}\" done";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "SAVE" : MessageLookupByLibrary.simpleMessage("SAVE"),
    "UNDO" : MessageLookupByLibrary.simpleMessage("UNDO"),
    "addTask" : MessageLookupByLibrary.simpleMessage("Add a new task"),
    "snackTaskDeleted" : m0,
    "snackTaskDone" : m1
  };
}

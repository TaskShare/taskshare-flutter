import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

String createLevelSuffix(Level level) {
  switch (level) {
    case Level.FINEST:
      return '👣';
    case Level.FINER:
      return '👀';
    case Level.FINE:
      return '🎾';
    case Level.CONFIG:
      return '🐶';
    case Level.INFO:
      return '👻';
    case Level.WARNING:
      return '⚠️';
    case Level.SEVERE:
      return '‼️';
    case Level.SHOUT:
      return '😡';
  }
}

class AppLogger {
  static configure() {
    recordStackTraceAtLevel = Level.ALL;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec) {
      final frames = Trace.from(rec.stackTrace).frames;
      final Frame frame = () {
        if (frames.length >= 3) {
          return frames[2];
        }
        return null;
      }();
      print('${createLevelSuffix(rec.level)}${rec.level.name}: ${rec.time}: ${frame}: ${rec.message}');
    });
  }
}

final log = Logger('ShareTask');

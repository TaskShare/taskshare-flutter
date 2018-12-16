import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

String _createLevelSuffix(Level level) {
  if (level == Level.FINEST) {
    return '👣';
  }
  if (level == Level.FINER) {
    return '👀';
  }
  if (level == Level.FINE) {
    return '🎾';
  }
  if (level == Level.CONFIG) {
    return '🐶';
  }
  if (level == Level.INFO) {
    return '👻';
  }
  if (level == Level.WARNING) {
    return '⚠️';
  }
  if (level == Level.SEVERE) {
    return '‼️';
  }
  if (level == Level.SHOUT) {
    return '😡';
  }
  return null;
}

class AppLogger {
  static void configure() {
    // TODO: 場合によってオフにする
    recordStackTraceAtLevel = Level.ALL;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec) {
      final Frame frame = () {
        final stackTrace = rec.stackTrace;
        if (stackTrace == null) {
          return null;
        }
        final frames = Trace.from(stackTrace).frames;
        if (frames.length >= 3) {
          return frames[2];
        }
        return null;
      }();
      final level = '${_createLevelSuffix(rec.level)}';
      print('$level ${rec.level} | ${rec.time} | $frame | ${rec.message}');
    });
  }
}

final log = Logger('ShareTask');

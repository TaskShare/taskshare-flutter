import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import 'logger.dart' as logger;

final logger.Logger log = AppLogger();

class AppLogger implements logger.Logger {
  final _logger = Logger('ShareTask');

  AppLogger() {
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

  @override
  void trace(message) {
    _logger.finest(message);
  }

  @override
  void debug(message) {
    _logger.fine(message);
  }

  @override
  void info(message) {
    _logger.info(message);
  }

  @override
  void warn(message) {
    _logger.warning(message);
  }

  @override
  void error(message) {
    _logger.severe(message);
  }

  @override
  void fault(message) {
    _logger.shout(message);
  }
}

void configureLogger(logger.Level level) {
  final _level = _convertLevel(level);
  recordStackTraceAtLevel = _level;
  Logger.root.level = _level;
}

Level _convertLevel(logger.Level level) {
  switch (level) {
    case logger.Level.trace:
      return Level.FINEST;
    case logger.Level.debug:
      return Level.FINE;
    case logger.Level.info:
      return Level.INFO;
    case logger.Level.warn:
      return Level.WARNING;
    case logger.Level.error:
      return Level.SEVERE;
    case logger.Level.fault:
      return Level.SHOUT;
  }
  assert(false);
  return null;
}

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

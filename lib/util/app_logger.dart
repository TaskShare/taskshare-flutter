import 'dart:async';

import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import 'logger.dart' as logger;

/// グローバルにアクセスできるlogインスタンス
final logger.Logger log = AppLogger();

/// プラットフォーム固有の処理を書けるように標準Loggerをラップ
/// (AngularDartでは別途実装クラスを用意するイメージ)
class AppLogger implements logger.Logger {
  final _logger = Logger('ShareTask');
  StreamSubscription _subscription;

  AppLogger() {
    _subscription = Logger.root.onRecord.listen((record) {
      final frame = _getTargetFrame(record);
      final level = '${_createLevelSuffix(record.level)}';
      print(
          '$level ${record.level} | ${record.time} | $frame | ${record.message}');
    });
  }

  Frame _getTargetFrame(LogRecord record) {
    final stackTrace = record.stackTrace;
    if (stackTrace == null) {
      return null;
    }
    final frames = Trace.from(stackTrace).frames;
    const index = 3;
    if (frames.length > index) {
      return frames[index];
    }
    return frames.last;
  }

  @override
  void finest(message) => _logger.finest(message);

  @override
  void finer(message) => _logger.finer(message);

  @override
  void fine(message) => _logger.fine(message);

  @override
  void config(message) => _logger.config(message);

  @override
  void info(message) => _logger.info(message);

  @override
  void warning(message) => _logger.warning(message);

  @override
  void severe(message) => _logger.severe(message);

  @override
  void shout(message) => _logger.shout(message);

  @override
  void dispose() {
    _subscription.cancel();
  }
}

void configureLogger(Level level) {
  recordStackTraceAtLevel = level;
  Logger.root.level = level;
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

import 'package:logging/logging.dart';

class AppLogger {

  static configure() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }
}

final log = new Logger('ShareTask');
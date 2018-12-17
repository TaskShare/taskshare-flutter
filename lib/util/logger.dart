import 'package:simple_logger/simple_logger.dart';

// TODO: stacktraceEnabledはリリースビルドではfalseにする
final logger = SimpleLogger()
  ..setLevel(
    Level.FINEST,
    includeCallerInfo: true,
  );

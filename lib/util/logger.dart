import 'package:simple_logger/simple_logger.dart';

// TODO(mono): stacktraceEnabledはリリースビルドではfalseにする
final SimpleLogger logger = SimpleLogger()
  ..setLevel(
    Level.FINEST,
    includeCallerInfo: true,
  );

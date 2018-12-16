abstract class Logger {
  void trace(message);
  void debug(message);
  void info(message);
  void warn(message);
  void error(message);
  void fault(message);
}

enum Level { trace, debug, info, warn, error, fault }

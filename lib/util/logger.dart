abstract class Logger {
  void finest(message);
  void finer(message);
  void fine(message);
  void config(message);
  void info(message);
  void warning(message);
  void severe(message);
  void shout(message);

  void dispose();
}

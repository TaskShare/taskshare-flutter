import 'package:taskshare/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskshare/l10n/messages_all.dart';

class L10N {
  static Future<L10N> load(Locale locale) {
    final name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return L10N();
    });
  }

  static L10N of(BuildContext context) => Localizations.of<L10N>(context, L10N);

  String get addTask => Intl.message(
      'Add a new task',
      name: 'addTask',
      desc: 'Add a new task',
    );

  String snackTaskDone(String title) => Intl.message(
      'Task "$title" done',
      name: 'snackTaskDone',
      args: [title],
    );

  String snackTaskDeleted(String title) => Intl.message(
      'Task "$title" deleted',
      name: 'snackTaskDeleted',
      args: [title],
    );

  String get buttonSave => Intl.message('SAVE');

  String get buttonUndo => Intl.message('UNDO');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<L10N> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<L10N> load(Locale locale) => L10N.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<L10N> old) => false;
}

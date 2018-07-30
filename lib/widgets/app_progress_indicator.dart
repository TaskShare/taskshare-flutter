import 'package:taskshare/export/export_ui.dart';

class AppProgressIndicator extends StatelessWidget {
  final Color color;
  AppProgressIndicator({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).canvasColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

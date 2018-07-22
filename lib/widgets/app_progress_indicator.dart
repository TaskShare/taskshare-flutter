import 'package:taskshare/export/export_ui.dart';

class AppProgressIndicator extends StatelessWidget {
  final Color color;
  AppProgressIndicator({this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

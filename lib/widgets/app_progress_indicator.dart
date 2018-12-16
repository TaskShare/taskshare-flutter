import 'package:taskshare/widgets/widgets.dart';

class AppProgressIndicator extends StatelessWidget {
  final Color color;

  const AppProgressIndicator({this.color});

  factory AppProgressIndicator.forDesignTime() => AppProgressIndicator();

  @override
  Widget build(BuildContext context) => Container(
        color: color ?? Theme.of(context).canvasColor,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}

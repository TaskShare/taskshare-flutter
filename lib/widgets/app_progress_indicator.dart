import 'package:taskshare/widgets/widgets.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({this.color});

  factory AppProgressIndicator.forDesignTime() => const AppProgressIndicator();
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        color: color ?? Theme.of(context).canvasColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}

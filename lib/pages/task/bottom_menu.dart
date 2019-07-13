import 'package:taskshare/widgets/widgets.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu();

  factory BottomMenu.forDesignTime() => const BottomMenu();

  @override
  Widget build(BuildContext context) => BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
      );
}

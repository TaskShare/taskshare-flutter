import 'package:taskshare/widgets/widgets.dart';

class BottomMenu extends StatelessWidget {
  BottomMenu();

  factory BottomMenu.forDesignTime() => BottomMenu();

  @override
  Widget build(BuildContext context) => BottomAppBar(
//        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
      );
}

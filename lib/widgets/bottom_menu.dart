import 'package:taskshare/export/export_ui.dart';

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BottomAppBar(
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

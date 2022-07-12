part of './custom_tabBar_view.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key, 
    required this.PageNum, 
    required this.color
  }) : super(key: key);

  final int PageNum;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color,
      margin: EdgeInsets.all(8),
      child: Center(child: Text("PAGE $PageNum"))
    );
  }
}
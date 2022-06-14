import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/main/_main.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: logoColor,
        leading: SizedBox(),
        // On Android it's false by default
        centerTitle: true,
        title: Text("Account"),
      ),
      body: AccountBodyScreen(),
    );
  }
}

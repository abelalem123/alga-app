import 'package:flutter/material.dart';
import 'package:form/pages/ssample.dart';

class Temp extends StatefulWidget {
  String token;
  Temp({Key? key, required this.token}) : super(key: key);

  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Sample(token: widget.token)));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

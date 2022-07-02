
import 'package:flutter/material.dart';

class all_Memory extends StatefulWidget {
  all_Memory({Key? key}) : super(key: key);
  @override

  _allMemoryState createState() => _allMemoryState();
}
class _allMemoryState extends State<all_Memory> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('All memories'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
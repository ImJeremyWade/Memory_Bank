import 'package:mem_bank/models/myuser.dart';
import 'package:mem_bank/screens/home/home.dart';
import 'package:mem_bank/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}

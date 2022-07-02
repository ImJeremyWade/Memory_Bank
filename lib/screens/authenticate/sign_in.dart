import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:mem_bank/shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Sign in to Memory Bank',textAlign: TextAlign.center,),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
        child: ElevatedButton(
          child: Text('Sign in with Google',textAlign: TextAlign.center,),
          onPressed: () async{
            setState(() => loading = true);
            dynamic result = await _auth.signInGoogle();
            if(result == null){
              print('error signing in');
            }else{
              print('signed in');
              print(result.uid);
            }
            setState(() => loading = false);
          },
        ),
      ),
    );
  }
}

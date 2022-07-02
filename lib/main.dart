import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mem_bank/blocs/application_bloc.dart';
import 'package:mem_bank/models/myuser.dart';
import 'package:mem_bank/screens/authenticate/SignInScreen.dart';
import 'package:mem_bank/screens/home/wrapper.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<MyUser?>.value(
            value: AuthService().user,
            initialData: null,
            catchError: (_,__)=>null,
          ),
          ChangeNotifierProvider(
            create: (context) => ApplicationBloc(),
          ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}





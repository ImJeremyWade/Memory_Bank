import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mem_bank/models/myuser.dart';
import 'package:mem_bank/services/database.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // scopes: <String>[
    //   CalendarApi.calendarScope,
    // ],
  );

  //create user obj from FirebaseUser

  MyUser? _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }
  //sign in with google
  Future signInGoogle() async {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
      if (googleSignInAccount != null) {
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication?.idToken,
            accessToken: googleSignInAuthentication?.accessToken);

        UserCredential result = await _auth.signInWithCredential(
            authCredential);
        User? user = result.user;
        await DatabaseService(uid: user?.uid).setupUserData();
        return _userFromFirebaseUser(user!);
      }
  }
  //get users calendar
  // Future<List<Event>> getGoogleEventsData() async{
  //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //   var headers = (await googleUser?.authHeaders);
  //   final httpClient = ClientId();
  //   return appointments;
  // }

  //sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      print('Error signing out');
    }
  }
  String? getUid() {
    return FirebaseAuth.instance.currentUser?.uid.toString();
  }
}
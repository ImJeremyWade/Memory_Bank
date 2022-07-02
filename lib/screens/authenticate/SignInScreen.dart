// //SignInScreen
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mem_bank/screens/home/homepage.dart';
// import 'package:mem_bank/services/database.dart';
// import 'package:mem_bank/models/myuser.dart';
//
//
// class SignInScreen extends StatefulWidget {
//   SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//               Colors.indigo,
//               Colors.teal,
//               ],
//             ),
//           ),
//           child: Card(
//             margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
//             elevation: 20,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                 "Memory Bank",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: MaterialButton(
//                     color: Colors.teal[100],
//                     elevation: 10,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 30.0,
//                           width: 30.0,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text("Sign In with Google")
//                       ], //children
//                     ),
//
//                       // by onpressed we call the function signup function
//                       onPressed: () {
//                         signup(context);
//                       },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//     );
//   }
//
//   MyUser? _userFromFirebaseUser(User user){
//     return user != null ? MyUser(uid: user.uid) : null;
//   }
//   // function to implement the google signin
//   Future<void> signup(BuildContext context) async {
//     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//     dynamic id = googleSignInAccount?.id;
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//       idToken: googleSignInAuthentication.idToken,
//       accessToken: googleSignInAuthentication.accessToken);
//
//       // Getting users credential
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User? user = result.user;
//       await DatabaseService(uid: auth.currentUser?.uid).setupUserData();
//       print(id);
//       if (result != null) {
//         Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => HomePage()));
//       }  // if result not null we simply call the MaterialpageRoute,
//       return
//       // for go to the HomePage screen
//     }
//   }
//   void signOutGoogle() async{
//     await _googleSignIn.signOut();
//     print("User Sign Out");
//   }
//
//   Future getUser() async{
//     GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
//     print (currentUser);
//   }
// }





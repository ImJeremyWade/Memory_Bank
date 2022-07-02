// //Home page screen
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:mem_bank/screens/new_memory.dart';
// import 'package:mem_bank/screens/authenticate/SignInScreen.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mem_bank/screens/all_memory.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mem_bank/services/database.dart';
// import 'dart:developer' as developer;
// import 'package:provider/provider.dart';
// import 'memories_list.dart';
//
// class Home extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       child: Text('Home'),
//     );//container
//   }
// }
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   dynamic id;
//   bool button_clicked = false;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CollectionReference memoryCollection = FirebaseFirestore.instance.collection('memories');
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Widget _memorylist(QuerySnapshot? snapshot){
//     return ListView.builder(
//         itemCount:,
//       physics: const AlwaysScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//           final doc = snapshot?.docs[index];
//           print('hello $doc?[id]');
//           //print(doc?.data());
//           id = auth.currentUser?.uid;
//           //print(doc?[id]);
//           return ListTile(
//             title: Text(doc?[id]),
//           );
//       }
//     );
//   }
//   Widget build(BuildContext context) {
//     return StreamProvider<QuerySnapshot>.value(
//       value: DatabaseService().memories,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Memory Bank'),
//           centerTitle: true,
//           backgroundColor: Colors.indigo,
//         ),
//
//         body: MemoryList(),
//         floatingActionButton: FloatingActionButton(
//           child: Text('Refresh'),
//           onPressed: ()async{
//             print(auth.currentUser?.uid);
//           },
//         ),
//         bottomNavigationBar: BottomAppBar(
//           color: Colors.indigoAccent,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               IconButton(
//                 tooltip: 'Current memories',
//                 icon: const Icon(Icons.perm_contact_cal),
//                 onPressed: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => all_Memory()));
//                 }//list current entries
//               ),
//               IconButton(
//                   tooltip: 'Search memories',
//                   icon: const Icon(Icons.search),
//                   onPressed: () {}//search current entries
//               ),
//               IconButton(
//                   alignment: Alignment.center,
//                   tooltip: 'Add Memory',
//                   icon: const Icon(Icons.add_box_rounded),
//                   onPressed: () {
//                     Navigator.push(
//                         context, MaterialPageRoute(builder: (context) => new_Memory()));
//                   }//add new entry
//               ),
//               IconButton(
//                   tooltip: 'Recent memories',
//                   icon: const Icon(Icons.timelapse),
//                   onPressed: () {}//list recent edited/occured
//               ),
//               IconButton(
//                   tooltip: 'Log out',
//                   icon: const Icon(Icons.logout),
//
//                   onPressed: () async{
//                     await _googleSignIn.signOut();
//                     Navigator.pushReplacement(
//                         context, MaterialPageRoute(builder: (context) => SignInScreen()));
//                   }//signout
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
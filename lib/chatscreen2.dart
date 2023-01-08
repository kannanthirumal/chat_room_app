// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String username;
//
//   ChatScreen({required this.username});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(70.0), //width and height
//           // The size the AppBar would prefer if there were no other constraints.
//           child: SafeArea(
//             child: Container(
//               height: 100,
//               color: Colors.blue,
//               child: Center(child: Text('Chat Room',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 25,
//                     color: Colors.white
//                 ),
//               ),
//               ),
//             ),
//           ),
//           // preferredSize: Size.fromHeight(70.0),
//           // child: AppBar(
//           //   automaticallyImplyLeading: false,
//           //   centerTitle: true,
//           //   title: Text('Chat Room',),
//           // ),
//         ),
//         drawer: Container(
//           width: 100,
//           child: Drawer(
//             child: Column(
//               children: [
//                 SizedBox(height: 10,),
//                 // add a logout option in the side panel
//                 Builder(builder: (context) {
//                   return Center(
//                     child: ListTile(
//                       leading: Icon(Icons.arrow_circle_left,
//                         size: 50,
//                       ),
//                       onTap: () async {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   );
//                 }),
//                 SizedBox(height: 20,),
//                 // UserAccountsDrawerHeader(accountName: Text('ll'), accountEmail: Text('accountEmail')),
//           Center(
//             child: ListTile(
//               leading: Icon(Icons.sports_baseball,
//               size: 50,),
//               onTap: () {
//               },
//             ),
//           ),
//                 SizedBox(height: 10,),
//                 // UserAccountsDrawerHeader(accountName: Text('ll'), accountEmail: Text('accountEmail')),
//                 Center(
//                   child: ListTile(
//                     leading: Icon(Icons.monochrome_photos,
//                       size: 50,),
//                     onTap: () {
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 // UserAccountsDrawerHeader(accountName: Text('ll'), accountEmail: Text('accountEmail')),
//                 Center(
//                   child: ListTile(
//                     leading: Icon(Icons.palette,
//                       size: 50,),
//                     onTap: () {
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 // UserAccountsDrawerHeader(accountName: Text('ll'), accountEmail: Text('accountEmail')),
//                 Center(
//                   child: ListTile(
//                     leading: Icon(Icons.fitness_center,
//                       size: 50,),
//                     onTap: () {
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: Builder(
//           builder: (BuildContext context) {
//             return  FloatingActionButton.extended(
//               backgroundColor: Colors.blue,
//               icon: Icon(Icons.code, color: Colors.white,),
//               label: Text('Chat Rooms'),
//               isExtended: true,
//
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           }
//         ),
//       ),
//     );
//   }
// }
//

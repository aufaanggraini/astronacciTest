import 'package:asstronacci/ChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  final FirebaseUser user;
  final String flag;
  ChatListScreen({this.user, this.flag});
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                  user: widget.user,
                  flag: "google",
                )));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Group A"),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(height: 8,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                  user: widget.user,
                  flag: "facebook",
                )));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Group B"),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ],
        ),
      )
      // StreamBuilder(
      //   stream: widget.flag == "google"? Firestore.instance.collection('message').snapshots():Firestore.instance.collection('message').document('chat').collection('facebook').snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.data == null) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return ListView(
      //       scrollDirection: Axis.vertical,
      //       children: snapshot.data.documents.map((e) {
      //         return  Container(
      //             height: 60,
      //             padding: EdgeInsets.all(1),
      //             width: MediaQuery.of(context).size.width,
      //             child: ListTile(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => ChatScreen(
      //                             user: widget.user,
      //                           )));
      //                 },
      //               title: Text(e['from']),
      //               subtitle: Text(
      //                   DateFormat('HH:mm').format(DateTime.parse(e['date']))),
      //             ),
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
    );
  }
}

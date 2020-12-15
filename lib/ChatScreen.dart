import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final FirebaseUser user;
  final String flag;
  ChatScreen({this.user,this.flag, Key key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController _messageCtrl = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if(_messageCtrl.text.length > 0) {
      if(widget.flag == "google"){
        await _firestore.collection('message').document('chat').collection('google').add({
          'text': _messageCtrl.text,
          'from': widget.user.displayName,
          'date': DateTime.now().toIso8601String().toString(),
        });
        _messageCtrl.clear();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }else{
        await _firestore.collection('message').document('chat').collection('facebook').add({
          'text': _messageCtrl.text,
          'from': widget.user.displayName,
          'date': DateTime.now().toIso8601String().toString(),
        });
        _messageCtrl.clear();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
      }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: widget.flag =="google"? _firestore.collection('message').document('chat').collection('google').orderBy('date').snapshots():_firestore.collection('message').document('chat').collection('facebook').orderBy('date').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    List<DocumentSnapshot> docs = snapshot.data.documents;
                    List<Widget> messages = docs.map((e) => Message(
                      from: e.data['from'],
                      text: e.data['text'],
                      date: DateFormat('HH:mm').format(DateTime.parse(e.data['date'].toString())),
                      me: widget.user.displayName == e.data['from'],
                    )
                    ).toList();
                    return ListView(
                        controller: scrollController,
                        children: [
                          ...messages,
                        ],
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: _messageCtrl,
                          decoration: InputDecoration(
                              hintText: "Enter A Message...",
                              border: OutlineInputBorder()),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    SendButton(
                      text: "Send",
                      callback: callback,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({this.callback, this.text});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      child: Text(text),
      color: Colors.orange,
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final String date;
  final bool me;

  const Message({this.text, this.from, this.me, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(from),
          Material(
            color: me ? Colors.green : Colors.indigo,
            borderRadius: BorderRadius.circular(10),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(text, style: TextStyle(color: Colors.black),),
            ),
          ),
          Text(date),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

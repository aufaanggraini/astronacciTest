import 'videoComponent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class DetailAcsess extends StatefulWidget {
  final String flagAcsess;
  final String title;
  DetailAcsess({this.flagAcsess,this.title, Key key}) : super(key: key);
  @override
  _DetailAcsessState createState() => _DetailAcsessState();
}

class _DetailAcsessState extends State<DetailAcsess> {
  var limitVideo;
  // //
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _doLimitVideo();
  }

  _doLimitVideo(){
    if(widget.flagAcsess == "acsess_a"){
      limitVideo = Firestore.instance.collection("video").orderBy("name").limit(3).snapshots();
    }else if(widget.flagAcsess == "acsess_b"){
      limitVideo = Firestore.instance.collection("video").orderBy("name").limit(1).snapshots();
    }else{
      limitVideo = Firestore.instance.collection("video").orderBy("name").limit(6).snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: Text(
          widget.title.toString(),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Produk", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 10,),
            Expanded(
                flex: 2,
                child: widget.flagAcsess == "acsess_a"? Container(
                  color: Colors.white,
                  child: StreamBuilder(
                    stream:
                    Firestore.instance.collection("product").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data.documents.map((document) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 200.0,
                                  width: 145.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 140.0,
                                        width: 145.0,
                                        child: Image.network(
                                          document['img'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 3.0, top: 15.0),
                                        child: Text(document['name'],
                                            style: TextStyle(
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Sans")),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Text(document['price'],
                                            style: TextStyle(
                                                fontSize: 10.5,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Sans")),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ): Container(
                  child: Center(
                    child: Text("Content Tidak Tersedia untuk Hak asses ini"),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text("Video", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 10,),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: StreamBuilder(
                    stream: limitVideo,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data.documents.map((document) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 200.0,
                                  width: 350.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 150.0,
                                        width: 300.0,
                                        child: DatabaseVideo(
                                          videoPlayerController:
                                          VideoPlayerController.network(
                                            document['video_url'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 3.0, top: 15.0),
                                        child: Text(document['name'],
                                            style: TextStyle(
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Sans")),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

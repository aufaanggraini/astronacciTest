import 'package:asstronacci/ChatScreen.dart';
import 'package:asstronacci/ListChatScreen.dart';
import 'package:asstronacci/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String name;
  String fotoProfile;
  String flag;
  final FirebaseUser user;

  HomePage({this.name, this.fotoProfile, this.flag, this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                  child: Image.network(widget.user.photoUrl,
                      width: 100, height: 100, fit: BoxFit.cover)),
              SizedBox(
                height: 10,
              ),
              Text(widget.user.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  widget.flag == "admin"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatListScreen(
                                    user: widget.user,
                                  )))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    user: widget.user,
                                    flag: widget.flag,
                                  )));
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueAccent[700],
                  child: Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => DetailAcsess(
              //                   flagAcsess: "acsess_a",
              //                   title: "Acsess A",
              //                 )));
              //   },
              //   child: Container(
              //     height: 60,
              //     width: MediaQuery.of(context).size.width,
              //     color: Colors.blueAccent[700],
              //     child: Center(
              //       child: Text(
              //         "Access A",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w500,
              //             fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => DetailAcsess(
              //                 flagAcsess: "acsess_b", title: "Acsess B")));
              //   },
              //   child: Container(
              //     height: 60,
              //     width: MediaQuery.of(context).size.width,
              //     color: Colors.blueAccent[700],
              //     child: Center(
              //       child: Text(
              //         "Access B",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w500,
              //             fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => DetailAcsess(
              //                 flagAcsess: "acsess_c", title: "Acsess C")));
              //   },
              //   child: Container(
              //     height: 60,
              //     width: MediaQuery.of(context).size.width,
              //     color: Colors.blueAccent[700],
              //     child: Center(
              //       child: Text(
              //         "Access C",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w500,
              //             fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
              _containerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _containerButton(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    Container container = Container();
    Size size = MediaQuery.of(context).size;
    if (widget.flag == "google") {
      container = Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SignInButton(Buttons.Google, text: "Logout from Google",
              onPressed: () {
            _googleSignIn.signOut();
            Navigator.pop(context, false);
          }),
        ),
      );
    } else if (widget.flag == "facebook") {
      container = Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SignInButton(Buttons.Facebook,
              text: "Logout from Facebook",
              onPressed: () => authBloc.logOut(context)),
        ),
      );
    } else {
      container = Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SignInButton(Buttons.Google, text: "Logout from Admin",
              onPressed: () {
            _googleSignIn.signOut();
            Navigator.pop(context, false);
          }),
        ),
      );
    }
    return container;
  }
}

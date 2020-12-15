import 'package:asstronacci/ChatScreen.dart';
import 'package:asstronacci/homePage.dart';
import 'package:asstronacci/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter/material.dart';

class AuthBloc{
  final authServices = AuthSrevices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fb = FacebookLogin();

  Stream<FirebaseUser> get currentUser => authServices.currentUser;

  loginFacebook(BuildContext context)async{
    print("login facebook");

    final res = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]
    );

    switch(res.status){
      case FacebookLoginStatus.Success:
        print("user sucsess");

        final FacebookAccessToken fbToken = res.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: fbToken.token);

        // final result = await authServices.signInWithCredential(credential);
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(
          user: user,
          flag: "facebook",
        )));
      break;
      case FacebookLoginStatus.Cancel:
        print("user cancel");
      break;
      case FacebookLoginStatus.Error:
        print("user cancel");
      break;
    }
  }

  logOut(BuildContext context){
    authServices.logOut();
    Navigator.pop(context, false);
  }
}
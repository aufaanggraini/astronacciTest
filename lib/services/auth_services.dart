import 'package:firebase_auth/firebase_auth.dart';

class AuthSrevices{
  final _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get currentUser => _auth.onAuthStateChanged;
  Future<AuthResult> signInWithCredential(AuthCredential credential) =>_auth.signInWithCredential(credential);
  Future<void> logOut()=> _auth.signOut();
}
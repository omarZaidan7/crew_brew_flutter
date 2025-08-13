import 'package:crew_brew/model/user.dart';
import 'package:crew_brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }


  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }


  Future<MyUser?> SignInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<MyUser?> RegisterWithEmailAndPass(String email, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = result.user;

      if (user != null) {
        await DatabaseService(uid: user.uid).updateUserData(
            '0', 'new crew member', 100);
        return _userFromFirebaseUser(user);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<MyUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  Future signOut ()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}

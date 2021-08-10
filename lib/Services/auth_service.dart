import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User> get authState => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged in";
    }catch (e){
      return e;
    }
  }

  Future<String> register(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Registered";
    }catch (e){
      return e;
    }
  }

}
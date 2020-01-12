import 'package:firebase_auth/firebase_auth.dart';
import 'package:kureta_app/models/user.dart';
import 'package:kureta_app/services/user_service.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserService _userService = UserService();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future registerUser({String fullname, String email, String password}) async{
    try{
      FirebaseUser result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _userService.saveUser(User(email: email, fullname: fullname));
      return result;
    }catch(e){
      print(e.message);
      return Exception(e.message);
    }
  }

  Future login({String email, String password}) async {
    try{
      FirebaseUser result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return await _userService.getUser(result.email);
    }catch(e){
      print(e.message);
      return Exception(e.message);
    }
  }

  Future logout() async {
    try{
      await _auth.signOut();
    }catch(e){
      print(e.message);
      return Exception(e.message);
    }
  }

}
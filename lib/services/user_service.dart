
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kureta_app/models/user.dart';

class UserService {
  Firestore _fs = Firestore.instance;
  Future<bool> saveUser(User userData) async{
    try{
      await _fs.collection("users").document(userData.email).setData({"fullname": userData.fullname});
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<User> getUser(String email) async {
    var user = await _fs.collection("users").document(email).get();
    return user.exists ? User(email: user.documentID, fullname: user["fullname"]) : null;
  }
}
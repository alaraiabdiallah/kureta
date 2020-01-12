
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kureta_app/models/user.dart';

class UserService {
  Firestore fs = Firestore.instance;
  Future<bool> saveUser(User userData) async{
    try{
      await fs.collection("users").document(userData.email).setData({"fullname": userData.fullname});
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<User> getUser(String email) async {
    var user = await fs.collection("users").document(email).get();
    return user.exists ? User(email: user.documentID, fullname: user["fullname"]) : null;
  }
}
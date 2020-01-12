import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/form_input.dart';
import 'package:kureta_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();

}

class _RegisterScreen extends State<RegisterScreen> {
  final _fullNameTextCtrl = TextEditingController();
  final _emailTextCtrl = TextEditingController();
  final _passwordTextCtrl = TextEditingController();
  AuthService _authService = AuthService();
  bool _loading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  onRegisterButtonPressed() async {
    String fullname = this._fullNameTextCtrl.text;
    String email = this._emailTextCtrl.text;
    String password = this._passwordTextCtrl.text;
    try{
      setState(() =>_loading = true);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("On register...")));
      var register = await _authService.registerUser(fullname: fullname,email: email,password: password);
      if(register is Exception) throw register;
      setState(() =>_loading = false);
      Navigator.pop(context);
    }catch(e){
      setState(() =>_loading = false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xfff1f9fe),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 25,),
            Image.asset("assets/images/kureta-logo-long-resized.png",),
            SizedBox(height: 25,),
            KuretaTextField(title: "Fullname", controller: this._fullNameTextCtrl),
            KuretaTextField(title: "E-Mail Address", controller: this._emailTextCtrl),
            KuretaTextField(title: "Password", obscureText: true,controller: this._passwordTextCtrl),
            SizedBox(height: 10,),
            KuretaButton(text: "CREATE ACCOUNT",onPressed: _loading ? null : onRegisterButtonPressed),
            SizedBox(height: 20,),
            Center(child: Text("Already have Account?")),
            SizedBox(height: 10,),
            KuretaButton(
              text: "SIGN IN",
              color: Color(0xffE37857),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

}
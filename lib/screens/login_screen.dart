import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/form_input.dart';
import 'package:kureta_app/screens/register_screen.dart';
import 'package:kureta_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen> {
  final _emailTextCtrl = TextEditingController();
  final _passwordTextCtrl = TextEditingController();
  AuthService _authService = AuthService();
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  onLoginButtonPressed() async {
    String email = this._emailTextCtrl.text;
    String password = this._passwordTextCtrl.text;
    try{
      setState(() =>_loading = true);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("On login...")));
      var login = await _authService.login(email: email,password: password);
      if(login is Exception) throw login;
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
            SizedBox(height: 75,),
            Image.asset("assets/images/kureta-logo-long-resized.png",),
            SizedBox(height: 25,),
            KuretaTextField(title: "E-Mail Address", controller: this._emailTextCtrl),
            KuretaTextField(title: "Password", obscureText: true,controller: this._passwordTextCtrl),
            SizedBox(height: 10,),
            KuretaButton(text: "SIGN IN",onPressed: _loading? null : onLoginButtonPressed),
            SizedBox(height: 20,),
            Center(child: Text("Haven't Account?")),
            SizedBox(height: 10,),
            KuretaButton(
                text: "CREATE ACCOUNT",
                color: Color(0xffE37857),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }

}
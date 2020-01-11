import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/form_input.dart';
import 'package:kureta_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen> {
  final _emailTextCtrl = TextEditingController();
  final _passwordTextCtrl = TextEditingController();

  onLoginButtonPressed(){
    print(this._emailTextCtrl.text);
    print(this._passwordTextCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            KuretaButton(text: "SIGN IN",onPressed: onLoginButtonPressed),
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
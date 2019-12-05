import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/form_input.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();

}

class _RegisterScreen extends State<RegisterScreen> {
  final fullNameTextCtrl = TextEditingController();
  final emailTextCtrl = TextEditingController();
  final passwordTextCtrl = TextEditingController();

  onRegisterButtonPressed(){
    String fullname = this.fullNameTextCtrl.text;
    String email = this.emailTextCtrl.text;
    String password = this.passwordTextCtrl.text;
    print(fullname+" "+email+" "+password);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f9fe),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 25,),
            Image.asset("assets/images/kureta-logo-long-resized.png",),
            SizedBox(height: 25,),
            KuretaTextField(title: "Fullname", controller: this.fullNameTextCtrl),
            KuretaTextField(title: "E-Mail Address", controller: this.emailTextCtrl),
            KuretaTextField(title: "Password", obscureText: true,controller: this.passwordTextCtrl),
            SizedBox(height: 10,),
            KuretaButton(text: "CREATE ACCOUNT",onPressed: onRegisterButtonPressed),
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
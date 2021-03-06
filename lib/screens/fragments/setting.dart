import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/category_selector.dart';
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/services/auth_service.dart';
import '../screens.dart';

class Setting extends StatefulWidget {
  @override
  _Setting createState() => _Setting();

}

class _Setting extends State<Setting> {

  SavedCategorySource _scs = SavedCategorySource();
  String _uid;
  AuthService _authService = AuthService();
  _unauthView(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.10)
      ),
      width: double.infinity,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Need login to edit your category", style: TextStyle(fontSize: 22), textAlign: TextAlign.center,),
          SizedBox(height: 30),
          KuretaButton(
            text: "LOGIN ACCOUNT",
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          )
        ],
      ),
    );
  }

  _authView(){
    return FutureBuilder(
        future: _scs.getAll(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if(!snapshot.hasData || snapshot.data.length < 1) return Container();
          List<String> categories = List<String>();
          snapshot.data.forEach((d){
            categories.add(d);
          });
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CategorySelector(categories: categories),
                SizedBox(height: 10,),
                KuretaButton(
                  text: "Edit",
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryOnboardingScreen(isEdit: true)),
                    );
                  },
                )
              ],
            ),
          );
        }
    );
  }

  @override
  void didChangeDependencies() {
    _authService.user.listen((user) {
      _uid = user == null ? null : user.uid;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25,10,25,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Your category", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              if(_uid == null)...[
                _unauthView()
              ],
              if(_uid != null)...[
                _authView(),
                SizedBox(height: 10,),
                KuretaButton(
                  text: "LOGOUT",
                  onPressed: () async {
                    await _authService.logout();
                    setState(() {
                      _uid = null;
                    });
                  },
                )
              ]
            ],
          ),
        )

      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/category_selector.dart';
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import 'screens.dart';

class CategoryOnboardingScreen extends StatefulWidget {
  final bool isEdit;

  const CategoryOnboardingScreen({Key key, this.isEdit = false}) : super(key: key);
  @override
  _CategoryOnboardingScreen createState() => _CategoryOnboardingScreen();

}

class _CategoryOnboardingScreen extends State<CategoryOnboardingScreen> {
  final _categories = categoriesMock;
  List<String> _selectedCategories = List<String>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  onNextButtonPressed() async {
    if(_selectedCategories.length > 0){
      var source = SavedCategorySource();
      await source.clearAll();
      await source.saveFromListString(_selectedCategories);
      print(_selectedCategories);
      if(widget.isEdit)
        Navigator.pop(context);
      else
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
    }else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Mohon pilih kategori bacaan!")));
    }
  }

  onCategorySelected(selectedData) {
    setState(() => _selectedCategories = selectedData);
  }

  @override
  void initState() {
    if(widget.isEdit)
      SavedCategorySource().getAll().then((categories){
        categories.forEach((d) => setState(()=>_selectedCategories.add(d)));
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 15),
              child: Text("Select category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            ),
          ),
          Expanded(
            flex:6,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CategorySelector(categories: _categories, selected: _selectedCategories, onSelected: onCategorySelected),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: KuretaButton(text: widget.isEdit?"Simpan":"Selanjutnya",onPressed: onNextButtonPressed),
            ),
          ),
        ],
      ),
    );
  }

}
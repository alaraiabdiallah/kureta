import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  final Function onSelected;
  const CategorySelector({Key key, this.categories, this.onSelected}) : super(key: key);
  @override
  _CategorySelector createState() => _CategorySelector();

}

class _CategorySelector extends State<CategorySelector> {

  List<String> categories;
  List<String> selected = [];

  @override
  void initState() {
    categories = widget.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ...categories.map((category){
          bool isSelected = selected.contains(category);
          return  CategoryItem(name: category, isSelected: isSelected, onTap: (){
            setState(() {
              if(isSelected) selected = selected.where((d) => d != category).toList();
              else selected.add(category);
            });
            widget.onSelected(selected);
          });
        }).toList()
      ],
    );
  }

}

class CategoryItem extends StatefulWidget {
  final String name;
  final Function onTap;
  final bool isSelected;
  const CategoryItem({Key key, this.name, this.onTap, this.isSelected = false}) : super(key: key);
  @override
  _CategoryItem createState() => _CategoryItem();

}

class _CategoryItem extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    Color cardColor = widget.isSelected ? Colors.blue : Colors.white;
    Color textColor = widget.isSelected ? Colors.white : Colors.black;
    return Card(
        color: cardColor,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(widget.name, style: TextStyle(fontSize: 16, color: textColor),)
          ),
        )
    );
  }

}
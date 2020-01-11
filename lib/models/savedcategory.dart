class SavedCategory{
  int id;
  String name;

  SavedCategory({this.id, this.name});

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name
  };
}
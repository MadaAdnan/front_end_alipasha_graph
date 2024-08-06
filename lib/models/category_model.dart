

class CategoryModel {
  int? id;
  String? name;
  String? img;
  String? color;
  String? type;
  List<CategoryModel>? parent;
  List<CategoryModel>? children;

  CategoryModel({
    this.name,
    this.id,
    this.img,
    this.children,
    this.parent,
    this.color,
    this.type,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    List<CategoryModel> listParent = [];
    List<CategoryModel> listChildren = [];
    if (data['parents'] != null) {
      for (var item in data['parents']) {
        listParent.add(CategoryModel.fromJson(item));
      }
    }

    if (data['children'] != null) {
      for (var item in data['children']) {
        listChildren.add(CategoryModel.fromJson(item));
      }
    }
    return CategoryModel(
        name: "${data['name']}",
        img: "${data['image']}",
        color: "${data['color']}",
        type: "${data['type']}",
        id: int.tryParse("${data['id']}"),
        children: listChildren.toList(),
        parent: listParent.toList());
  }

  toJson(){
    return {
      'id':id,
      'name':name,
      'image':img,
      'type':type,
      'color':color,
      "children":children!=null?children!.map((el)=>el.toJson()):[],
      "parent":children!=null?parent!.map((el)=>el.toJson()):[],
    };
  }
}

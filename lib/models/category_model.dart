class CategoryModel {
  int? id;
  String? name;
  String? img;
  String? color;
  String? type;
  List<CategoryModel>? parent;
  List<CategoryModel>? children;
  bool? hasColor;
  int? products2Count;

  CategoryModel({
    this.name,
    this.id,
    this.img,
    this.children,
    this.parent,
    this.color,
    this.type,
    this.hasColor,
    this.products2Count,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "$name";
  }

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
        hasColor: bool.tryParse("${data['has_color']}") ?? false,
        color: "${data['color']}",
        type: "${data['type']}",
        id: int.tryParse("${data['id']}"),
        products2Count: int.tryParse("${data['products2_count']}"),
        children: listChildren.toList(),
        parent: listParent.toList());
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': img,
      'type': type,
      'color': color,
      "children": children != null ? children!.map((el) => el.toJson()) : [],
      "parent": children != null ? parent!.map((el) => el.toJson()) : [],
    };
  }
}

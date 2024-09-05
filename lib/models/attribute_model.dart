class AttributeModel {
  int? id;
  String? name;
  String? type;
  List<AttributeModel>? attributes;

  AttributeModel({this.name, this.id, this.attributes,this.type});

  factory AttributeModel.fromJson(Map<String, dynamic> data) {
    List<AttributeModel> list = [];
    if (data['attributes'] != null) {
      for (var item in data['attributes']) {
        list.add(AttributeModel.fromJson(item));
      }
    }

    return AttributeModel(
      name: "${data['name'] ?? ''}",
      id: int.tryParse("${data['id']}"),
      attributes: list.toList(),
      type: "${data['type'] ?? ''}",
    );
  }

  toJson() {
    return {
      "name": name,
      "id": id,
      "attributes":
          attributes != null ? attributes!.map((el) => el.toJson()) : []
    };
  }
}

class CategoryModel {
  int id;
  String? name;

  CategoryModel({required this.id, this.name});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] != null ? map['name'] as String : null,
    );
  }
}

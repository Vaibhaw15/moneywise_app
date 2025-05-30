class CategoryModel {
  int? id;
  String? categoryName;
  int? categoryTypeId;
  String? categoryIcon;
  bool? active;

  CategoryModel(
      {this.id,
        this.categoryName,
        this.categoryTypeId,
        this.categoryIcon,
        this.active});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryTypeId = json['categoryTypeId'];
    categoryIcon = json['categoryIcon'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['categoryName'] = categoryName;
    data['categoryTypeId'] = categoryTypeId;
    data['categoryIcon'] = categoryIcon;
    data['active'] = active;
    return data;
  }
}
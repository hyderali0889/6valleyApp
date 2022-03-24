import 'CategoryModel.dart';

class SubCategoryModel {
  bool status;
  List<SubCategoryData> data;

  SubCategoryModel({this.status, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<SubCategoryData>();
      json['data'].forEach((v) {
        data.add(new SubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryData {
  int id;
  String categoryId;
  String name;
  String childCategories;
  List<Products> products;
  String attributes;
  Null createdAt;
  Null updatedAt;

  SubCategoryData(
      {this.id,
        this.categoryId,
        this.name,
        this.childCategories,
        this.products,
        this.attributes,
        this.createdAt,
        this.updatedAt});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    childCategories = json['child_categories'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    attributes = json['attributes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['child_categories'] = this.childCategories;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['attributes'] = this.attributes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


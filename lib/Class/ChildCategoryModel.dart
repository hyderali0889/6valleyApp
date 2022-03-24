class ChildCategoryModel {
  bool status;
  List<ChildCategotyData> data;

  ChildCategoryModel({this.status, this.data});

  ChildCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ChildCategotyData>();
      json['data'].forEach((v) {
        data.add(new ChildCategotyData.fromJson(v));
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

class ChildCategotyData {
  int id;
  String subcategoryId;
  String name;
  String attributes;
  List products;
  String createdAt;
  String updatedAt;

  ChildCategotyData(
      {this.id,
        this.subcategoryId,
        this.name,
        this.attributes,
        this.products,
        this.createdAt,
        this.updatedAt});

  ChildCategotyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    attributes = json['attributes'];
    if (json['products'] != null) {
      products = new List();
      json['products'].forEach((v) {
        products.add(v.toString());
      });
    }
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_id'] = this.subcategoryId;
    data['name'] = this.name;
    data['attributes'] = this.attributes;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

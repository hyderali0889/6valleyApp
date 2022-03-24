class Attributes {
  bool status;
  List<AttributeData> data;
  List error;

  Attributes({this.status, this.data, this.error});

  Attributes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<AttributeData>();
      json['data'].forEach((v) {
        data.add(new AttributeData.fromJson(v));
      });
    }
    if (json['error'] != null) {
      error = new List();
      json['error'].forEach((v) {
        error.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.error != null) {
      data['error'] = this.error.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeData {
  Attribute attribute;
  List<Options> options;
  int selectedOption;

  AttributeData({this.attribute, this.options,this.selectedOption});

  AttributeData.fromJson(Map<String, dynamic> json) {
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    selectedOption=-1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attribute != null) {
      data['attribute'] = this.attribute.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attribute {
  int id;
  String attributableId;
  String attributableType;
  String name;
  String inputName;
  String priceStatus;
  String detailsStatus;
  String createdAt;
  String updatedAt;

  Attribute(
      {this.id,
        this.attributableId,
        this.attributableType,
        this.name,
        this.inputName,
        this.priceStatus,
        this.detailsStatus,
        this.createdAt,
        this.updatedAt});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributableId = json['attributable_id'];
    attributableType = json['attributable_type'];
    name = json['name'];
    inputName = json['input_name'];
    priceStatus = json['price_status'];
    detailsStatus = json['details_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attributable_id'] = this.attributableId;
    data['attributable_type'] = this.attributableType;
    data['name'] = this.name;
    data['input_name'] = this.inputName;
    data['price_status'] = this.priceStatus;
    data['details_status'] = this.detailsStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Options {
  int id;
  String attributeId;
  String name;
  String createdAt;
  String updatedAt;

  Options(
      {this.id, this.attributeId, this.name, this.createdAt, this.updatedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeId = json['attribute_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_id'] = this.attributeId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

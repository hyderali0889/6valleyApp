class VendorProductModel {
  bool status;
  List<VendorProductData> data;

  VendorProductModel({this.status, this.data});

  VendorProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<VendorProductData>();
      json['data'].forEach((v) {
        data.add(new VendorProductData.fromJson(v));
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

class VendorProductData {
  int id;
  String title;
  String thumbnail;
  int rating;
  String currentPrice;
  String previousPrice;
  String saleEndDate;
  CreatedAt createdAt;
  CreatedAt updatedAt;

  VendorProductData(
      {this.id,
        this.title,
        this.thumbnail,
        this.rating,
        this.currentPrice,
        this.previousPrice,
        this.saleEndDate,
        this.createdAt,
        this.updatedAt});

  VendorProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    currentPrice = json['current_price'].toString();
    previousPrice = json['previous_price'].toString();
    saleEndDate = json['sale_end_date'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new CreatedAt.fromJson(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['rating'] = this.rating;
    data['current_price'] = this.currentPrice;
    data['previous_price'] = this.previousPrice;
    data['sale_end_date'] = this.saleEndDate;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    return data;
  }
}

class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({this.date, this.timezoneType, this.timezone});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

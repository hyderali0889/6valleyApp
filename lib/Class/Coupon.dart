class Coupon {
  bool status;
  CouponData data;
  List error;

  Coupon({this.status, this.data, this.error});

  Coupon.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new CouponData.fromJson(json['data']) : null;
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
      data['data'] = this.data.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponData {
  int id;
  String code;
  String type;
  String price;
  String times;
  String used;
  String status;
  String startDate;
  String endDate;

  CouponData(
      {this.id,
        this.code,
        this.type,
        this.price,
        this.times,
        this.used,
        this.status,
        this.startDate,
        this.endDate});

  CouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    price = json['price'];
    times = json['times'];
    used = json['used'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['price'] = this.price;
    data['times'] = this.times;
    data['used'] = this.used;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}


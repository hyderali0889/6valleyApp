class UserPackages {
  bool status;
  PackageData data;

  UserPackages({this.status, this.data});

  UserPackages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new PackageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PackageData {
  List<Subs> subs;
  CurrrentPackage currentPackage;

  PackageData({this.subs, this.currentPackage});

  PackageData.fromJson(Map<String, dynamic> json) {
    if (json['subs'] != null) {
      subs = new List<Subs>();
      json['subs'].forEach((v) {
        subs.add(new Subs.fromJson(v));
      });
    }
    currentPackage = json['currrent_package'] != null
        ? new CurrrentPackage.fromJson(json['currrent_package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subs != null) {
      data['subs'] = this.subs.map((v) => v.toJson()).toList();
    }
    if (this.currentPackage != null) {
      data['currrent_package'] = this.currentPackage.toJson();
    }
    return data;
  }
}

class Subs {
  int id;
  String title;
  String currency;
  String currencyCode;
  String price;
  String days;
  String allowedProducts;
  String details;

  Subs(
      {this.id,
        this.title,
        this.currency,
        this.currencyCode,
        this.price,
        this.days,
        this.allowedProducts,
        this.details});

  Subs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    price = json['price'];
    days = json['days'];
    allowedProducts = json['allowed_products'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['price'] = this.price;
    data['days'] = this.days;
    data['allowed_products'] = this.allowedProducts;
    data['details'] = this.details;
    return data;
  }
}

class CurrrentPackage {
  int id;
  String userId;
  String subscriptionId;
  String title;
  String currency;
  String currencyCode;
  String price;
  String days;
  String allowedProducts;
  String details;
  String method;
  String txnid;
  String chargeId;
  String flutterId;
  String createdAt;
  String updatedAt;
  String status;
  String paymentNumber;
  String endDate;

  CurrrentPackage(
      {this.id,
        this.userId,
        this.subscriptionId,
        this.title,
        this.currency,
        this.currencyCode,
        this.price,
        this.days,
        this.allowedProducts,
        this.details,
        this.method,
        this.txnid,
        this.chargeId,
        this.flutterId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.endDate,
        this.paymentNumber});

  CurrrentPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subscriptionId = json['subscription_id'];
    title = json['title'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    price = json['price'];
    days = json['days'];
    allowedProducts = json['allowed_products'];
    details = json['details'];
    method = json['method'];
    txnid = json['txnid'];
    chargeId = json['charge_id'];
    flutterId = json['flutter_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    paymentNumber = json['payment_number'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['subscription_id'] = this.subscriptionId;
    data['title'] = this.title;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['price'] = this.price;
    data['days'] = this.days;
    data['allowed_products'] = this.allowedProducts;
    data['details'] = this.details;
    data['method'] = this.method;
    data['txnid'] = this.txnid;
    data['charge_id'] = this.chargeId;
    data['flutter_id'] = this.flutterId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['payment_number'] = this.paymentNumber;
    return data;
  }
}

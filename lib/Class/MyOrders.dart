class MyOrders {
  bool status;
  List<MyOrderData> data;
  List error;

  MyOrders({this.status, this.data, this.error});

  MyOrders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<MyOrderData>();
      json['data'].forEach((v) {
        data.add(new MyOrderData.fromJson(v));
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

class MyOrderData {
  int id;
  String number;
  String total;
  String status;
  String details;
  List<Products> products;
  String createdAt;
  String updatedAt;
  String paymentUrl;

  MyOrderData(
      {this.id,
        this.number,
        this.total,
        this.status,
        this.details,
        this.products,
        this.createdAt,
        this.updatedAt,
        this.paymentUrl});

  MyOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    total = json['total'];
    status = json['status'];
    details = json['details'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    createdAt = json['created_at']['date'];
    updatedAt = json['updated_at']['date'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['total'] = this.total;
    data['status'] = this.status;
    data['details'] = this.details;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}

class Products {
  int qty;
  var sizeKey;
  var sizeQty;
  var sizePrice;
  String size;
  String color;
  var stock;
  String keys;
  String values;
  var itemPrice;
  int id;
  String name;
  var vendorId;
  String type;
  String featureImage;
  var totalPrice;

  Products(
      {this.qty,
        this.sizeKey,
        this.sizeQty,
        this.sizePrice,
        this.size,
        this.color,
        this.stock,
        this.keys,
        this.values,
        this.itemPrice,
        this.id,
        this.name,
        this.vendorId,
        this.type,
        this.featureImage,
        this.totalPrice});

  Products.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    sizeKey = json['size_key'];
    sizeQty = json['size_qty'];
    sizePrice = json['size_price'];
    size = json['size'];
    color = json['color'];
    stock = json['stock'];
    keys = json['keys'];
    values = json['values'];
    itemPrice = json['item_price'];
    id = json['id'];
    name = json['name'];
    vendorId = json['vendor_id'];
    type = json['type'];
    featureImage = json['feature_image'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['size_key'] = this.sizeKey;
    data['size_qty'] = this.sizeQty;
    data['size_price'] = this.sizePrice;
    data['size'] = this.size;
    data['color'] = this.color;
    data['stock'] = this.stock;
    data['keys'] = this.keys;
    data['values'] = this.values;
    data['item_price'] = this.itemPrice;
    data['id'] = this.id;
    data['name'] = this.name;
    data['vendor_id'] = this.vendorId;
    data['type'] = this.type;
    data['feature_image'] = this.featureImage;
    data['total_price'] = this.totalPrice;
    return data;
  }
}


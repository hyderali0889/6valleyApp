class SingleOrder {
  bool status;
  Data data;
  List error;

  SingleOrder({this.status, this.data, this.error});

  SingleOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int id;
  String number;
  String total;
  String status;
  String paymentStatus;
  String shippingName;
  String shippingEmail;
  String shippingPhone;
  String shippingAddress;
  String shippingZip;
  String shippingCity;
  String shippingCountry;
  String customerName;
  String customerEmail;
  String customerPhone;
  String customerAddress;
  String customerZip;
  String customerCity;
  String customerCountry;
  String shipping;
  String paidAmount;
  String paymentMethod;
  String shippingCost;
  String packingCost;
  String chargeId;
  String transactionId;
  List<OrderedProducts> orderedProducts;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.number,
        this.total,
        this.status,
        this.paymentStatus,
        this.shippingName,
        this.shippingEmail,
        this.shippingPhone,
        this.shippingAddress,
        this.shippingZip,
        this.shippingCity,
        this.shippingCountry,
        this.customerName,
        this.customerEmail,
        this.customerPhone,
        this.customerAddress,
        this.customerZip,
        this.customerCity,
        this.customerCountry,
        this.shipping,
        this.paidAmount,
        this.paymentMethod,
        this.shippingCost,
        this.packingCost,
        this.chargeId,
        this.transactionId,
        this.orderedProducts,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    total = json['total'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    shippingName = json['shipping_name'];
    shippingEmail = json['shipping_email'];
    shippingPhone = json['shipping_phone'];
    shippingAddress = json['shipping_address'];
    shippingZip = json['shipping_zip'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    customerZip = json['customer_zip'];
    customerCity = json['customer_city'];
    customerCountry = json['customer_country'];
    shipping = json['shipping'];
    paidAmount = json['paid_amount'];
    paymentMethod = json['payment_method'];
    shippingCost = json['shipping_cost'];
    packingCost = json['packing_cost'];
    chargeId = json['charge_id'];
    transactionId = json['transaction_id'];
    if (json['ordered_products'] != null) {
      orderedProducts = new List<OrderedProducts>();
      json['ordered_products'].forEach((v) {
        orderedProducts.add(new OrderedProducts.fromJson(v));
      });
    }
    createdAt = json['created_at']['date'];
    updatedAt = json['updated_at']['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['total'] = this.total;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['shipping_name'] = this.shippingName;
    data['shipping_email'] = this.shippingEmail;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_zip'] = this.shippingZip;
    data['shipping_city'] = this.shippingCity;
    data['shipping_country'] = this.shippingCountry;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['customer_zip'] = this.customerZip;
    data['customer_city'] = this.customerCity;
    data['customer_country'] = this.customerCountry;
    data['shipping'] = this.shipping;
    data['paid_amount'] = this.paidAmount;
    data['payment_method'] = this.paymentMethod;
    data['shipping_cost'] = this.shippingCost;
    data['packing_cost'] = this.packingCost;
    data['charge_id'] = this.chargeId;
    data['transaction_id'] = this.transactionId;
    if (this.orderedProducts != null) {
      data['ordered_products'] =
          this.orderedProducts.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderedProducts {
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
  String vendorId;
  String type;
  String featureImage;
  var totalPrice;

  OrderedProducts(
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

  OrderedProducts.fromJson(Map<String, dynamic> json) {
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


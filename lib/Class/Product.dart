import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/URL/AppConstant.dart';

class Product {
  bool status;
  Data data;

  Product({this.status, this.data});


  static String makeProductApi(String url,{String type,String highlight,String productType,int paginate=10}){
    String finalUrl;
    if(highlight!=null)
      finalUrl=url.replaceAll('${AppConstant.add}${AppConstant.highlight}', highlight);
    else
      finalUrl=url.replaceAll('${AppConstant.highlight}=${AppConstant.add}${AppConstant.highlight}&', '');
    if(type!=null)
      finalUrl=finalUrl.replaceAll('${AppConstant.add}${AppConstant.type}', type);
    else
      finalUrl=finalUrl.replaceAll('${AppConstant.type}=${AppConstant.add}${AppConstant.type}&', '');
    if(productType!=null)
      finalUrl=finalUrl.replaceAll('${AppConstant.add}${AppConstant.product_type_License}', productType);
    else
      finalUrl=finalUrl.replaceAll('${AppConstant.product_type_License}=${AppConstant.add}${AppConstant.product_type_License}&', '');

    finalUrl=finalUrl.replaceAll('${AppConstant.add}${AppConstant.paginate}', paginate.toString());
    return finalUrl;
  }

  Product.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<ProductData> data;
  Links links;
  Meta meta;

  Data({this.data, this.links, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ProductData>();
      json['data'].forEach((v) {
        data.add(new ProductData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class ProductData {
  int id;
  String title;
  String thumbnail;
  int rating;
  String currentPrice;
  String previousPrice;
  CreatedAt createdAt;
  CreatedAt updatedAt;
  String saleEndDate;
  Attributes attributes;
  int quantity;
  List<String> wholeSellQuantity;
  List<String> wholeSellDiscount;
  String selectedColor,selectedSize;

  String sizePrice;

  ProductData(
      {this.id,
        this.title,
        this.thumbnail,
        this.rating,
        this.currentPrice,
        this.previousPrice,
        this.createdAt,
        this.updatedAt,
        this.saleEndDate,
        this.attributes,
        this.quantity,
        this.sizePrice,
        this.wholeSellQuantity,
        this.wholeSellDiscount,
        this.selectedColor,
        this.selectedSize});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    currentPrice = json['current_price'].toString();
    previousPrice = json['previous_price'].toString();
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new CreatedAt.fromJson(json['updated_at'])
        : null;
    saleEndDate = json['sale_end_date'];
    if (json['attributes'] != null) {
      attributes = Attributes.fromJson(json['attributes']);
    }
    quantity = json['quantity'] ?? 0;
    try{sizePrice = json['size_price'];}catch(e){}
    try {
      wholeSellQuantity =
      json['whole_sell_quantity'] != null || json['whole_sell_quantity'] != ''
          ? json['whole_sell_quantity'].cast<String>()
          : List();
      wholeSellDiscount =
      json['whole_sell_discount'] != null || json['whole_sell_discount'] != ''
          ? json['whole_sell_discount'].cast<String>()
          : List();
    }catch(e){}
    selectedColor = json['selected_color'] ?? '';
    selectedSize = json['selected_size'] ??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['rating'] = this.rating;
    data['current_price'] = this.currentPrice;
    data['previous_price'] = this.previousPrice;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    data['sale_end_date'] = this.saleEndDate;
    data['attributes'] = this.attributes != null ? this.attributes.toJson() : null;
    data['quantity'] = this.quantity;
    data['size_price'] = this.sizePrice;
    data['whole_sell_quantity'] = this.wholeSellQuantity;
    data['whole_sell_discount'] = this.wholeSellDiscount;
    data['selected_color'] = this.selectedColor;
    data['selected_size'] = this.selectedSize;
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

class Links {
  String first;
  String last;
  Null prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}


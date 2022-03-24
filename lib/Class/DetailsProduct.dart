import 'package:geniouscart/URL/AppConstant.dart';

class DetailsProduct {
  bool status;
  DetailsProductData data;

  DetailsProduct({this.status, this.data});

  static makeDetailsProductApi(String url,{String productId}){
    return url.replaceAll(AppConstant.product_id, productId);
  }

  DetailsProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DetailsProductData.fromJson(json['data']) : null;
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

class DetailsProductData {
  int id;
  String title;
  String type;
  Attributes attributes;
  String thumbnail;
  String firstImage;
  List<ProductImages> images;
  int rating;
  String currentPrice;
  String previousPrice;
  String stock;
  String condition;
  String video;
  String estimatedShippingTime;
  List<String> colors;
  List<String> sizes;
  List<String> sizeQuantity;
  List<String> sizePrice;
  String details;
  String policy;
  List<String> wholeSellQuantity;
  List<String> wholeSellDiscount;
  List<Reviews> reviews;
  List<Comments> comments;
  List<RelatedProducts> relatedProducts;
  Shop shop;
  ReplayCreatedAt createdAt;
  ReplayCreatedAt updatedAt;

  DetailsProductData(
      {this.id,
        this.title,
        this.type,
        this.attributes,
        this.thumbnail,
        this.firstImage,
        this.images,
        this.rating,
        this.currentPrice,
        this.previousPrice,
        this.stock,
        this.condition,
        this.video,
        this.estimatedShippingTime,
        this.colors,
        this.sizes,
        this.sizeQuantity,
        this.sizePrice,
        this.details,
        this.policy,
        this.wholeSellQuantity,
        this.wholeSellDiscount,
        this.reviews,
        this.comments,
        this.relatedProducts,
        this.shop,
        this.createdAt,
        this.updatedAt});

  DetailsProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    thumbnail = json['thumbnail'];
    firstImage = json['first_image'];
    if (json['images'] != null) {
      images = new List<ProductImages>();
      json['images'].forEach((v) {
        images.add(new ProductImages.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = Attributes.fromJson(json['attributes']);
    }
    rating = json['rating'];
    currentPrice = json['current_price'].toString();
    previousPrice = json['previous_price'].toString();
    stock = json['stock'].toString();
    condition = json['condition'];
    video = json['video'];
    estimatedShippingTime = json['estimated_shipping_time'];
    colors = json['colors']!='' ? json['colors'].cast<String>() : List();
    sizes = json['sizes']!='' ? json['sizes'].cast<String>() : List();
    sizeQuantity = json['size_quantity']!='' ? json['size_quantity'].cast<String>() : List();
    sizePrice = json['size_price']!='' ? json['size_price'].cast<String>() : List();
    details = json['details'];
    policy = json['policy'];
    wholeSellQuantity = json['whole_sell_quantity']!='' ? json['whole_sell_quantity'].cast<String>() : List();
    wholeSellDiscount = json['whole_sell_discount']!='' ? json['whole_sell_discount'].cast<String>() : List();
    if (json['reviews'] != null) {
      reviews = new List();
      json['reviews'].forEach((v) {
        reviews.add(Reviews.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = new List();
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v));
      });
    }
    if (json['related_products'] != null) {
      relatedProducts = new List<RelatedProducts>();
      json['related_products'].forEach((v) {
        relatedProducts.add(new RelatedProducts.fromJson(v));
      });
    }
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    createdAt = json['created_at'] != null
        ? new ReplayCreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new ReplayCreatedAt.fromJson(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['attributes'] = this.attributes!=null ? this.attributes.toJson() : null;
    data['thumbnail'] = this.thumbnail;
    data['first_image'] = this.firstImage;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['current_price'] = this.currentPrice;
    data['previous_price'] = this.previousPrice;
    data['stock'] = this.stock;
    data['condition'] = this.condition;
    data['video'] = this.video;
    data['estimated_shipping_time'] = this.estimatedShippingTime;
    data['colors'] = this.colors;
    data['sizes'] = this.sizes;
    data['size_quantity'] = this.sizeQuantity;
    data['size_price'] = this.sizePrice;
    data['details'] = this.details;
    data['policy'] = this.policy;
    data['whole_sell_quantity'] = this.wholeSellQuantity;
    data['whole_sell_discount'] = this.wholeSellDiscount;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.relatedProducts != null) {
      data['related_products'] =
          this.relatedProducts.map((v) => v.toJson()).toList();
    }
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    return data;
  }
}

class ProductImages {
  int id;
  String image;

  ProductImages({this.id, this.image});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class RelatedProducts {
  int id;
  String title;
  String thumbnail;
  int rating;
  String currentPrice;
  String previousPrice;
  ReplayCreatedAt createdAt;
  ReplayCreatedAt updatedAt;

  RelatedProducts(
      {this.id,
        this.title,
        this.thumbnail,
        this.rating,
        this.currentPrice,
        this.previousPrice,
        this.createdAt,
        this.updatedAt});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    currentPrice = json['current_price'].toString();
    previousPrice = json['previous_price'].toString();
    createdAt = json['created_at'] != null
        ? new ReplayCreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new ReplayCreatedAt.fromJson(json['updated_at'])
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

class Shop {
  int id;
  String name;
  String items;

  Shop({this.id,this.name, this.items});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    items = json['items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['items'] = this.items;
    return data;
  }
}

class Reviews {
  int id;
  String userImage;
  String userId;
  String name;
  String review;
  String rating;
  String reviewDate;

  Reviews(
      {this.id,
        this.userImage,
        this.userId,
        this.name,
        this.review,
        this.rating,
        this.reviewDate});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userImage = json['user_image'];
    userId = json['user_id'];
    name = json['name'];
    review = json['review'];
    rating = json['rating'];
    reviewDate = json['review_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_image'] = this.userImage;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['review_date'] = this.reviewDate;
    return data;
  }
}

class Comments {
  int id;
  String userImage;
  var userId;
  String name;
  String comment;
  List<Replies> replies;
  String createdAt;
  String updatedAt;

  Comments(
      {this.id,
        this.userImage,
        this.userId,
        this.name,
        this.comment,
        this.replies,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userImage = json['user_image'];
    userId = json['user_id'];
    name = json['name'];
    comment = json['comment'];
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_image'] = this.userImage;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['comment'] = this.comment;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Replies {
  int id;
  String userImage;
  var userId;
  String name;
  String comment;
  String createdAt;
  String updatedAt;

  Replies(
      {this.id,
        this.userImage,
        this.userId,
        this.name,
        this.comment,
        this.createdAt,
        this.updatedAt});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userImage = json['user_image'];
    userId = json['user_id'];
    name = json['name'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_image'] = this.userImage;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class ReplayCreatedAt {
  String date;
  int timezoneType;
  String timezone;

  ReplayCreatedAt({this.date, this.timezoneType, this.timezone});

  ReplayCreatedAt.fromJson(Map<String, dynamic> json) {
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
class Attributes{
  List<String> name;
  List<SingleAttribute> attribute;

  Attributes({this.name, this.attribute});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = new List<String>();
    attribute = new List<SingleAttribute>();
    json.forEach((key, value) {
      name.add(key);
      attribute.add(SingleAttribute.fromJson(value));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for(int i=0;i<name.length;i++){
      data[name[i]]=attribute[i].toJson();
    }
    return data;
  }
}

class SingleAttribute {
  List<String> values;
  List<String> prices;
  List<bool> selected;
  int detailsStatus;

  SingleAttribute({this.values, this.prices,this.selected, this.detailsStatus});

  SingleAttribute.fromJson(Map<String, dynamic> json) {
    selected=List();
    values = json['values'].cast<String>();
    prices = json['prices'].cast<String>();
    if(!json.containsKey('selected')) {
      prices.forEach((element) {
        selected.add(false);
      });
      selected[0] = true;
    }else{
      selected = json['selected'].cast<bool>();
    }
    detailsStatus = json['details_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['values'] = this.values;
    data['prices'] = this.prices;
    data['details_status'] = this.detailsStatus;
    data['selected'] = this.selected;
    return data;
  }
}
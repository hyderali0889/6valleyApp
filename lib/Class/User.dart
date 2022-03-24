class User {
  int id;
  String fullName;
  String phone;
  String email;
  String fax;
  String type;
  String propic;
  String zipCode;
  String city;
  String country;
  String address;
  String balance;
  String emailVerified;
  String affilateCode;
  String affilateIncome;
  String affilateLink;
  String shopName;
  String ownerName;
  String shopNumber;
  String shopAddress;
  String shopMessage;
  String shopDetails;
  String shopImage;
  Facebook facebook;
  Google google;
  Google twitter;
  Google linkedin;
  String ban;

  User(
      {this.id,
        this.fullName,
        this.phone,
        this.email,
        this.fax,
        this.type,
        this.propic,
        this.zipCode,
        this.city,
        this.country,
        this.address,
        this.balance,
        this.emailVerified,
        this.affilateCode,
        this.affilateIncome,
        this.affilateLink,
        this.shopName,
        this.ownerName,
        this.shopNumber,
        this.shopAddress,
        this.shopMessage,
        this.shopDetails,
        this.shopImage,
        this.facebook,
        this.google,
        this.twitter,
        this.linkedin,
        this.ban});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    email = json['email'];
    fax = json['fax'];
    type = json['type'];
    propic = json['propic'];
    zipCode = json['zip_code'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    balance = json['balance'];
    emailVerified = json['email_verified'];
    affilateCode = json['affilate_code'];
    affilateIncome = json['affilate_income'];
    affilateLink = json['affilate_link'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopNumber = json['shop_number'];
    shopAddress = json['shop_address'];
    shopMessage = json['shop_message'];
    shopDetails = json['shop_details'];
    shopImage = json['shop_image'];
    facebook = json['facebook'] != null
        ? new Facebook.fromJson(json['facebook'])
        : null;
    google =
    json['google'] != null ? new Google.fromJson(json['google']) : null;
    twitter =
    json['twitter'] != null ? new Google.fromJson(json['twitter']) : null;
    linkedin =
    json['linkedin'] != null ? new Google.fromJson(json['linkedin']) : null;
    ban = json['ban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['fax'] = this.fax;
    data['type'] = this.type;
    data['propic'] = this.propic;
    data['zip_code'] = this.zipCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['address'] = this.address;
    data['balance'] = this.balance;
    data['email_verified'] = this.emailVerified;
    data['affilate_code'] = this.affilateCode;
    data['affilate_income'] = this.affilateIncome;
    data['affilate_link'] = this.affilateLink;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['shop_number'] = this.shopNumber;
    data['shop_address'] = this.shopAddress;
    data['shop_message'] = this.shopMessage;
    data['shop_details'] = this.shopDetails;
    data['shop_image'] = this.shopImage;
    if (this.facebook != null) {
      data['facebook'] = this.facebook.toJson();
    }
    if (this.google != null) {
      data['google'] = this.google.toJson();
    }
    if (this.twitter != null) {
      data['twitter'] = this.twitter.toJson();
    }
    if (this.linkedin != null) {
      data['linkedin'] = this.linkedin.toJson();
    }
    data['ban'] = this.ban;
    return data;
  }
}

class Facebook {
  String url;
  String visibility;

  Facebook({this.url, this.visibility});

  Facebook.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['visibility'] = this.visibility;
    return data;
  }
}

class Google {
  String url;
  String status;

  Google({this.url, this.status});

  Google.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}

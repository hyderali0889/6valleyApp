class UserDashboard {
  bool status;
  UserData data;
  List error;

  UserDashboard({this.status, this.data, this.error});

  UserDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  Customer user;
  String affilateIncome;
  String currentBalance;
  int completedOrders;
  int pendingOrders;

  UserData(
      {this.user,
        this.affilateIncome,
        this.currentBalance,
        this.completedOrders,
        this.pendingOrders});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Customer.fromJson(json['user']) : null;
    affilateIncome = json['affilate_income'];
    currentBalance = json['current_balance'];
    completedOrders = json['completed_orders'];
    pendingOrders = json['pending_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['affilate_income'] = this.affilateIncome;
    data['current_balance'] = this.currentBalance;
    data['completed_orders'] = this.completedOrders;
    data['pending_orders'] = this.pendingOrders;
    return data;
  }
}

class Customer {
  int id;
  String name;
  String photo;
  String zip;
  String city;
  String country;
  String state;
  String address;
  String phone;
  String fax;
  String email;
  String createdAt;
  String updatedAt;
  String isProvider;
  String status;
  String verificationLink;
  String emailVerified;
  String affilateCode;
  String affilateIncome;
  var shopName;
  var ownerName;
  var shopNumber;
  var shopAddress;
  var regNumber;
  var shopMessage;
  var shopDetails;
  var shopImage;
  var fUrl;
  var gUrl;
  var tUrl;
  var lUrl;
  String isVendor;
  String fCheck;
  String gCheck;
  String tCheck;
  String lCheck;
  String mailSent;
  String shippingCost;
  String currentBalance;
  var date;
  String ban;
  String balance;

  Customer(
      {this.id,
        this.name,
        this.photo,
        this.zip,
        this.city,
        this.country,
        this.state,
        this.address,
        this.phone,
        this.fax,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.isProvider,
        this.status,
        this.verificationLink,
        this.emailVerified,
        this.affilateCode,
        this.affilateIncome,
        this.shopName,
        this.ownerName,
        this.shopNumber,
        this.shopAddress,
        this.regNumber,
        this.shopMessage,
        this.shopDetails,
        this.shopImage,
        this.fUrl,
        this.gUrl,
        this.tUrl,
        this.lUrl,
        this.isVendor,
        this.fCheck,
        this.gCheck,
        this.tCheck,
        this.lCheck,
        this.mailSent,
        this.shippingCost,
        this.currentBalance,
        this.date,
        this.ban,
        this.balance});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    zip = json['zip'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    address = json['address'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isProvider = json['is_provider'];
    status = json['status'];
    verificationLink = json['verification_link'];
    emailVerified = json['email_verified'];
    affilateCode = json['affilate_code'];
    affilateIncome = json['affilate_income'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopNumber = json['shop_number'];
    shopAddress = json['shop_address'];
    regNumber = json['reg_number'];
    shopMessage = json['shop_message'];
    shopDetails = json['shop_details'];
    shopImage = json['shop_image'];
    fUrl = json['f_url'];
    gUrl = json['g_url'];
    tUrl = json['t_url'];
    lUrl = json['l_url'];
    isVendor = json['is_vendor'];
    fCheck = json['f_check'];
    gCheck = json['g_check'];
    tCheck = json['t_check'];
    lCheck = json['l_check'];
    mailSent = json['mail_sent'];
    shippingCost = json['shipping_cost'];
    currentBalance = json['current_balance'];
    date = json['date'];
    ban = json['ban'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_provider'] = this.isProvider;
    data['status'] = this.status;
    data['verification_link'] = this.verificationLink;
    data['email_verified'] = this.emailVerified;
    data['affilate_code'] = this.affilateCode;
    data['affilate_income'] = this.affilateIncome;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['shop_number'] = this.shopNumber;
    data['shop_address'] = this.shopAddress;
    data['reg_number'] = this.regNumber;
    data['shop_message'] = this.shopMessage;
    data['shop_details'] = this.shopDetails;
    data['shop_image'] = this.shopImage;
    data['f_url'] = this.fUrl;
    data['g_url'] = this.gUrl;
    data['t_url'] = this.tUrl;
    data['l_url'] = this.lUrl;
    data['is_vendor'] = this.isVendor;
    data['f_check'] = this.fCheck;
    data['g_check'] = this.gCheck;
    data['t_check'] = this.tCheck;
    data['l_check'] = this.lCheck;
    data['mail_sent'] = this.mailSent;
    data['shipping_cost'] = this.shippingCost;
    data['current_balance'] = this.currentBalance;
    data['date'] = this.date;
    data['ban'] = this.ban;
    data['balance'] = this.balance;
    return data;
  }
}

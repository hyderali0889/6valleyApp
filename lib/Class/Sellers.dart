class Sellers {
  bool status;
  List<SellerData> data;

  Sellers({this.status, this.data});

  Sellers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<SellerData>();
      json['data'].forEach((v) {
        data.add(new SellerData.fromJson(v));
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

class SellerData {
  int id;
  int shopId;
  String shopName;
  String ownerName;
  String shopAddress;
  String shopLink;
  bool loading;

  SellerData({this.id,this.shopId,this.shopName, this.ownerName, this.shopAddress, this.shopLink,this.loading});

  SellerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopAddress = json['shop_address'];
    shopLink = json['shop_link'];
    loading=false;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['shop_address'] = this.shopAddress;
    data['shop_link'] = this.shopLink;
    return data;
  }
}

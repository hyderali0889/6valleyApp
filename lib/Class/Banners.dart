import 'package:geniouscart/URL/AppConstant.dart';

class Banners {
  bool status;
  List<BannerData> data;

  Banners({this.status, this.data});

  static makeBannersApi(String url,{String type}){
    return url.replaceAll('${AppConstant.add}${AppConstant.type}', type);
  }

  Banners.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<BannerData>();
      json['data'].forEach((v) {
        data.add(new BannerData.fromJson(v));
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

class BannerData {
  int id;
  String image;
  String link;

  BannerData({this.id, this.image, this.link});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
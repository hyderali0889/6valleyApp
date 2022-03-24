class FeaturedBanners {
  bool status;
  List<FeaturedBannersData> data;

  FeaturedBanners({this.status, this.data});

  FeaturedBanners.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<FeaturedBannersData>();
      json['data'].forEach((v) {
        data.add(new FeaturedBannersData.fromJson(v));
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

class FeaturedBannersData {
  int id;
  String link;
  String photo;

  FeaturedBannersData({this.id, this.link, this.photo});

  FeaturedBannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['photo'] = this.photo;
    return data;
  }
}
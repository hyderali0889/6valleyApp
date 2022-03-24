class HomeSlider {
  bool status;
  List<HomeSliderData> data;

  HomeSlider({this.status, this.data});

  HomeSlider.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<HomeSliderData>();
      json['data'].forEach((v) {
        data.add(new HomeSliderData.fromJson(v));
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

class HomeSliderData {
  int id;
  String subtitle;
  String title;
  String smallText;
  String image;
  String redirectUrl;
  Null createdAt;
  Null updatedAt;

  HomeSliderData(
      {this.id,
        this.subtitle,
        this.title,
        this.smallText,
        this.image,
        this.redirectUrl,
        this.createdAt,
        this.updatedAt});

  HomeSliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subtitle = json['subtitle'];
    title = json['title'];
    smallText = json['small_text'];
    image = json['image'];
    redirectUrl = json['redirect_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subtitle'] = this.subtitle;
    data['title'] = this.title;
    data['small_text'] = this.smallText;
    data['image'] = this.image;
    data['redirect_url'] = this.redirectUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
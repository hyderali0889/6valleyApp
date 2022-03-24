class Services {
  bool status;
  List<ServicesData> data;

  Services({this.status, this.data});

  Services.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<ServicesData>();
      json['data'].forEach((v) {
        data.add(new ServicesData.fromJson(v));
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

class ServicesData {
  int id;
  String title;
  String details;
  String photo;

  ServicesData({this.id, this.title, this.details, this.photo});

  ServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['photo'] = this.photo;
    return data;
  }
}
class Gateways {
  bool status;
  List<GatewayData> data;
  List error;

  Gateways({this.status, this.data, this.error});

  Gateways.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<GatewayData>();
      json['data'].forEach((v) {
        data.add(new GatewayData.fromJson(v));
      });
    }
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
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.error != null) {
      data['error'] = this.error.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GatewayData {
  String name;
  List<NeedData> data;

  GatewayData({this.name, this.data});

  GatewayData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      data = new List<NeedData>();
      json['data'].forEach((v) {
        data.add(new NeedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NeedData {
  String label;
  String type;
  String key;

  NeedData({this.label, this.type, this.key});

  NeedData.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    type = json['type'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['type'] = this.type;
    data['key'] = this.key;
    return data;
  }
}

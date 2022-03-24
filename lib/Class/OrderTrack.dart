class OrderTrack {
  bool status;
  List<TrackData> data;
  List error;

  OrderTrack({this.status, this.data, this.error});

  OrderTrack.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<TrackData>();
      json['data'].forEach((v) {
        data.add(new TrackData.fromJson(v));
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

class TrackData {
  int id;
  String orderId;
  String title;
  String text;
  String createdAt;
  String updatedAt;

  TrackData(
      {this.id,
        this.orderId,
        this.title,
        this.text,
        this.createdAt,
        this.updatedAt});

  TrackData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    title = json['title'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


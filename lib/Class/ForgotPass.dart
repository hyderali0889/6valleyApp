class ForgotPass {
  bool status;
  Data data;
  List error;

  ForgotPass({this.status, this.data, this.error});

  ForgotPass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int userId;
  String resetToken;

  Data({this.userId, this.resetToken});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    resetToken = json['reset_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['reset_token'] = this.resetToken;
    return data;
  }
}


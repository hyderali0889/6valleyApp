class Withdraw {
  bool status;
  List<WithdrawData> data;

  Withdraw({this.status, this.data});

  Withdraw.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<WithdrawData>();
      json['data'].forEach((v) {
        data.add(new WithdrawData.fromJson(v));
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

class WithdrawData {
  int id;
  String amount;
  String method;
  String accEmail;
  String iban;
  String country;
  String accName;
  String address;
  String swift;
  String reference;
  double fee;
  String status;
  String createdAt;

  WithdrawData(
      {this.id,
        this.amount,
        this.method,
        this.accEmail,
        this.iban,
        this.country,
        this.accName,
        this.address,
        this.swift,
        this.reference,
        this.fee,
        this.status,
        this.createdAt});

  WithdrawData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    method = json['method'];
    accEmail = json['acc_email'];
    iban = json['iban'];
    country = json['country'];
    accName = json['acc_name'];
    address = json['address'];
    swift = json['swift'];
    reference = json['reference'];
    fee = json['fee']!=null ? double.parse(json['fee'].toString()) : 0;
    status = json['status'];
    createdAt = json['created_at']['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['method'] = this.method;
    data['acc_email'] = this.accEmail;
    data['iban'] = this.iban;
    data['country'] = this.country;
    data['acc_name'] = this.accName;
    data['address'] = this.address;
    data['swift'] = this.swift;
    data['reference'] = this.reference;
    data['fee'] = this.fee;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

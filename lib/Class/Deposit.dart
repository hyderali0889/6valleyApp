class Deposit {
  bool status;
  List<DepositData> data;
  List error;

  Deposit({this.status, this.data, this.error});

  Deposit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<DepositData>();
      json['data'].forEach((v) {
        data.add(new DepositData.fromJson(v));
      });
    }
    try {
      if (json['error'] != null) {
        error = new List();
        json['error'].forEach((v) {
          error.add(v);
        });
      }
    }catch(e){

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

class DepositData {
  int id;
  String userId;
  String currency;
  String currencyCode;
  String amount;
  String currencyValue;
  String method;
  String txnid;
  var flutterId;
  String status;
  String depositNumber;
  String createdAt;
  String updatedAt;
  String paymentUrl;

  DepositData(
      {this.id,
        this.userId,
        this.currency,
        this.currencyCode,
        this.amount,
        this.currencyValue,
        this.method,
        this.txnid,
        this.flutterId,
        this.status,
        this.depositNumber,
        this.createdAt,
        this.paymentUrl,
        this.updatedAt});

  DepositData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    amount = json['amount'];
    currencyValue = json['currency_value'];
    method = json['method'];
    txnid = json['txnid'];
    flutterId = json['flutter_id'];
    status = json['status'];
    depositNumber = json['deposit_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['amount'] = this.amount;
    data['currency_value'] = this.currencyValue;
    data['method'] = this.method;
    data['txnid'] = this.txnid;
    data['flutter_id'] = this.flutterId;
    data['status'] = this.status;
    data['deposit_number'] = this.depositNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}

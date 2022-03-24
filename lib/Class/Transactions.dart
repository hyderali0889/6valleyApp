class Transactions {
  bool status;
  List<TransactionData> data;
  List error;

  Transactions({this.status, this.data, this.error});

  Transactions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<TransactionData>();
      json['data'].forEach((v) {
        data.add(new TransactionData.fromJson(v));
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

class TransactionData {
  int id;
  String userId;
  String txnNumber;
  String amount;
  String currencySign;
  String currencyCode;
  String currencyValue;
  String method;
  String txnid;
  String details;
  String type;
  String createdAt;
  String updatedAt;

  TransactionData(
      {this.id,
        this.userId,
        this.txnNumber,
        this.amount,
        this.currencySign,
        this.currencyCode,
        this.currencyValue,
        this.method,
        this.txnid,
        this.details,
        this.type,
        this.createdAt,
        this.updatedAt});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    txnNumber = json['txn_number'];
    amount = json['amount'];
    currencySign = json['currency_sign'];
    currencyCode = json['currency_code'];
    currencyValue = json['currency_value'];
    method = json['method'];
    txnid = json['txnid'];
    details = json['details'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['txn_number'] = this.txnNumber;
    data['amount'] = this.amount;
    data['currency_sign'] = this.currencySign;
    data['currency_code'] = this.currencyCode;
    data['currency_value'] = this.currencyValue;
    data['method'] = this.method;
    data['txnid'] = this.txnid;
    data['details'] = this.details;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

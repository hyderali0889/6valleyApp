class Currencies {
  bool status;
  List<Currency> data;
  List error;

  Currencies({this.status, this.data, this.error});

  Currencies.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Currency>();
      json['data'].forEach((v) {
        data.add(new Currency.fromJson(v));
      });
    }
    if (json['error'] != null) {
      error = new List<Null>();
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

class Currency {
  int id;
  String name;
  String sign;
  String value;
  String isDefault;

  Currency({this.id, this.name, this.sign, this.value, this.isDefault});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sign = json['sign'];
    value = json['value'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sign'] = this.sign;
    data['value'] = this.value;
    data['is_default'] = this.isDefault;
    return data;
  }
}

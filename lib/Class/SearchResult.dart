import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/main.dart';

class SearchResult {
  bool status;
  List<SearchData> data;

  SearchResult({this.status, this.data});

  //min=10&max=100&sort=price_asc&term=Physical Product
  static String makeUrl(String url,{String min,String max,String sort,String term}){
    String finalUrl=url;
    if(min!=null){
      finalUrl+='min=$min&';
    }
    if(max!=null){
      finalUrl+='max=$max&';
    }
    if(sort!=null){
      finalUrl+='sort=${AppConstant.sortList[language.Product_SortList.indexOf(sort)]}&';
    }
    if(term!=null){
      finalUrl+='term=$term';
    }
    return finalUrl;
  }

  SearchResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<SearchData>();
      json['data'].forEach((v) {
        data.add(new SearchData.fromJson(v));
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

class SearchData {
  int id;
  String title;
  String thumbnail;
  int rating;
  String currentPrice;
  String previousPrice;
  CreatedAt createdAt;
  CreatedAt updatedAt;
  String saleEndDate;

  SearchData(
      {this.id,
        this.title,
        this.thumbnail,
        this.rating,
        this.currentPrice,
        this.previousPrice,
        this.createdAt,
        this.updatedAt,
        this.saleEndDate});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    currentPrice = json['current_price'].toString();
    previousPrice = json['previous_price'].toString();
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new CreatedAt.fromJson(json['updated_at'])
        : null;
    saleEndDate = json['sale_end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['rating'] = this.rating;
    data['current_price'] = this.currentPrice;
    data['previous_price'] = this.previousPrice;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    data['sale_end_date'] = this.saleEndDate;
    return data;
  }
}


class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({this.date, this.timezoneType, this.timezone});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

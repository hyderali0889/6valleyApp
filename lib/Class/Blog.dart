class Blog {
  bool status;
  List<BlogData> data;

  Blog({this.status, this.data});

  Blog.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<BlogData>();
      json['data'].forEach((v) {
        data.add(new BlogData.fromJson(v));
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

class BlogData {
  int id;
  String title;
  String details;
  String photo;
  String source;
  String views;
  String status;
  String metaTag;
  String metaDescription;
  String tags;
  CreatedAt createdAt;

  BlogData(
      {this.id,
        this.title,
        this.details,
        this.photo,
        this.source,
        this.views,
        this.status,
        this.metaTag,
        this.metaDescription,
        this.tags,
        this.createdAt});

  BlogData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    photo = json['photo'];
    source = json['source'];
    views = json['views'];
    status = json['status'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    tags = json['tags'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['photo'] = this.photo;
    data['source'] = this.source;
    data['views'] = this.views;
    data['status'] = this.status;
    data['meta_tag'] = this.metaTag;
    data['meta_description'] = this.metaDescription;
    data['tags'] = this.tags;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
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

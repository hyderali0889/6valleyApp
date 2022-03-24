class AllDetails {
  bool status;
  List<Data> data;

  AllDetails({this.status, this.data});

  AllDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String title;
  String slug;
  String content;
  String metaTag;
  String metaDescription;
  String header;
  String footer;

  Data(
      {this.id,
        this.title,
        this.slug,
        this.content,
        this.metaTag,
        this.metaDescription,
        this.header,
        this.footer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    header = json['header'];
    footer = json['footer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['content'] = this.content;
    data['meta_tag'] = this.metaTag;
    data['meta_description'] = this.metaDescription;
    data['header'] = this.header;
    data['footer'] = this.footer;
    return data;
  }
}

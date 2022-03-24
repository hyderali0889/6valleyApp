class SectionCustomization {
  bool status;
  SectionData data;
  List error;

  SectionCustomization({this.status, this.data, this.error});

  SectionCustomization.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SectionData.fromJson(json['data']) : null;
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

class SectionData {
  int id;
  String contactSuccess;
  String contactEmail;
  String contactTitle;
  String contactText;
  String sideTitle;
  String sideText;
  String street;
  String phone;
  String fax;
  String email;
  String site;
  String slider;
  String service;
  String featured;
  String smallBanner;
  String best;
  String topRated;
  String largeBanner;
  String big;
  String hotSale;
  String partners;
  String reviewBlog;
  String bestSellerBanner;
  String bestSellerBannerLink;
  String bigSaveBanner;
  String bigSaveBannerLink;
  String bottomSmall;
  String flashDeal;
  String bestSellerBanner1;
  String bestSellerBannerLink1;
  String bigSaveBanner1;
  String bigSaveBannerLink1;
  String featuredCategory;

  SectionData(
      {this.id,
        this.contactSuccess,
        this.contactEmail,
        this.contactTitle,
        this.contactText,
        this.sideTitle,
        this.sideText,
        this.street,
        this.phone,
        this.fax,
        this.email,
        this.site,
        this.slider,
        this.service,
        this.featured,
        this.smallBanner,
        this.best,
        this.topRated,
        this.largeBanner,
        this.big,
        this.hotSale,
        this.partners,
        this.reviewBlog,
        this.bestSellerBanner,
        this.bestSellerBannerLink,
        this.bigSaveBanner,
        this.bigSaveBannerLink,
        this.bottomSmall,
        this.flashDeal,
        this.bestSellerBanner1,
        this.bestSellerBannerLink1,
        this.bigSaveBanner1,
        this.bigSaveBannerLink1,
        this.featuredCategory});

  SectionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactSuccess = json['contact_success'];
    contactEmail = json['contact_email'];
    contactTitle = json['contact_title'];
    contactText = json['contact_text'];
    sideTitle = json['side_title'];
    sideText = json['side_text'];
    street = json['street'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    site = json['site'];
    slider = json['slider'];
    service = json['service'];
    featured = json['featured'];
    smallBanner = json['small_banner'];
    best = json['best'];
    topRated = json['top_rated'];
    largeBanner = json['large_banner'];
    big = json['big'];
    hotSale = json['hot_sale'];
    partners = json['partners'];
    reviewBlog = json['review_blog'];
    bestSellerBanner = json['best_seller_banner'];
    bestSellerBannerLink = json['best_seller_banner_link'];
    bigSaveBanner = json['big_save_banner'];
    bigSaveBannerLink = json['big_save_banner_link'];
    bottomSmall = json['bottom_small'];
    flashDeal = json['flash_deal'];
    bestSellerBanner1 = json['best_seller_banner1'];
    bestSellerBannerLink1 = json['best_seller_banner_link1'];
    bigSaveBanner1 = json['big_save_banner1'];
    bigSaveBannerLink1 = json['big_save_banner_link1'];
    featuredCategory = json['featured_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_success'] = this.contactSuccess;
    data['contact_email'] = this.contactEmail;
    data['contact_title'] = this.contactTitle;
    data['contact_text'] = this.contactText;
    data['side_title'] = this.sideTitle;
    data['side_text'] = this.sideText;
    data['street'] = this.street;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['site'] = this.site;
    data['slider'] = this.slider;
    data['service'] = this.service;
    data['featured'] = this.featured;
    data['small_banner'] = this.smallBanner;
    data['best'] = this.best;
    data['top_rated'] = this.topRated;
    data['large_banner'] = this.largeBanner;
    data['big'] = this.big;
    data['hot_sale'] = this.hotSale;
    data['partners'] = this.partners;
    data['review_blog'] = this.reviewBlog;
    data['best_seller_banner'] = this.bestSellerBanner;
    data['best_seller_banner_link'] = this.bestSellerBannerLink;
    data['big_save_banner'] = this.bigSaveBanner;
    data['big_save_banner_link'] = this.bigSaveBannerLink;
    data['bottom_small'] = this.bottomSmall;
    data['flash_deal'] = this.flashDeal;
    data['best_seller_banner1'] = this.bestSellerBanner1;
    data['best_seller_banner_link1'] = this.bestSellerBannerLink1;
    data['big_save_banner1'] = this.bigSaveBanner1;
    data['big_save_banner_link1'] = this.bigSaveBannerLink1;
    data['featured_category'] = this.featuredCategory;
    return data;
  }
}


class SocialSetting {
  bool status;
  Data data;

  SocialSetting({this.status, this.data});

  SocialSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String facebook;
  String gplus;
  String twitter;
  String linkedin;
  String dribble;
  String fStatus;
  String gStatus;
  String tStatus;
  String lStatus;
  String dStatus;
  String fCheck;
  String gCheck;
  String fclientId;
  String fclientSecret;
  String fredirect;
  String gclientId;
  String gclientSecret;
  String gredirect;

  Data(
      {this.id,
        this.facebook,
        this.gplus,
        this.twitter,
        this.linkedin,
        this.dribble,
        this.fStatus,
        this.gStatus,
        this.tStatus,
        this.lStatus,
        this.dStatus,
        this.fCheck,
        this.gCheck,
        this.fclientId,
        this.fclientSecret,
        this.fredirect,
        this.gclientId,
        this.gclientSecret,
        this.gredirect});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facebook = json['facebook'];
    gplus = json['gplus'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    dribble = json['dribble'];
    fStatus = json['f_status'];
    gStatus = json['g_status'];
    tStatus = json['t_status'];
    lStatus = json['l_status'];
    dStatus = json['d_status'];
    fCheck = json['f_check'];
    gCheck = json['g_check'];
    fclientId = json['fclient_id'];
    fclientSecret = json['fclient_secret'];
    fredirect = json['fredirect'];
    gclientId = json['gclient_id'];
    gclientSecret = json['gclient_secret'];
    gredirect = json['gredirect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facebook'] = this.facebook;
    data['gplus'] = this.gplus;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['dribble'] = this.dribble;
    data['f_status'] = this.fStatus;
    data['g_status'] = this.gStatus;
    data['t_status'] = this.tStatus;
    data['l_status'] = this.lStatus;
    data['d_status'] = this.dStatus;
    data['f_check'] = this.fCheck;
    data['g_check'] = this.gCheck;
    data['fclient_id'] = this.fclientId;
    data['fclient_secret'] = this.fclientSecret;
    data['fredirect'] = this.fredirect;
    data['gclient_id'] = this.gclientId;
    data['gclient_secret'] = this.gclientSecret;
    data['gredirect'] = this.gredirect;
    return data;
  }
}

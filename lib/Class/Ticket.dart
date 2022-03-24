class Ticket {
  bool status;
  List<TicketData> data;
  List error;

  Ticket({this.status, this.data, this.error});

  Ticket.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<TicketData>();
      json['data'].forEach((v) {
        data.add(new TicketData.fromJson(v));
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

class TicketData {
  int id;
  String userId;
  String subject;
  String message;
  String type;
  List<Messages> messages;
  String createdAt;
  String updatedAt;

  TicketData(
      {this.id,
        this.userId,
        this.subject,
        this.message,
        this.type,
        this.messages,
        this.createdAt,
        this.updatedAt});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subject = json['subject'];
    message = json['message'];
    type = json['type'];
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt;
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt;
    }
    return data;
  }
}

class Messages {
  int id;
  String userId;
  String conversationId;
  String message;
  String createdAt;
  String updatedAt;

  Messages(
      {this.id,
        this.userId,
        this.conversationId,
        this.message,
        this.createdAt,
        this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    conversationId = json['conversation_id'];
    message = json['message'];
    createdAt = json['created_at'] ;
    updatedAt = json['updated_at'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['conversation_id'] = this.conversationId;
    data['message'] = this.message;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt;
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt;
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

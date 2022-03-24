import 'package:geniouscart/main.dart';

class UserMessages {
  bool status;
  List<TicketData> data;
  List error;

  UserMessages({this.status, this.data, this.error});

  UserMessages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<TicketData>();
      json['data'].forEach((v) {
        data.add(new TicketData.fromJson(v));
      });
    }
    if (json['error'] != null) {
      error = new List ();
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
  String subject;
  String sentUser;
  String recievedUser;
  String message;
  List<Messages> messages;
  String createdAt;
  String updatedAt;

  TicketData(
      {this.id,
        this.subject,
        this.sentUser,
        this.recievedUser,
        this.message,
        this.messages,
        this.createdAt,
        this.updatedAt});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    sentUser = json['sent_user'];
    recievedUser = json['recieved_user'];
    message = json['message'];
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
    data['subject'] = this.subject;
    data['sent_user'] = this.sentUser;
    data['recieved_user'] = this.recievedUser;
    data['message'] = this.message;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Messages {
  int id;
  String conversationSubject;
  String sentUser;
  int sentUserId;
  String sentUserImage;
  String recievedUser;
  String message;
  String createdAt;
  String updatedAt;

  Messages(
      {this.id,
        this.conversationSubject,
        this.sentUser,
        this.sentUserId,
        this.sentUserImage,
        this.recievedUser,
        this.message,
        this.createdAt,
        this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      conversationSubject = json['conversation_subject'];
      sentUser = json['sent_user'];
      sentUserId = json['sent_user_id'];
      sentUserImage = json['sent_user_image'];
      recievedUser = json['recieved_user'];
      message = json['message'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversation_subject'] = this.conversationSubject;
    data['sent_user'] = this.sentUser;
    data['sent_user_id'] = this.sentUserId;
    data['sent_user_image'] = this.sentUserImage;
    data['recieved_user'] = this.recievedUser;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

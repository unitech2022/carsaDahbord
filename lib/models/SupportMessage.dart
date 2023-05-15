import 'package:flutter_web_dashboard/models/user_model.dart';

class SupportMessage{
late int id;
late String message;
late String userId;
late var sender;
late String date;

SupportMessage({  required this.message, required this.userId, required this.sender,required this.date});

SupportMessage.fromJson(Map<String, dynamic> json) {
id = json['id'];
userId = json['userId'];
message = json['message'];
sender = json['sender'];
date = json['date'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['message'] = this.message;
  data['userId'] = this.userId;
  data['sender'] = this.sender;
  data['date'] = this.date;
  return data;
}
}

class ResponseMessage {
  UserModel? sender;
  SupportMessage? support;


  ResponseMessage({this.sender, this.support});

  ResponseMessage.fromJson(Map<String, dynamic> json) {
    sender =
    json['sender'] != null ? new UserModel.fromJson(json['sender']) : null;
    support =
    json['support'] != null ? new SupportMessage.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }

}





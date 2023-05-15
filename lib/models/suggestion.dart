class Suggestion {
  int? id;
  String? userEmail;
  String? userName;
  String? userId;
  String? userPhone;
  String? message;
  String? createdAt;

  Suggestion(
      {this.id,
        this.userEmail,
        this.userName,
        this.userId,
        this.userPhone,
        this.message,
        this.createdAt});

  Suggestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userEmail = json['userEmail'];
    userName = json['userName'];
    userId = json['userId'];
    userPhone = json['userPhone'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userEmail'] = this.userEmail;
    data['userName'] = this.userName;
    data['userId'] = this.userId;
    data['userPhone'] = this.userPhone;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

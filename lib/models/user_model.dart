class UserModel {
  String? id;
  String? userName;
  String? fullName;
  String? imageUrl;
  String? status;
  String? role;
  String? createdAt;

  UserModel(
      {this.id,
        this.userName,
        this.fullName,
        this.imageUrl,
        this.status,
        this.role,
        this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    role = json['role'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['imageUrl'] = this.imageUrl??"";
    data['status'] = this.status??"";
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
class UserResponse {
  String? token;
  UserModel? user;
  var driver;
  List<String>? userRoles;
  String? expiration;

  UserResponse(
      {this.token, this.user, this.driver, this.userRoles, this.expiration});

  UserResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    driver = json['driver'];
    userRoles = json['userRoles'].cast<String>();
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['driver'] = driver;
    data['userRoles'] = userRoles;
    data['expiration'] = expiration;
    return data;
  }
}
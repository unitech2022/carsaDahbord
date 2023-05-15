class PostResponse {
  Post? post;
  String? imageUrlUser;
  String? nameUser;

  PostResponse({this.post, this.imageUrlUser, this.nameUser});

  PostResponse.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    imageUrlUser = json['imageUrlUser'];
    nameUser = json['nameUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    data['imageUrlUser'] = this.imageUrlUser;
    data['nameUser'] = this.nameUser;
    return data;
  }
}

class Post {
  int? id;
  int? acceptedOfferId;
  String? userId;
  int? status;
  String? images;
  String? phone;
  String? modelCar;
  String? colorCar;
  String? nameCar;
  String? desc;
  double? lat;
    double? lng;
  String? createdAt;

  Post(
      {this.id,
      this.acceptedOfferId,
      this.userId,
      this.status,
      this.images,
      this.phone,
      this.lat,
      this.lng,
      this.modelCar,
      this.colorCar,
      this.nameCar,
      this.desc,
      this.createdAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptedOfferId = json['acceptedOfferId'];
    userId = json['userId'];
    status = json['status'];
    images = json['images'];
    phone = json['phone'];
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    modelCar = json['modelCar'];
    colorCar = json['colorCar'];
    nameCar = json['nameCar'];
    desc = json['desc'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acceptedOfferId'] = this.acceptedOfferId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['images'] = this.images;
    data['phone'] = this.phone;
    data['modelCar'] = this.modelCar;
    data['colorCar'] = this.colorCar;
    data['nameCar'] = this.nameCar;
    data['desc'] = this.desc;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

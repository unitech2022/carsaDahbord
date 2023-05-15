class RateResponse {
  Rate? rate;
  String? userName;
  String? userImage;

  RateResponse({this.rate, this.userName, this.userImage});

  RateResponse.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] != null ? new Rate.fromJson(json['rate']) : null;
    userName = json['userName'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rate != null) {
      data['rate'] = this.rate!.toJson();
    }
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    return data;
  }
}

class Rate {
  int? id;
  int? workshopId;
  String? userId;
  String? comment;
  int? stare;
  String? createAte;

  Rate(
      {this.id,
      this.workshopId,
      this.userId,
      this.comment,
      this.stare,
      this.createAte});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workshopId = json['workshopId'];
    userId = json['userId'];
    comment = json['comment'];
    stare = json['stare'];
    createAte = json['createAte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workshopId'] = this.workshopId;
    data['userId'] = this.userId;
    data['comment'] = this.comment;
    data['stare'] = this.stare;
    data['createAte'] = this.createAte;
    return data;
  }
}

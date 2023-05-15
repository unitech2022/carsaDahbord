import 'package:flutter_web_dashboard/models/rate_response.dart';

class CategoryWork {
  int? id;
  String? name;

  CategoryWork({this.id, this.name});

  CategoryWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class Workshops {
  int? id;
  int? categoryId;
  String? name;
  String? desc;
  String? image;
  String? address;
  double? lat;
  double? rate;
  double? lng;
  String? phone;
  String? phoneWhats;
  int? status;

  Workshops(
      {this.id,
        this.categoryId,
        this.name,
        this.desc,
        this.image,
        this.address,
        this.lat,
        this.rate,
        this.lng,
        this.phone,
        this.phoneWhats,
        this.status});

  Workshops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    address = json['address'];
    lat = json['lat'].toDouble();;
    rate = json['rate'].toDouble();
    lng = json['lng'].toDouble();
    phone = json['phone'];
    phoneWhats = json['phoneWhats'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['rate'] = this.rate;
    data['lng'] = this.lng;
    data['phone'] = this.phone;
    data['phoneWhats'] = this.phoneWhats;
    data['status'] = this.status;
    return data;
  }
}
class WorkshopDetailsModel{

    Workshops? workshop;
  List<RateResponse>? rates;

  WorkshopDetailsModel({this.workshop, this.rates});

  WorkshopDetailsModel.fromJson(Map<String, dynamic> json) {
    workshop = json['workshop'] != null
        ? new Workshops.fromJson(json['workshop'])
        : null;
    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((v) {
        rates!.add( RateResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.toJson();
    }
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

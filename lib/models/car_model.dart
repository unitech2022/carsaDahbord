
class CarModel {
  int? id;
  int? carId;
  String? name;
  String? image;

  CarModel({this.id, this.carId, this.name, this.image});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carId'] = this.carId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
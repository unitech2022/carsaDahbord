import 'package:flutter_web_dashboard/models/producte_model.dart';

class OrderModel {
  String? userPhone;
  String? userName;
  String? userEmail;
  Order? order;
  Address? address;
 // List<ResponseOrder>? products;
  OrderModel(
      {this.userPhone,
        this.userName,
        this.userEmail,
        this.order,
        this.address});

  OrderModel.fromJson(Map<String, dynamic> json) {
    userPhone = json['userPhone'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    // if (json['products'] != null) {
    //   products = [];
    //   json['products'].forEach((v) {
    //     products!.add( ResponseOrder.fromJson(v));
    //   });
    }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPhone'] = this.userPhone;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    data['address'] = this.address;

    return data;
  }
}

class Order {
  int? id;
  String? userId;
  var price;
  var addressId;
  int? status;
  String? sellerId;
  String? createdAt;

  Order(
      {this.id,
        this.userId,
        this.price,
        this.addressId,
        this.status,
        this.sellerId,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    price = json['price'];
    addressId = json['addressId'];
    status = json['status'];
    sellerId = json['sellerId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['price'] = this.price;
    data['addressId'] = this.addressId;
    data['status'] = this.status;
    data['sellerId'] = this.sellerId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
class Address {
  int? id;
  String? userId;
  String? lable;
  var lat;
  var lng;
  String? createdAt;

  Address(
      {this.id, this.userId, this.lable, this.lat, this.lng, this.createdAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    lable = json['lable'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['lable'] = this.lable;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
class Cart {
  int? id;
  int? orderId;
  String? image;
  String? nameProduct;
  int? productId;
  var price;
  double? total;
  String? userId;
  int? quantity;

  Cart(
      {this.id,
        this.orderId,
        this.image,
        this.nameProduct,
        this.productId,
        this.price,
        this.total,
        this.userId,
        this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    image = json['image'];
    nameProduct = json['nameProduct'];
    productId = json['productId'];
    price = json['price'];
    total = json['total'];
    userId = json['userId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['image'] = this.image;
    data['nameProduct'] = this.nameProduct;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['total'] = this.total;
    data['userId'] = this.userId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class ResponseOrder{

  Cart? cartModel;
  ProducteModel? productModel;

  ResponseOrder({this.cartModel, this.productModel});

  ResponseOrder.fromJson(Map<String, dynamic> json) {
    cartModel = json['cartModel'] != null
        ?  Cart.fromJson(json['cartModel'])
        : null;
    productModel = json['productModel'] != null
        ? new ProducteModel.fromJson(json['productModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartModel != null) {
      data['cartModel'] = this.cartModel!.toJson();
    }
    if (this.productModel != null) {
      data['productModel'] = this.productModel!.toJson();
    }
    return data;
  }
}
import 'package:flutter_web_dashboard/helpers/order_model.dart';

class HomeModel {
  int? countProduct;
  int? countCategories;
  int? countOrders;
  int? countUsers;
  List<OrderModel>? orders;

  HomeModel(
      {this.countProduct,
        this.countCategories,
        this.countOrders,
        this.countUsers,
        this.orders});

  HomeModel.fromJson(Map<String, dynamic> json) {
    countProduct = json['countProduct'];
    countCategories = json['countCategories'];
    countOrders = json['countOrders'];
    countUsers = json['countUsers'];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders!.add( OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countProduct'] = this.countProduct;
    data['countCategories'] = this.countCategories;
    data['countOrders'] = this.countOrders;
    data['countUsers'] = this.countUsers;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



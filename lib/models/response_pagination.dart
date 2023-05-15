

import 'package:flutter_web_dashboard/models/producte_model.dart';

class ResponsePagination {
  List<ProducteModel>? items;
  int? currentPage;
  int? totalPage;

  ResponsePagination({this.items, this.currentPage, this.totalPage});

  ResponsePagination.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add( ProducteModel.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalPage'] = totalPage;
    return data;
  }
}

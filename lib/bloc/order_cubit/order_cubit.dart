import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/helpers/function_helper.dart';
import 'package:flutter_web_dashboard/helpers/order_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
import '../app_cubit/app_cubit.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);
  List<OrderModel> listOrders = [];

  bool loadOrders = false;

  getOrders({required endPoint}) async {
    listOrders = [];
    loadOrders = true;
    emit(GetOrdersLoadStat());
    var request = http.MultipartRequest('GET', Uri.parse(baseUrl + endPoint));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      listOrders = [];
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listOrders.add(OrderModel.fromJson(e));
      });
      loadOrders = false;
      print(listOrders.length.toString() + "ssssssssssssssss");
      emit(GetOrdersSuccessStat(listOrders));
    } else {
      loadOrders = false;
      print(response.statusCode);
      emit(GetOrdersErrorStat("errrror${response.statusCode}"));
    }
  }



  String? currentValue;

  void changeValue(value) {
    currentValue = value;
    emit(ChangeValue());
  }

  bool loadUpdate = false;

  updateStatusOrder({status, id}) async {
    loadUpdate = true;
    emit(UpdateOrderLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl+'order/update-status-Order'));
    request.fields.addAll({'status': status.toString(), 'id': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // var responseBody = await response.stream.bytesToString();
      print("okkkkkkkkkkkkkkk");

      // final data = jsonDecode(responseBody);
      //
      // Order order = Order.fromJson(data);
      // currentValue = status[status];
      getOrders(endPoint: "order/get-all-Orders");
      loadUpdate = false;
      emit(UpdateOrderSuccessStat());
    } else {
      print(response.statusCode);
      loadUpdate = false;
      emit(UpdateOrderErrorStat("error"));
    }
  }


  bool loadDelete = false;

  deleteOrder({id, context,status}) async {
    loadDelete = true;
    emit(DeleteOrderLoadStat());



    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "order/delete-Order-admin"));
    request.fields.addAll({'id': '$id'});


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      loadDelete = false;
      if(status==0){
        AppCubit.get(context).getHomeData();
      }else {
        getOrders(endPoint: "order/get-all-Orders");
      }


      emit(DeleteOrderSuccessStat("تم حذف العنصر"));
    } else {
      loadDelete = false;
      print(response.statusCode.toString());
      emit(DeleteOrderErrorStat("حدث خطأ"));
    }
  }



  List<ResponseOrder> orderDetail = [];
  bool loadOrderDetails=false;
  getOrderDetails({orderId}) async {
    orderDetail = [];
    loadOrderDetails=true;
    emit(GetOrderDetailsLoad());

    // var headers = {
    //   "Authorization": token,
    //
    //   // If  needed
    // };

    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + "order/get-Order-details-admin"));
    request.fields.addAll({'orderId': orderId.toString()});



    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString()+"fjfff");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      orderDetail = [];
      jsonData.forEach((v) {
        orderDetail.add(ResponseOrder.fromJson(v));
      });
      loadOrderDetails=false;
      emit(GetOrderDetailsSuccess(orderDetail));
    } else {
      loadOrderDetails=false;

      emit(GetOrderDetailsError());
    }
  }


}

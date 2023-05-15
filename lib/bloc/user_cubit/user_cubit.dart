import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/helpers/functions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../constants/constans.dart';
import '../category_cubit/category_cubit.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());





  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);
  List<UserModel> listUsers = [];

  bool loadUsers = false;

  getUsers() async {
    listUsers = [];
    loadUsers = true;
    emit(GetUsersLoadStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "user/get-all"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listUsers.add(UserModel.fromJson(e));
      });
      loadUsers = false;
      emit(GetUsersSuccessStat(listUsers));
    } else {
      loadUsers = false;
      print(response.statusCode);
    }
  }


  sendNotification({required title,context,onSuccess})async{
emit(SendNotificationLoadStat());
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'api/notification/send/topic'));
    request.fields.addAll({
      'topice': 'user',
      'title': title,
      'body': 'اشعار تنبيهى',
      'subject': 'dd',
      'imageUrl': '20220412T091809.jpeg',
      'desc': 'ffgg'
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      HelperFunctions.slt.notifyUser(
        color: Colors.green,message: "تم ارسال الرسالة",context: context
      );
      onSuccess();
      emit(SendNotificationSuccessStat());
    }
    else {
    print(response.statusCode.toString());
    emit(SendNotificationErrorStat());
    }

  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/home_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
part 'app_state.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);


  HomeModel homeModel = HomeModel();
  bool load = false;
  getHomeData() async {
    load = true;
    emit(HomeGetDataLoad());
    var request =
    http.MultipartRequest('GET', Uri.parse(baseUrl + 'dashboard-home-admin'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      homeModel = HomeModel.fromJson(jsonData);

      load = false;
      emit(HomeLoadDataSuccess());
    } else {
      load = false;
      print("errrrrrrrrrror");
      emit(HomeLoadDataError());
    }
  }


}

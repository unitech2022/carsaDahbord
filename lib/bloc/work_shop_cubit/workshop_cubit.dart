import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/work_shop_cubit/workshop_state.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
import '../../helpers/function_helper.dart';
import '../../helpers/functions.dart';
import '../../models/rate_response.dart';
import '../../models/workshop_model.dart';

class WorkshopCubit extends Cubit<WorkshopState> {
  WorkshopCubit() : super(WorkshopStateInitial());
  static WorkshopCubit get(context) => BlocProvider.of<WorkshopCubit>(context);

  bool loadAdd = false;

  List<CategoryWork> categories = [];
  Future getCategoriesWork() async {
    categories = [];
    print("CategoryWORKShops");

    emit(GetCategoriesLoad());

    final response = await Dio().get(getCategoriesWorkshopsPath);
    print(response.statusCode.toString() + "CategoryWORKShops");
    if (response.statusCode == 200) {
      print(response.data);
      categories = [];
      response.data.forEach((e) {
        categories.add(CategoryWork.fromJson(e));
      });
      emit(GetCategoriesSuccess());
      if (categories.isNotEmpty) {
        getWorksById(categoryId: categories.first.id.toString());
      }
    } else {
      emit(GetCategoriesError());
    }
  }

  //get workshop by  id
  List<Workshops> workshops = [];
  bool loadWorkShops = false;
  Future getWorksById({categoryId}) async {
    loadWorkShops = true;
    emit(GetWorkshopByIdLoad());
    final response =
        await Dio().get(getWorkshopsByCatIdPath + "categoryId=$categoryId");
    print(response.statusCode.toString() + "CategoryWORKShops");

    if (response.statusCode == 200) {
      workshops = [];
      response.data.forEach((e) {
        workshops.add(Workshops.fromJson(e));
      });
      loadWorkShops = false;

      emit(GetWorkshopByIdSuccess(workshops));
    } else {
      emit(GetWorkshopByIdError(response.statusCode.toString()));
    }
  }

//add rate
  // bool loadAddRate = false;
  // Future addRate(Rate rate, context) async {
  //   loadAddRate = true;
  //   emit(AddRateWorkshopLoad());

  //   var request =
  //       http.MultipartRequest('POST', Uri.parse('$baseUrl/rate/add-rate'));
  //   request.fields.addAll({
  //     'WorkshopId': rate.workshopId.toString(),
  //     'UserId': currentUser!.id.toString(),
  //     'Comment': rate.comment!,
  //     'Stare': rate.stare.toString()
  //   });

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     String jsonsDataString = await response.stream.bytesToString();
  //     final jsonData = jsonDecode(jsonsDataString);

  //     loadAddRate = false;
  //     pop(context);

  //     getWorksById(rate.workshopId);
  //     emit(AddRateWorkshopSuccess(jsonData["message"]));
  //   } else {
  //     loadAddRate = false;
  //     print(response.statusCode.toString() + "add rate");
  //     emit(AddRateWorkshopError());
  //   }
  // }

//get rates
  List<RateResponse> rates = [];
  Future getRates({workshopId}) async {
    emit(RatingWorkshopLoad());

    var request =
        http.MultipartRequest('GET', Uri.parse('$baseUrl/rate/get-rates'));
    request.fields.addAll({'workShopId': workshopId.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      jsonData.forEach((v) {
        rates.add(RateResponse.fromJson(v));
      });
      emit(RatingWorkshopSuccess(rates));
    } else {
      print(response.statusCode.toString() + "add rate");
      emit(RatingWorkshopError());
    }
  }

// update rate
  // Future updateRate({workshopId, star, id}) async {
  //   emit(UpdateRateWorkshopLoad());
  //   var request =
  //       http.MultipartRequest('PUT', Uri.parse('$baseUrl/rate/update-rate'));
  //   request.fields.addAll({
  //     'WorkshopId': workshopId.toString(),
  //     'star': star.toString(),
  //     'id': id.toString()
  //   });

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     String jsonsDataString = await response.stream.bytesToString();
  //     final jsonData = jsonDecode(jsonsDataString);
  //     printFunction(jsonData.toString() + "WWWWWWWWW");
  //     emit(UpdateRateWorkshopSuccess(jsonData['message']));
  //   } else {
  //     print(response.statusCode.toString());
  //     emit(UpdateRateWorkshopError());
  //   }
  // }

  bool updateLoad = false;
  updateWorkShopStatus({id, status, cateId}) async {
    updateLoad = true;
   
    emit(UpdateWorkShopLoad());

var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'workshops/update-workshop-status'));
request.fields.addAll({
 'id': id.toString(), 'status': status.toString()
});

http.StreamedResponse response = await request.send();

    // final response = await Dio().post(baseUrl+'workshops/update-workshop-status',
    //     data: {'id': id.toString(), 'status': status.toString()});
    print(response.statusCode.toString() + "updated");

    if (response.statusCode == 200) {
      updateLoad = false;
      emit(UpdateWorkShopSuccess());
       getWorksById(categoryId: cateId);
    } else {
      updateLoad = false;
      emit(UpdateWorkShopError());
    }
  }

  int currentIndex = 1;
  changeIndex(newIndex) {
    currentIndex = newIndex;
    emit(ChangeIndexState());
  }
}





//'http://localhost:5000/workshops/get-workshop-by-CatId?itemsPerPage=10&page=1&categoryId'
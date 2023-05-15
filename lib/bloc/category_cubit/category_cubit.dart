
import 'package:flutter_web_dashboard/models/category_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../constants/constans.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);
  List<CategoryModel> listCategories = [];

  bool loadCategories = false;

  getCategories({required endPoint}) async {
    listCategories = [];
    loadCategories = true;
    emit(GetCategoriesLoadStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + endPoint));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listCategories.add(CategoryModel.fromJson(e));
      });
      loadCategories = false;
      emit(GetCategoriesSuccessStat(listCategories));
    } else {
      loadCategories = false;
      print(response.statusCode);
    }
  }

  bool loadAdd = false;

  Future addCategory({required category,required endPoint,status}) async {
    loadAdd = true;
    emit(AddCategoriesLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + endPoint));


    request.fields.addAll({'name': category.name, 'image': category.image});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAdd = false;
      if(status==0)
      getCategories(endPoint: "category/get-categories");
      else if(status==1)
        getBrands();
      else if(status==2)
        getCategories(endPoint: "slider/get-sliders");
      emit(AddCategoriesSuccessStat("success"));
      // getCategories();
    } else {
      loadAdd = false;
      print(response.reasonPhrase);
      emit(AddCategoriesErrorStat("Error"));
    }
  }

  //delete
  bool loadDelete = false;

  deleteCategory({id, context, required endPoint, status}) async {
    loadDelete = true;
    emit(GetCategoriesLoadStat());
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;

      emit(DeleteCategoriesSuccessStat("تم حذف العنصر"));
      if (status == 0)
        getCategories(endPoint: "category/get-categories");
      else if (status == 1) getBrands();
      else if(status==2)
        getCategories(endPoint: "slider/get-sliders");
    } else {
      loadDelete = false;
      print(response.reasonPhrase);
      emit(DeleteCategoriesErrorStat("حدث خطأ"));
    }
  }

  bool loadUpdate = false;

  Future updateCategory({required category,required endPoint,status}) async {
    loadUpdate = true;
    emit(UpdateCategoriesLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({
      'name': category.name,
      'image': category.image,
      'id': category.id.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      loadUpdate = false;

      if(status==0)
      getCategories(endPoint: "category/get-categories");
      else if(status==1)
        getBrands();
      else if(status==2)
        getCategories(endPoint: "slider/get-sliders");
      emit(UpdateCategoriesSuccessStat("success"));
      // getCategories();
    } else {
      loadUpdate = false;
      print(response.reasonPhrase);
      emit(UpdateCategoriesErrorStat("Error"));
    }
  }

  bool loadImage = false;

  Future uploadSelectedFile({required objFile}) async {
    loadImage = true;
    emit(UpdateCategoriesLoadImageStat());
    //---Create http package multipart request object

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl + "image/upload/car"),
    );
    //-----add other fields if needed

    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "file", objFile.readStream, objFile.size,
        filename: objFile.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
    loadImage = false;
    emit(UpdateCategoriesLoadedImageStat(result));
  }

  //==========================================================================
  //Brands
  bool loadBrands = false;
  List<CategoryModel> listBrands = [];

  getBrands() async {
    loadBrands = true;
    listBrands = [];
    emit(GetBrandsLoadStat());
    var request = http.Request('GET', Uri.parse(baseUrl + 'brand/get-brands'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      listBrands = [];
      data.forEach((e) {
        listBrands.add(CategoryModel.fromJson(e));
      });
      loadBrands = false;
      emit(GetBrandsSuccessStat(listBrands));
    } else {
      print(response.reasonPhrase);
      loadBrands = false;
      emit(GetBrandsErrorStat("Error"));
    }
  }

  CategoryModel? category;

  void changeValue(CategoryModel category2) {
    category = category2;
    emit(ChangeValueSubCategory());
  }

  CategoryModel? brand;

  void changeValueBrand(CategoryModel category2) {
    brand = category2;
    emit(ChangeValueSubCategory());
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/models/category_model.dart';
import 'package:flutter_web_dashboard/models/producte_model.dart';
import 'package:flutter_web_dashboard/models/response_pagination.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../constants/constans.dart';
import '../../models/car_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);
  bool loadGetProducts = false;
  List<ProducteModel> listProducts = [];

  getProducts() async {
    loadGetProducts = true;
    listProducts = [];
    emit(GetProductsLoadStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "product/get-products"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listProducts.add(ProducteModel.fromJson(e));
      });
      loadGetProducts = false;
      emit(GetProductsSuccessStat(listProducts));
    } else {
      print(response.statusCode);
      loadGetProducts = false;
      emit(GetProductsErrorStat("Error"));
    }
  }

  ResponsePagination? responsePagination;

// pagination
  getProductsPagination({page}) async {
    loadGetProducts = true;

    emit(GetProductsLoadPaginationStat());
    var request = http.Request(
        'GET',
        Uri.parse(
            baseUrl + 'product/get-products-admin?page=$page&itemsPerPage=20'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      responsePagination = ResponsePagination.fromJson(data);

      loadGetProducts = false;
      emit(GetProductsSuccessPaginationStat(responsePagination!));
    } else {
      print(response.statusCode);
      loadGetProducts = false;
      emit(GetProductsErrorPaginationStat("Error"));
    }
  }

  bool loadAddProduct = false;

  Future addProduct({required product}) async {
    loadAddProduct = true;
    emit(AddProductLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'product/add-product'));
    request.fields.addAll({
      'name': product.name,
      'image': product.image,
      'SellerId': product.sellerId,
      'Detail': product.detail,
      'carModelId':product.carModelId.toString(),
      'TimeDelivery': product.timeDelivery,
      'DetailsPrice': product.detailsPrice.toString(),
      'Price': product.price.toString(),
      'CategoryId': product.categoryId.toString(),
      'BrandId': product.brandId.toString(),
      'Status': '2',
      'OfferId': product.offerId.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAddProduct = false;
      getProducts();
      getProductsSlider();
      emit(AddProductSuccessStat("success"));
    } else {
      print(response.statusCode.toString());
      loadAddProduct = false;
      emit(AddProductErrorStat("Error"));
    }
  }

  Future addListProductFromExcelFile({products}) async {
    loadAddProduct = true;
    emit(AddProductLoadStat());
    var headers = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=UTF-8'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'product/add-product-list'));
    request.fields.addAll(products);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      loadAddProduct = false;
      getProducts();
      getProductsSlider();
      emit(AddProductSuccessStat("success"));
    } else {
      print(response.statusCode.toString());
      loadAddProduct = false;
      emit(AddProductErrorStat("Error"));
      print(response.reasonPhrase);
    }
  }

  bool loadDelete = false;

  deleteProduct({id, context}) async {
    loadDelete = true;
    emit(DeleteProductLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "product/delete-product"));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;
      getProducts();
      getProductsSlider();
      emit(DeleteProductSuccessStat("تم حذف العنصر"));
    } else {
      loadDelete = false;
      print(response.reasonPhrase);
      emit(DeleteProductErrorStat("حدث خطأ"));
    }
  }

  bool loadUpdate = false;

  Future updateProduct({required product}) async {
    loadUpdate = true;
    emit(UpdateProductLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "product/update-product"));
    request.fields.addAll({
      'name': product.name,
      'image': product.image,
      'carModelId':product.carModelId.toString(),
      'id': product.id.toString(),
      'OfferId': product.offerId.toString(),
      'TimeDelivery': product.timeDelivery,
      'DetailsPrice': product.detailsPrice.toString(),
      'SellerId': product.sellerId.toString(),
      'Detail': product.detail,
      'Price': product.price.toString(),
      'CategoryId': product.categoryId.toString(),
      'BrandId': product.brandId.toString(),
      'Status': product.status.toString(),
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      loadUpdate = false;
      getProducts();
      emit(UpdateProductSuccessStat("success"));
      // getCategories();
    } else {
      loadUpdate = false;
      print(response.reasonPhrase);
      emit(UpdateProductErrorStat("Error"));
    }
  }

  bool isChecked = false;

  changeCheckBox(bool checked) {
    isChecked = checked;
    print(isChecked);
    emit(ChangeCheckBox());
  }

  bool isCheckedTax = false;

  changeCheckBoxTax(bool checked) {
    isCheckedTax = checked;
    print(isCheckedTax);
    emit(ChangeCheckBox());
  }

  bool loadGetProductsSliders = false;
  List<ProducteModel> listProductsSliders = [];

  getProductsSlider() async {
    loadGetProductsSliders = true;
    listProductsSliders = [];
    emit(GetProductsLoadStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "product/get-products-slider"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listProductsSliders.add(ProducteModel.fromJson(e));
      });
      loadGetProductsSliders = false;
      emit(GetProductsSuccessStat(listProducts));
    } else {
      print(response.statusCode);
      loadGetProductsSliders = false;
      emit(GetProductsErrorStat("Error"));
    }
  }

// carModel  data
  bool loadCarModels = false;
  List<CarModel> carModels = [];
  getCarModels() async {
    carModels = [];
    loadCarModels = true;
    emit(GetCarModelsLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + 'carModel/get-carModels'));

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "carmodels");
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        carModels.add(CarModel.fromJson(e));
      });
      loadCarModels = false;
      emit(GetCarModelsSuccess());
    } else {
      loadCarModels = false;
      print(response.reasonPhrase);
      emit(GetCarModelsError());
    }
  }

  bool loadAddCarModel = false;

  Future addCaModel({required carModel, status}) async {
    loadAddCarModel = true;
    emit(AddCarModelsLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "carModel/add-carModel"));

    request.fields.addAll({
      'name': carModel.name,
      'image': carModel.image,
      'carId': carModel.carId.toString()
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "addd");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAddCarModel = false;
      getCarModels();
      emit(AddCarModelsSuccess());
      // getCategories();
    } else {
      loadAddCarModel = false;
      print(response.reasonPhrase);
      emit(AddCarModelsError());
    }
  }

  //delete
  bool loadCarModelDelete = false;

  deleteCarModel({id, context}) async {
    loadDelete = true;
    emit(DeleteCarModelsLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + "carModel/delete-carModel"));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;
      getCarModels();
      emit(DeleteCarModelsSuccess());
    } else {
      loadDelete = false;
      print(response.reasonPhrase);
      emit(DeleteCarModelsError());
    }
  }

  bool loadUpdateCarModel = false;

  Future updateCaraModel({required category}) async {
    loadUpdateCarModel = true;
    emit(UpdateCarModelsLoad());
    var request = http.MultipartRequest(
        'PUT', Uri.parse(baseUrl + 'carModel/update-carModel'));
    request.fields.addAll({
      'name': category.name,
      'image': category.image,
      "CarId": category.carId.toString(),
      'id': category.id.toString()
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "updateing CarModel");
    if (response.statusCode == 204) {
      // print(await response.stream.bytesToString());
      loadUpdateCarModel = false;

      getCarModels();
      emit(UpdateCarModelsSuccess());
      // getCategories();
    } else {
      loadUpdateCarModel = false;
      print(response.reasonPhrase);
      emit(UpdateCarModelsError());
    }
  }

  getCarModelsById({carId}) async {
    carModels = [];
    loadCarModels = true;
    emit(GetCarModelsLoad());
    //  var request = http.MultipartRequest('GET', Uri.parse());
    var response = await Dio()
        .get(baseUrl + 'carModel/get-carModels-by-carId?carId=$carId');

// http.StreamedResponse response = await request.send();

    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.data.toString());
      var data = response.data;
      // print(responseBody.toString());
      // final data = jsonDecode(responseBody);
      data.forEach((e) {
        carModels.add(CarModel.fromJson(e));
      });
      loadCarModels = false;
      print(carModels.length.toString());
      emit(GetCarModelsSuccess());
    } else {
      loadCarModels = false;
      print(response);
      emit(GetCarModelsError());
    }
  }

  CategoryModel? brand;

  void changeValueBrand(CategoryModel category2) {
    brand = category2;
    emit(ChangeValueSubCategory());
  }

  CarModel? carModel;

  void changeValueCarModel(CarModel newCarModel) {
    carModel = newCarModel;
    emit(ChangeValueSubCategory());
  }
}

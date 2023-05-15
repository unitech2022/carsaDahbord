
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/models/setting_model.dart';
import 'package:meta/meta.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of<SettingCubit>(context);

  List<SittingModel> sittings = [];
  bool load = false;

  getSitting() async {
    load = true;
    sittings = [];
    emit(GetDataLoadLoad());
    var request =
        http.Request('GET', Uri.parse(baseUrl + 'sitting/get-sittings'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        sittings.add(SittingModel.fromJson(e));
      });
      load = false;
      emit(GetDataLoadSuccess());
    } else {
      print(response.statusCode.toString());
      load = false;
      emit(GetDataLoadLoad());
    }
  }

  bool loadAdd = false;

  Future addSitting({required setting,required endPoint,status}) async {
    loadAdd = true;
    emit(AddSettingLoadStat());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + endPoint));


    request.fields.addAll({'name': setting.name.toString(), 'value': setting.value.toString()});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;
      print(jsonData);
      loadAdd = false;
      getSitting();
      emit(AddSettingSuccessStat());

    } else {
      loadAdd = false;
      print(response.reasonPhrase);
      emit(AddSettingErrorStat());
    }
  }

  //delete
  bool loadDelete = false;

  deleteCategory({id, context, endPoint, status}) async {
    loadDelete = true;
    emit(DeleteSettingLoadStat());
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + "sitting/delete-sitting"));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;
getSitting();
      emit(DeleteSettingSuccessStat());
    } else {
      loadDelete = false;
      print(response.reasonPhrase);
      emit(DeleteSettingErrorStat());
    }
  }

  bool loadUpdate = false;

  Future updateSiting({required sitting,required endPoint,status}) async {
    loadUpdate = true;
    print(sitting.name!+"fkfkfkfkf");
    emit(UpdateSettingLoadStat());
    // var request = http.MultipartRequest(
    //     'POST', Uri.parse(baseUrl+endPoint));


    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'sitting/update-sitting'));

    request.fields.addAll({
      'id': sitting.id.toString(),
      'name': sitting.name,
      'value': sitting.value,
    });

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {


      var responseBody = await response.stream.bytesToString();

      final data = jsonDecode(responseBody);
      SittingModel model=SittingModel.fromJson(data);
      print(model.name!+"fkfkfkfkf");
       getSitting();
      loadUpdate = false;
      emit(UpdateSettingSuccessStat());
      // getCategories();
    } else {
      loadUpdate = false;
      print(response.reasonPhrase);
      emit(UpdateSettingErrorStat());
    }
  }
}

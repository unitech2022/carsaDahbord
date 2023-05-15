import 'dart:convert';
import 'dart:html';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/setting_bloc/setting_cubit.dart';
import 'package:flutter_web_dashboard/models/SupportMessage.dart';
import 'package:flutter_web_dashboard/models/setting_model.dart';
import 'package:flutter_web_dashboard/models/suggestion.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
import '../../helpers/functions.dart';

part 'suggestion_state.dart';

class SuggestionCubit extends Cubit<SuggestionState> {
  SuggestionCubit() : super(SuggestionInitial());

  static SuggestionCubit get(context) =>
      BlocProvider.of<SuggestionCubit>(context);

  bool loadAdd = false;
  List<Suggestion> suggestion = [];

 bool isReplayAuto=false;
  replayAutoCheckBox(newValue,SittingModel model,{context}){
    isReplayAuto=newValue;

    SettingCubit.get(context).updateSiting(
        status: 0,
        endPoint: "sitting/update-sitting",
        sitting:model
    );
    emit(ReplayAutoState());
  }


  getSuggestions() async {
    suggestion = [];
    loadAdd = true;
    emit(GetSuggestionDataLoad());
    var request = http.Request(
        'GET', Uri.parse(baseUrl + 'suggestions/get-suggestionses'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());

      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        suggestion.add(Suggestion.fromJson(e));
      });

      loadAdd = false;
      emit(GetSuggestionDataLoad());
    } else {
      loadAdd = false;
      print(response.reasonPhrase);
    }
  }



  //delete
  bool loadDelete = false;

  deleteSuggestion({id, context}) async {
    loadDelete = true;
    emit(DeleteSuggestionDataLoad());
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + "suggestions/delete-suggestions"));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadDelete = false;
      getSuggestions();

      emit(DeleteSuggestionDataSuccess());



    } else {
      loadDelete = false;
      print(response.reasonPhrase);
      emit(DeleteSuggestionDataError());
    }
  }

bool loadGetMessages=false;
  List<ResponseMessage> messages=[];
  getMessages() async {
    messages=[];
    loadGetMessages=true;
    emit(GetMessagesLoad());
    final url = baseUrl+"support/get-all-messages";
    final response = await http.post(Uri.parse(url));

    print(response.body);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      data.forEach((e){
        messages.add(ResponseMessage.fromJson(e));
      });
      loadGetMessages=false;
      emit(GetMessagesSuccess());

    } else {
      // pop(context);
      print(response.statusCode.toString()+"errrrrrrrrrrr");
      loadGetMessages=false;
      emit(GetMessagesError());
    }
  }



  List<ResponseMessage> messagesUser=[];
  Future getMessagesUser({userId}) async {
    print(userId.toString()+"errrrrrrrrrrr");
    messagesUser=[];
    loadGetMessages=true;
    emit(GetMessagesLoad());
    final url = baseUrl+"support/get-user-messages-admin";
    final response = await http.post(Uri.parse(url),body: {"userId":userId});

    print(response.body);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      data.forEach((e){
        messagesUser.add(ResponseMessage.fromJson(e));
      });
      loadGetMessages=false;
      emit(GetMessagesSuccess());

    } else {
      // pop(context);

      loadGetMessages=false;
      emit(GetMessagesError());
    }
  }

 Future addMessage(SupportMessage message) async {

    final url = baseUrl+"support/add-message";
    final response = await http.post(Uri.parse(url),body: message.toJson());
    print(response.body);
    if (response.statusCode == 200) {

      getMessagesUser(userId: message.userId);
      getMessages();
     emit(AddMessagesLoad());
    } else {
      emit(AddMessagesError());
      // pop(context);
    }
  }




}

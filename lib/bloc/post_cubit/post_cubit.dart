import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../constants/constans.dart';
import '../../helpers/functions.dart';
import '../../models/post.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  static PostCubit get(context) => BlocProvider.of<PostCubit>(context);

  List<Post> posts = [];

  bool load = false;

  getPosts() async {
    posts = [];
    load = true;
    emit(GetPostDataLoad());

    final response = await Dio().get(getPostsPath);
    print(response.statusCode.toString() + "CategoryWORKShops");

    if (response.statusCode == 200) {
      response.data.forEach((v) {
        posts.add(Post.fromJson(v));
      });
      load = false;
      emit(GetPostDataSuccess(posts));
    } else {
      emit(GetPostDataError());
    }
  }
}

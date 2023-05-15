import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../constants/constans.dart';
import '../../helpers/function_helper.dart';
import '../../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  bool isCheckedUserName = false;

  bool isRegisterLoad = false;

  registerUser({required fullName, required email,required pass, required userName, role,onSuccess}) async {
    isRegisterLoad = true;
    emit(RegisterAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + "auth/admin/signup"));
    request.fields.addAll({
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'knownName': 'askdkalshkjsa',
      'Role': "admin",
      'password': pass,
      'DeviceFCM': "tokenFCM"
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      print(jsonData);

      isRegisterLoad = false;
     onSuccess();
      emit(
          RegisterAuthStateSuccess());
    } else {
      print(response.reasonPhrase);
      isRegisterLoad = false;
      emit(RegisterAuthStateError());
    }
  }

  UserModel? user = UserModel();

  bool loadLogin=false;
  loginUser({required pass, required userName,onSuccess}) async {

    loadLogin=true;
    emit(LoginAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + "auth/admin-login"));
    request.fields.addAll({
      'UserName':  userName,
      'Password': pass
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      print(response.statusCode.toString());

      // printFunction(jsonData);
      UserResponse userResponse = UserResponse.fromJson(jsonData);
      token = "Bearer " + userResponse.token!;
      currentUser = user = userResponse.user;
      await saveToken();
      loadLogin=false;
      onSuccess();
      emit(LoginAuthStateSuccess());
    } else {
      loadLogin=false;
      print(response.statusCode.toString());
      emit(LoginAuthStateError());
    }
  }

  bool isChecked = true;

  changeCheckBox(bool checked) {
    isChecked = checked;
    print(isChecked);
    emit(ChangeCheckBox());
  }

  int currentStatus = 0;

  currentStatusState(int newStatus) {
    currentStatus = newStatus;
    print(currentStatus);
    emit(ChangeCheckBox());
  }

}

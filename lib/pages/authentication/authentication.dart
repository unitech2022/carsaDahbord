import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';


import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../helpers/functions.dart';
import '../../widgets/buttons.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {


  final _controllerEmail = TextEditingController();

  final _controllerPass = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerEmail.text="admin@carsa.com";
    _controllerPass.text="Abc123@";
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: homeColor,
          body: Center(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(15)),
              constraints: BoxConstraints(maxWidth: 400),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text("Carsa",
                          style: TextStyle(
                              color: homeColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "أهلا بك في لوحة التحكم ..",
                        color: lightGrey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: const TextStyle(fontFamily: "pnuM"),
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                        labelText: "البريد الالكترونى",
                        hintText: "abc@domain.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: const TextStyle(fontFamily: "pnuM"),
                    obscureText: true,
                    controller: _controllerPass,
                    decoration: InputDecoration(
                        labelText: "الرقم السري",
                        hintText: "123",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value){}),
                      CustomText(text: "Remeber Me",),
                    ],
                  ),

                  CustomText(
                    text: "Forgot password?",
                    color: active
                  )
                ],
              ),
                SizedBox(
                height: 15,
              ),*/

                  SizedBox(
                    height: 45,
                    child: AuthCubit
                        .get(context)
                        .loadLogin
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                        : CustomButton(
                      color: homeColor,
                      width: double.infinity,
                      height: 45,
                      onPress: () {
                        // print("dh");
                        if (isValidate(context)) {
                          AuthCubit.get(context).loginUser(
                              userName: _controllerEmail.text.trim(),
                              pass: _controllerPass.text.trim(),
                              onSuccess: () {
                                Get.offAllNamed(rootRoute);
                              });
                        }
                      },
                      fontFamily: "pnuB",
                      text: "دخول",
                      isCustomColor: true,
                      redius: 10,
                      fontSize: 20,
                      textColor: Colors.white,
                      isBorder: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // RichText(text: TextSpan(
                  //   children: [
                  //     TextSpan(text: "Do not have admin credentials? "),
                  //     TextSpan(text: "Request Credentials! ", style: TextStyle(color: active))
                  //   ]
                  // ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  bool isValidate(BuildContext context) {
    if (_controllerEmail.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل رقم الايميل");
      return false;
    } else if (_controllerPass.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الرقم السري ");
      return false;
    } else {
      return true;
    }
  }
}

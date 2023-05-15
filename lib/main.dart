import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_web_dashboard/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_web_dashboard/bloc/order_cubit/order_cubit.dart';
import 'package:flutter_web_dashboard/bloc/post_cubit/post_cubit.dart';
import 'package:flutter_web_dashboard/bloc/products_cubit/product_cubit.dart';
import 'package:flutter_web_dashboard/bloc/setting_bloc/setting_cubit.dart';
import 'package:flutter_web_dashboard/bloc/suggestion_cubit/suggestion_cubit.dart';
import 'package:flutter_web_dashboard/bloc/user_cubit/user_cubit.dart';
import 'package:flutter_web_dashboard/bloc/work_shop_cubit/workshop_cubit.dart';

import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/controllers/navigation_controller.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';

import 'package:get/get.dart';

import 'dart:ui' as ui;
import 'bloc/app_cubit/app_cubit.dart';
import 'bloc/category_cubit/category_cubit.dart';
import 'controllers/menu_controller.dart';
import 'helpers/function_helper.dart';

/// todo : make function for get order details becouse items repeating
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();
   
  Get.put(MenuControllerGet());
  Get.put(NavigationController());
 await readToken();
  runApp(
      Phoenix(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingCubit>(
          create: (BuildContext context) => SettingCubit(),
        ),
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),

        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),

        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),  BlocProvider<CategoryCubit>(
          create: (BuildContext context) => CategoryCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider<OrderCubit>(
          create: (BuildContext context) => OrderCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),

        ),
        BlocProvider<SuggestionCubit>(
          create: (BuildContext context) => SuggestionCubit(),

        ),
        BlocProvider<WorkshopCubit>(
          create: (BuildContext context) => WorkshopCubit()..getCategoriesWork(),

        ),
        BlocProvider<PostCubit>(
          create: (BuildContext context) => PostCubit()..getPosts(),

        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        textDirection:  ui.TextDirection.rtl ,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
        //
        // localizationsDelegates: context.localizationDelegates,
        initialRoute: authenticationPageRoute,
        // unknownRoute: GetPage(
        //     name: '/not-found',
        //     page: () => PageNotFound(),
        //     transition: Transition.fadeIn),
        getPages: [
          GetPage(
              name: rootRoute,
              page: () {
                return SiteLayout();
              }),
          isRegistered()
              ? GetPage(name: overviewPageRoute, page: () => OverviewPage())
              : GetPage(
              name: authenticationPageRoute,
              page: () => const AuthenticationPage()),
        ],

        title: 'Carsa Dashboard',
        theme: ThemeData(
          fontFamily: "pnuM",
          scaffoldBackgroundColor: light,

          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
        ),
        // home: AuthenticationPage(),
      ),
    );
  }
}

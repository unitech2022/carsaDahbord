import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/brands_screen/brands_screen.dart';
import 'package:flutter_web_dashboard/pages/category_screen/drivers.dart';

import 'package:flutter_web_dashboard/pages/clients/clients.dart';
import 'package:flutter_web_dashboard/pages/orders_screen/orders_screen.dart';

import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/posts_screen/posts_screen.dart';
import 'package:flutter_web_dashboard/pages/products_screen/products_screen.dart';
import 'package:flutter_web_dashboard/pages/siting_screen/siting_screen.dart';
import 'package:flutter_web_dashboard/pages/slider_screen/sliders_screen.dart';
import 'package:flutter_web_dashboard/pages/suggestses_screen/suggestses_screen.dart';
import 'package:flutter_web_dashboard/pages/workshops_page/workshops_page.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';

import '../pages/car_models_screen/car_models_screen.dart';
import '../pages/supports_screen/supports_screen.dart';



Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(DriversPage());
    case productsPageRoute:
      return _getPageRoute(ProductsScreen());
    case brandsPageRoute:
      return _getPageRoute(BrandsScreen());
          case carModelsPageRoute:
      return _getPageRoute(CarModelsScreen());
    case slidersPageRoute:
      return _getPageRoute(SlidersScreen());
    case ordersPageRoute:
      return _getPageRoute(OrdersScreen());

    case workshopsPageRoute:
      return _getPageRoute(WorkshopsScreen());

      case postsPageRoute:
      return _getPageRoute(PostsScreen());

    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    case suggestionsPageRoute:
      return _getPageRoute(SuggestionsScreen());

    case sittingPageRoute:
      return _getPageRoute(SittingScreen());

    case messagesPageRoute:
      return _getPageRoute(SupportsScreen());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}
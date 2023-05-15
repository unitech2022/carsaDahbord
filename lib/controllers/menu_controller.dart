import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';

class MenuControllerGet extends GetxController {
  static MenuControllerGet instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String? itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName!;
  }

  isHovering(String? itemName) => hoverItem.value == itemName;

  isActive(String? itemName) => activeItem.value == itemName;

  Widget returnIconFor(String? itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case driversPageDisplayName:
        return _customIcon(Icons.category, itemName);
      case productsPageDisplayName:
        return _customIcon(Icons.shopping_cart, itemName);
      case brandsPageDisplayName:
        return _customIcon(Icons.local_offer, itemName);
     case carModelsPageDisplayName:
        return _customIcon(Icons.car_repair, itemName);
      case slidersPageDisplayName:
        return _customIcon(Icons.slideshow, itemName);
      case ordersPageDisplayName:
        return _customIcon(Icons.shopping_basket, itemName);

      case workshopsPageDisplayName:
        return _customIcon(Icons.work, itemName);

      case postsPageDisplayName:
        return _customIcon(Icons.post_add_sharp, itemName);
      case clientsPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      case suggestionsPageDisplayName:
        return _customIcon(Icons.comment, itemName);

      case sittingPageDisplayName:
        return _customIcon(Icons.settings, itemName);

      case messagesPageDisplayName:
        return _customIcon(Icons.message, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String? itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: Colors.white);

    return Icon(
      icon,
      color: isHovering(itemName) ? Colors.white : lightGrey,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(

            color: homeColor,
        child: ListView(
          children: [
            if(ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height:80,
                  ),
                  Row(
                    children: [
                      SizedBox(width: _width / 48),
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: ClipRRect(
                            borderRadius:   BorderRadius.circular(20),

                            child: Image.asset("assets/images/logo.png",width:40,height: 40,)),
                      ),
                      Flexible(
                        child: CustomText(
                          text: "Carsa",
                          size: 20,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: _width / 48),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            Divider(color: lightGrey.withOpacity(.1), ),
            SizedBox(
              height:30,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItemRoutes
                  .map((item) => SideMenuItem(
                  itemName: item.name,
                  onTap: () {
                    if(item.route == authenticationPageRoute){
                      Get.offAllNamed(authenticationPageRoute);
                      menuController.changeActiveItemTo(overviewPageDisplayName);

                    }
                    if (!menuController.isActive(item.name)) {
                      menuController.changeActiveItemTo(item.name);
                      if(ResponsiveWidget.isSmallScreen(context))
                        Get.back();
                      navigationController.navigateTo(item.route);
                    }
                  }))
                  .toList(),
            )
          ],
        )
          );
  }
}
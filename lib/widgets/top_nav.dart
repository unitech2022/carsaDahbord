import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../constants/constans.dart';
import '../constants/style.dart';
import '../helpers/function_helper.dart';
import '../helpers/reponsiveness.dart';
import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(

      leading: !ResponsiveWidget.isSmallScreen(context) ? Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle
                ),

                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                          "assets/images/logo.png", width: 40,height: 40)),
                )),
          ),
        ],
      ) : IconButton(icon: const Icon(Icons.menu), onPressed: () {
        key.currentState!.openDrawer();
      }),
      title: Container(
        margin: const EdgeInsets.all(5),

        child: Row(
          children: [
            Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: const CustomText(text: "Carsa",
                  color: Colors.white,
                  size: 20,
                  weight: FontWeight.bold,)),
            Expanded(child: Container()),
            // IconButton(
            //     icon: Icon(Icons.settings, color: dark,), onPressed: () {}),

            Stack(
              children: [
                IconButton(icon: Icon(
                  Icons.notifications, color: dark.withOpacity(.7),),
                    onPressed: () {}),
                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)
                    ),
                  ),
                )
              ],
            ),

            Container(
              width: 1,
              height: 22,
              color: homeColor,
            ),
            const SizedBox(width: 24,),

            CustomText(text: currentUser!.fullName, color: homeColor, size: 16, weight: FontWeight.bold,),
            const SizedBox(width: 16,),
            Container(
              decoration: BoxDecoration(
                  color: active.withOpacity(.5),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),

                        child: CachedNetworkImage(
                          imageUrl:
                          "$baseUrlImages${currentUser!.imageUrl}",
                          height: 40,
                          width: 40,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.person,size: 40,),
                        ),
                      )),
                  // Icon(Icons.person_outline, color: dark,),
                ),
              ),
            )
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
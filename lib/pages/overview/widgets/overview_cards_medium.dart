import 'package:flutter/material.dart';

import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/home_model.dart';


class OverviewCardsMediumScreen extends StatelessWidget {
final HomeModel model;

OverviewCardsMediumScreen(this.model);

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
                  children: [
                    InfoCard(
                      title: "عدد العملاء",
                      value:model.countUsers.toString(),
                      onTap: () {

                        // Get.to(AddProducts());
                      },
                  topColor: Colors.orange,

                    ),
                    SizedBox(
                      width: _width / 64,
                    ),
                    InfoCard(
                      title: "عدد الطلبات ",
                      value: model.countOrders.toString(),
                  topColor: Colors.lightGreen,

                      onTap: () {},
                    ),
                  
                  ],
                ),
            SizedBox(
                      height: _width / 64,
                    ),
                  Row(
                  children: [
             
                    InfoCard(
                      title: "عدد المنتجات",
                      value: model.countProduct.toString(),
                  topColor: Colors.redAccent,

                      onTap: () {},
                    ),
                    SizedBox(
                      width: _width / 64,
                    ),
                    InfoCard(
                      title: "عدد الأقسام",
                      value: model.countCategories.toString(),
                      onTap: () {},
                    ),
                
                  ],
                ),
      ],
    );
  }
}
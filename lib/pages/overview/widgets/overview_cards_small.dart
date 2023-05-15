import 'package:flutter/material.dart';
import '../../../models/home_model.dart';
import 'info_card_small.dart';


class OverviewCardsSmallScreen extends StatelessWidget {
  final HomeModel model;

  OverviewCardsSmallScreen(this.model);
  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "عدد العملاء",
            value:model.countUsers.toString(),
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "عدد الطلبات ",
                        value: model.countOrders.toString(),
                        onTap: () {},
                      ),
                     SizedBox(
                        height: _width / 64,
                      ),
                          InfoCardSmall(
                            title: "عدد المنتجات",
                            value: model.countProduct.toString(),
                        onTap: () {},
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "عدد الأقسام",
                        value: model.countCategories.toString(),
                        onTap: () {},
                      ),
                  
        ],
      ),
    );
  }
}
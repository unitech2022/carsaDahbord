import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

import '../../../models/home_model.dart';


class OverviewCardsLargeScreen extends StatelessWidget {
  final HomeModel model;

  OverviewCardsLargeScreen(this.model);
  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Row(
              children: [
                InfoCard(
                  title: "عدد العملاء",
                  value:model.countUsers.toString(),
                  onTap: () {},
                  topColor: Colors.orange.withOpacity(.9),
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد الطلبات ",
                  value: model.countOrders.toString(),
                  topColor: Colors.lightGreen.withOpacity(.9),
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد المنتجات",
                  value: model.countProduct.toString(),
                  topColor: Colors.redAccent.withOpacity(.9),
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد الأقسام",
                  value: model.countCategories.toString(),
                topColor: Colors.lightGreen.withOpacity(.5),
                  onTap: () {},
                ),
              ],
            );
  }
}
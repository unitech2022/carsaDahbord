import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/app_cubit/app_cubit.dart';
import 'package:flutter_web_dashboard/bloc/setting_bloc/setting_cubit.dart';
import 'package:flutter_web_dashboard/helpers/function_helper.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants/style.dart';
import '../../helpers/order_model.dart';
import '../../widgets/texts.dart';
import '../details_order_screen/details_order_screen.dart';
import '../orders_screen/orders_screen.dart';

class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  @override
  void initState() {
    super.initState();
    getLocation();
    AppCubit.get(context).getHomeData();
    SettingCubit.get(context).getSitting();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {
            
            },
            builder: (context, state) {
              return AppCubit.get(context).load
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (ResponsiveWidget.isLargeScreen(context) ||
                              ResponsiveWidget.isMediumScreen(context))
                            if (ResponsiveWidget.isCustomSize(context))
                              OverviewCardsMediumScreen(
                                  AppCubit.get(context).homeModel)
                            else
                              OverviewCardsLargeScreen(
                                  AppCubit.get(context).homeModel)
                          else
                            OverviewCardsSmallScreen(
                                AppCubit.get(context).homeModel),
                          // if (!ResponsiveWidget.isSmallScreen(context))
                          //   RevenueSectionLarge()
                          // else
                          //   RevenueSectionSmall(),

                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("طلبات جديدة",
                                  style: TextStyle(
                                    fontFamily: "pnuB",
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          TableWidgetOrders(
                            list: AppCubit.get(context).homeModel.orders,
                            name: "JDJDJD",
                            image: "HDDDDDDD",
                            id: "1",
                            label: "الاقسام",
                            onDelete: true,
                            onUpdate: false,
                          )
                        ],
                      ),
                    ));
            },
          )
        ],
      ),
    );
  }
}

class TableWidgetOrdersHome extends StatelessWidget {
  final String? label, name, id, image;
  final bool? onUpdate, onDelete;
  final List<OrderModel>? list;

  TableWidgetOrdersHome(
      {this.label,
      this.name,
      this.id,
      this.onDelete,
      this.onUpdate,
      this.image,
      this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: DataTable(
            columnSpacing: 12,
            horizontalMargin: 12,
            columns: [
              DataColumn2(
                label: Text("Id"),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('اسم العميل '),
              ),
              DataColumn(
                label: Text("الاجمالى"),
              ),
              DataColumn(
                label: Text('تاريخ الطلب'),
              ),
              DataColumn(
                label: Text('الحالة'),
              ),
              DataColumn(
                label: Text('التفاصيل'),
              ),
            ],
            rows: List<DataRow>.generate(list!.length, (index) {
              DateTime now =
                  DateTime.parse(list![index].order!.createdAt.toString());
              String formattedDate =
                  DateFormat.jm("ar").format(now);
              return DataRow(cells: [
                DataCell(CustomText(text: "${list![index].order!.id}")),
                DataCell(CustomText(text: list![index].userName)),
                DataCell(
                    CustomText(text: list![index].order!.price.toString())),
                DataCell(CustomText(text: formattedDate)),
                DataCell(CustomText(
                  text: status[list![index].order!.status!],
                  color: list![index].order!.status == 0
                      ? Colors.green
                      : Colors.red,
                )),
                DataCell(Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 120,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: Colors.green,
                    onPressed: () {
                      Get.to(DetailsOrderScreen(list![index]));
                    },
                    child: Center(
                      child: CustomText(
                        text: "التفاصيل",
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ]);
            })),
      ),
    );
  }

  Future showDialogAction(int id, BuildContext context, String name) async {
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return Container(
          // height: 200,
          child: AlertDialog(
            title: Texts(
                fSize: 18,
                color: Colors.red,
                title: name,
                weight: FontWeight.bold),
            content: Texts(
                fSize: 20,
                color: Colors.black,
                title: "هل أنت متأكد من أنك تريد حذف هذا القسم",
                weight: FontWeight.bold),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: Text("حذف", style: const TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              TextButton(
                child: Text("الغاء"),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

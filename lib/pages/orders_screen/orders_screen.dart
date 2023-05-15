
import 'package:data_table_2/data_table_2.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/order_cubit/order_cubit.dart';
import 'package:flutter_web_dashboard/helpers/order_model.dart';
import 'package:flutter_web_dashboard/pages/details_order_screen/details_order_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).getOrders(endPoint: "order/get-all-Orders");
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              Obx(
                    () => Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6),
                        child: CustomText(
                          text: menuController.activeItem.value,
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Expanded(
                  child: OrderCubit.get(context).loadOrders
                      ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.blue,
                      ),
                    ),
                  )
                      : TableWidgetOrders(
                    list: OrderCubit.get(context).listOrders,
                    name: "JDJDJD",
                    image: "HDDDDDDD",
                    id: "1",
                    label: "الاقسام",
                    onDelete: false,
                    onUpdate: false,
                  )),
            ],
          ),
        );
      },
    );
  }
}

List<String> status=[
  "قيد الانتظار",
  "جارى التنفيذ",
  "تم التسليم",
  "منتهى"
];
class TableWidgetOrders extends StatelessWidget {
  final String? label, name, id, image;
  final bool? onUpdate, onDelete;
  final List<OrderModel>? list;

  TableWidgetOrders(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 10,
            //     ),
            //     CustomText(
            //       text: label,
            //       color: lightGrey,
            //       weight: FontWeight.bold,
            //     ),
            //   ],
            // ),
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
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

                  DataColumn(

                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    list!.length,
                        (index) {

                          DateTime now =
                          DateTime.parse( list![index].order!.createdAt.toString());
                          String formattedDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(now);
                          return DataRow(cells: [
                         DataCell(
                          CustomText(text: "${list![index].order!.id}")),
                          DataCell(CustomText(text:list![index].userName )),
                          DataCell(CustomText(text: list![index].order!.price.toString())),
                          DataCell(CustomText(text: formattedDate)),

                            DataCell(CustomText(text:status[list![index].order!.status!] ,
                            color:list![index].order!.status==0?Colors.green :Colors.red,)),

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
                            )),
                            DataCell(Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              height: 50,
                              width: 80,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: Colors.red,
                                onPressed: () {
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
                                              title: list![index].userName,
                                              weight: FontWeight.bold),
                                          content: Texts(
                                              fSize: 20,
                                              color: Colors.black,
                                              title:
                                              "هل أنت متأكد من أنك تريد حذف هذا الطلب",
                                              weight: FontWeight.bold),
                                          actions: <Widget>[
                                            // usually buttons at the bottom of the dialog
                                            MaterialButton(
                                              minWidth: 50,
                                              color: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(4)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 2),
                                                child: Text("حذف",
                                                    style: const TextStyle(
                                                        fontFamily: "pnuM",
                                                        color: Colors.white)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, 1);
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                "الغاء",
                                                style:
                                                TextStyle(fontFamily: "pnuM"),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, 0);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ).then((value) {
                                    print(value);
                                    if (value == null) {
                                      return;
                                    } else if (value == 1) {

                                      if(onDelete!){
                                        OrderCubit.get(context).deleteOrder(status: 0,
                                            context: context, id: list![index].order!.id);
                                      }else{
                                        OrderCubit.get(context).deleteOrder(status:1,
                                            context: context, id: list![index].order!.id);
                                      }

                                    }
                                  });
                                },
                                child: Center(
                                  child: CustomText(
                                    text: "حذف",
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ))
                    ]);
                        })),
          ],
        ),
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
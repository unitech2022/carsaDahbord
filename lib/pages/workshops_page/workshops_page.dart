import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/work_shop_cubit/workshop_cubit.dart';
import 'package:flutter_web_dashboard/bloc/work_shop_cubit/workshop_state.dart';
import 'package:flutter_web_dashboard/pages/details_workshop/details_workshop.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/workshop_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';

class WorkshopsScreen extends StatefulWidget {
  const WorkshopsScreen({Key? key}) : super(key: key);

  @override
  State<WorkshopsScreen> createState() => _WorkshopsScreenState();
}

class _WorkshopsScreenState extends State<WorkshopsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopCubit, WorkshopState>(
      builder: (context, state) {
        return Container(
          child: Column(children: [
            Obx(
              () => Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top:
                              ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 24,
                        weight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
                height: 40,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: WorkshopCubit.get(context).categories.length,
                    itemBuilder: (context, index) {
                      CategoryWork categoryWork =
                          WorkshopCubit.get(context).categories[index];
                      return GestureDetector(
                        onTap: () {
                          WorkshopCubit.get(context)
                              .changeIndex(categoryWork.id);

                          WorkshopCubit.get(context).getWorksById(
                              categoryId: categoryWork.id.toString());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          margin:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          decoration: BoxDecoration(
                              color: WorkshopCubit.get(context).currentIndex ==
                                      categoryWork.id
                                  ? homeColor
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            WorkshopCubit.get(context).categories[index].name!,
                            style: TextStyle(
                                color:
                                    WorkshopCubit.get(context).currentIndex ==
                                            categoryWork.id
                                        ? Colors.white
                                        : homeColor,
                                fontSize: 18),
                          ),
                        ),
                      );
                    })),
            SizedBox(height: 40),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  WorkshopCubit.get(context).loadWorkShops
                      ? Center(
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: homeColor,
                          ),
                        )
                      : TableWidgetWorkShop(
                          list: WorkshopCubit.get(context).workshops,cateId:1),
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}

List<String> status = [
  "معلقة",
  "مفعلة",
];

class TableWidgetWorkShop extends StatelessWidget {
  final int cateId;
  final List<Workshops> list;

  TableWidgetWorkShop({required this.list, required this.cateId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: ResponsiveWidget.isSmallScreen(context)?null:1200,
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
                label: Text('اسم الورشة '),
              ),
              DataColumn(
                label: Text("العنوان"),
              ),
              DataColumn(
                label: Text('رقم الهاتف'),
              ),
              DataColumn(
                label: Text('التفاصيل'),
              ),
              DataColumn(
                label: Text('الحالة'),
              ),
            ],
            rows: List<DataRow>.generate(list.length, (index) {
              return DataRow(cells: [
                DataCell(CustomText(text: "${list[index].id}")),
                DataCell(CustomText(text: list[index].name)),
                DataCell(CustomText(text: list[index].address)),
                DataCell(CustomText(text: list[index].phone.toString())),
                DataCell(Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 120,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: Colors.green,
                    onPressed: () {
                      Get.to(DetailsWorkShop(list[index]));
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
                    color:
                        list[index].status == 0 ? Colors.red : Colors.green,
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
                                  title: list![index].name,
                                  weight: FontWeight.bold),
                              content: Texts(
                                  fSize: 20,
                                  color: Colors.black,
                                  title: list[index].status == 0
                                      ? "تشغيل الورشة"
                                      : "ايقاف الورشة",
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
                                    child: Text(
                                        list[index].status == 0
                                            ? "تشغيل"
                                            : "ايقاف",
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
                                    style: TextStyle(fontFamily: "pnuM"),
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
                          WorkshopCubit.get(context).updateWorkShopStatus(
                              id: list[index].id,
                              status: list[index].status == 0 ? 1 : 0,
                              cateId: cateId);
                        }
                      });
                    },
                    child: Center(
                      child: CustomText(
                        text: status[list[index].status!],
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
}

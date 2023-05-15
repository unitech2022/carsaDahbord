import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/category_cubit/category_cubit.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../../constants/constans.dart';
import '../../constants/style.dart';
import '../../helpers/function_helper.dart';
import '../../widgets/texts.dart';
import 'add_category_screen/add_category_screen.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({Key? key}) : super(key: key);

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryCubit.get(context).getCategories(endPoint: "category/get-categories");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
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
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: 80,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: homeColor,
                        onPressed: () {
                          Get.to(AddCategoryScreen(CategoryModel(), 0,5));

                          // pushPage(
                          //     context: context,
                          //     page: AddCategoryScreen());
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "اضافة قسم",
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(width: 10,),

                              Icon(Icons.add,color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                  child: CategoryCubit.get(context).loadCategories
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : TableWidgetCategory(
                          list: CategoryCubit.get(context).listCategories,
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

class TableWidgetCategory extends StatelessWidget {
  final String? label, name, id, image;
  final bool? onUpdate, onDelete;
  final List<CategoryModel>? list;

  TableWidgetCategory(
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
                    label: Text('الاسم'),
                  ),
                  DataColumn(
                    label: Text('الصورة'),
                  ),
                  DataColumn(
                    label: Text('تعـديل'),
                  ),
                  DataColumn(
                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    list!.length,
                    (index) => DataRow(cells: [
                          DataCell(CustomText(text: "${list![index].id}")),
                          DataCell(CustomText(text: list![index].name)),
                          DataCell(Container(
                            child: Container(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "$baseUrlImages${list![index].image}",
                                  height: 60,
                                  width: 100,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
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
                              color: Colors.green,
                              onPressed: () {
                                Get.to(AddCategoryScreen(list![index], 1,0));
                              },
                              child: Center(
                                child: CustomText(
                                  text: "تعديل",
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
                                            title: list![index].name,
                                            weight: FontWeight.bold),
                                        content: Texts(
                                            fSize: 20,
                                            color: Colors.black,
                                            title:
                                                "هل أنت متأكد من أنك تريد حذف هذا القسم",
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
                                    CategoryCubit.get(context).deleteCategory(status: 0,
                                        context: context, id: list![index].id,endPoint: "category/delete-Category");
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
                          )),
                        ]))),
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

import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/post_cubit/post_cubit.dart';
import 'package:flutter_web_dashboard/models/post.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/function_helper.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
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
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  PostCubit.get(context).load
                      ? Center(
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: homeColor,
                          ),
                        )
                      : TableWidgetPost(list: PostCubit.get(context).posts),
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}

class TableWidgetPost extends StatelessWidget {
  final List<Post> list;

  TableWidgetPost({required this.list});

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
                label: Text('اسم السيارة '),
              ),
              DataColumn(
                label: Text("لون السيارة"),
              ),
              DataColumn(
                label: Text('رقم الهاتف'),
              ),
              DataColumn(
                label: Text('تاريخ الخدمة'),
              ),
              DataColumn(
                label: Text('التفاصيل'),
              ),
              DataColumn(
                label: Text('الحالة'),
              ),
            ],
            rows: List<DataRow>.generate(list.length, (index) {
              DateTime now =
                  DateTime.parse(list[index].createdAt.toString());
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(now);
              return DataRow(cells: [
                DataCell(CustomText(text: "${list[index].id}")),
                DataCell(CustomText(text: list[index].nameCar)),
                DataCell(CustomText(text: list[index].colorCar)),
                DataCell(CustomText(text: list[index].phone.toString())),
                DataCell(CustomText(text: formattedDate)),
                DataCell(Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 120,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: Colors.green,
                    onPressed: () {
                      showDialogAction(context, list[index]);
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
                DataCell(Center(
                  child: CustomText(
                    text: list[index].acceptedOfferId == 0
                        ? "في انتظار العروض"
                        : "تمت الموافقة",
                    color: list[index].acceptedOfferId == 0
                        ? Color.fromARGB(255, 255, 102, 7)
                        : Colors.green,
                    weight: FontWeight.bold,
                  ),
                ))
              ]);
            })),
      ),
    );
  }

  Future showDialogAction(BuildContext context, Post model) async {
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
                title: "تفاصيل الخدمة",
                weight: FontWeight.bold),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(height: 20,),
                SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.desc!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          //  await Clipboard.setData(ClipboardData(text: model.phone));
                          luncherUrl(Uri.parse('tel://${model.phone}'));
                        },
                        icon: Icon(Icons.call)),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                                ClipboardData(text: model.phone!))
                            .then((value) {
                          flutterToastFun(message: "تم نسخ الرقم", color: Colors.green);
                        });
                      },
                      child: Text(model.phone!,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        onPressed: () async {
                          //  await Clipboard.setData(ClipboardData(text: model.phone));
                          luncherUrl(Uri.parse(
                              'https://whatsapp://send?phone=+966${model.phone}'));
                        },
                        icon: Icon(Icons.call,color: Colors.green,)),
                  ],
                )
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog

              TextButton(
                child: Text(
                  "حسنا",
                  style: TextStyle(
                      fontFamily: "pnuB",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
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

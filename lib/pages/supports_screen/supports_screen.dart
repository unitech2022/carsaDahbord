import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/setting_bloc/setting_cubit.dart';
import 'package:flutter_web_dashboard/models/SupportMessage.dart';
import 'package:flutter_web_dashboard/models/setting_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../bloc/suggestion_cubit/suggestion_cubit.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';
import '../message_details/messages_details.dart';
import '../suggestses_screen/suggestses_screen.dart';

class SupportsScreen extends StatefulWidget {
  const SupportsScreen({Key? key}) : super(key: key);

  @override
  State<SupportsScreen> createState() => _SupportsScreenState();
}

class _SupportsScreenState extends State<SupportsScreen> {
  SittingModel? sittingModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SuggestionCubit.get(context).getMessages();
    sittingModel = SettingCubit.get(context).sittings.firstWhere(
      (element) => element.name == "replay",
      orElse: () {
      return SittingModel();
      },
    );
    if (sittingModel!.value == "false") {
      SuggestionCubit.get(context).isReplayAuto = false;
    } else {
      SuggestionCubit.get(context).isReplayAuto = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestionCubit, SuggestionState>(
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
              SizedBox(height: 40),
              CheckboxListTile(
                title: CustomText(
                  text: "الرد أتوماتك",
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                value: SuggestionCubit.get(context).isReplayAuto,
                onChanged: (newValue) {
                  if (newValue!) {
                    sittingModel!.value = "true";
                  } else {
                    sittingModel!.value = "false";
                  }
                  SuggestionCubit.get(context).replayAutoCheckBox(
                      newValue, sittingModel!,
                      context: context);
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              SizedBox(height: 40),
              Expanded(
                  child: SuggestionCubit.get(context).loadGetMessages
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : TableWidgetMessages(
                          list: SuggestionCubit.get(context).messages,
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

class TableWidgetMessages extends StatelessWidget {
  final String? label, name, id, image;
  final bool? onUpdate, onDelete;
  final List<ResponseMessage>? list;

  TableWidgetMessages(
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
                    label: Text('اسم العميل'),
                  ),
                  DataColumn(
                    label: Text('تاريخ'),
                  ),
                  DataColumn(
                    label: Text('تفاصيل'),
                  ),
                  DataColumn(
                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(list!.length, (index) {
                  DateTime now =
                      DateTime.parse(list![index].support!.date.toString());
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);

                  return DataRow(cells: [
                    DataCell(CustomText(text: "${list![index].support!.id}")),
                    DataCell(CustomText(text: list![index].sender!.fullName)),
                    DataCell(CustomText(text: formattedDate)),
                    DataCell(Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 80,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.green,
                        onPressed: () {
                          Get.to(MessagesDetails(
                              userId: list![index].support!.userId));
                        },
                        child: Center(
                          child: CustomText(
                            text: "تفاصيل",
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
                                      title: list![index].support!.message,
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
                              // SuggestionCubit.get(context).deleteSuggestion(
                              //     context: context, id: list![index].id);
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
                  ]);
                })),
          ],
        ),
      ),
    );
  }

/*  Future showDialogAction(BuildContext context, SupportMessage model) async {
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
                title: "تفاصيل الرسالة",
                weight: FontWeight.bold),
            content: Column(
              children: [
                DetailsSuggestion("اسم العميل :",model.userName),
                SizedBox(height: 20,),
                DetailsSuggestion("رقم الهاتف :",model.userPhone),
                SizedBox(height: 20,),
                // DetailsSuggestion("رقم الهاتف :",model.userPhone),
                // SizedBox(height: 20,),
                SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                        child: Texts(
                            fSize: 18,
                            color: Colors.red,
                            title:model.message,
                            weight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog

              TextButton(
                child: Text("حسنا",style: TextStyle(
                    fontFamily: "pnuB",fontSize: 25,fontWeight: FontWeight.bold
                ),),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }*/
}

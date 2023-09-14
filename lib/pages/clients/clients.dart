import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/user_model.dart';
import 'package:flutter_web_dashboard/pages/clients/widgets/clients_table.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../bloc/user_cubit/user_cubit.dart';
import '../../constants/constans.dart';
import '../../constants/style.dart';
import '../../helpers/functions.dart';
import '../../widgets/texts.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final _controllerFullName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserCubit.get(context).getUsers();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerFullName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
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
                    width: 180,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: 80,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: homeColor,
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
                                      title: "ارسال اشعار",
                                      weight: FontWeight.bold),
                                  content:  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey,width: 1)
                                    ),
                                    height: 200,
                                    width: 300,
                                    child: TextField(
                                      maxLines: null,
                                      controller: _controllerFullName,
                                      style: TextStyle(fontFamily: "pnuM"),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                          hintText: "نص الرسالة",
                                        ),
                                    ),
                                  ),
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
                                        child: Text("ارسال",
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
                              if(_controllerFullName.text.isNotEmpty){

                                UserCubit.get(context).sendNotification(
                                  context: context,title: _controllerFullName.text,
                                  onSuccess: (){
                                    _controllerFullName.text="";
                                  }
                                );
                              }else{
                                HelperFunctions.slt.notifyUser(
                                    color: Colors.green,message: "الرسالة فارغة",context: context
                                );
                              }

                            }
                          });

                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "ارسال اشعار للعملاء",
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(width: 10,),

                              Icon(Icons.notifications_active_outlined,color: Colors.white,),
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
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      UserCubit.get(context).loadUsers
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : TableWidgetUsers(
                              list: UserCubit.get(context).listUsers,
                              name: "JDJDJD",
                              image: "HDDDDDDD",
                              id: "1",
                              label: "الاقسام",
                              onDelete: false,
                              onUpdate: false,
                            ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}

class TableWidgetUsers extends StatelessWidget {
  final String? label, name, id, image;
  final bool? onUpdate, onDelete;
  final List<UserModel>? list;

  TableWidgetUsers(
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
                label: Text('الاسم'),
                size: ColumnSize.L
              ),

              DataColumn2(
                label: Text('الصورة'),
                size: ColumnSize.S,
              ),
              DataColumn(
                label: Text('تاريخ التسجيل'),
              ),
              DataColumn2(
                label: Text("رقم الهاتف"),
                size: ColumnSize.L,
              ),
            ],
            rows: List<DataRow>.generate(list!.length, (index) {
              DateTime now =
                  DateTime.parse(list![index].createdAt.toString());
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(now);

              return DataRow(cells: [

                DataCell(CustomText(text: list![index].fullName)),
                DataCell(Container(
                  child: Container(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CachedNetworkImage(
                        imageUrl: "$baseUrlImages${list![index].imageUrl}",
                        height: 60,
                        width: 100,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ),
                    ),
                  ),
                )),
                DataCell(CustomText(text: formattedDate)),
                DataCell(CustomText(text: "${list![index].userName}")),
              ]);
            })),
      ),
    );
  }
}

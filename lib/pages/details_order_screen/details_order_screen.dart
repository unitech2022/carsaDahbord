
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/order_cubit/order_cubit.dart';
import 'package:flutter_web_dashboard/constants/constans.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/order_model.dart';
import 'package:flutter_web_dashboard/pages/orders_screen/orders_screen.dart';
import 'package:flutter_web_dashboard/widgets/texts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import '../../helpers/function_helper.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/CustomDropDownWidget.dart';

class DetailsOrderScreen extends StatefulWidget {
  final OrderModel orderModel;

  DetailsOrderScreen(this.orderModel);

  @override
  State<DetailsOrderScreen> createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).currentValue =
        status[widget.orderModel.order!.status!];
    OrderCubit.get(context).getOrderDetails(orderId: widget.orderModel.order!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    DateTime now =
        DateTime.parse(widget.orderModel.order!.createdAt.toString());
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is GetOrderDetailsLoad ?

          Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.blue,
              ),
            ),
          )
          :SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: homeColor),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("تفاصيل الطلب",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "pnuB",
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  ContainerDetails(
                      'رقم الطلب : ', widget.orderModel.order!.id.toString()),
                  ContainerDetails('اسم العميل : ', widget.orderModel.userName),
                  ContainerDetails(
                      'رقم الهاتف : ', widget.orderModel.userPhone),
                  ResponsiveWidget.isSmallScreen(context)
                      ? Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: "العنوان",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.5),
                                      fontFamily: "pnuB",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            widget.orderModel.address!=null? widget.orderModel.address!.lable:"",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "pnuB",
                                          color: Colors.green,
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(15),
                                  color: Colors.green,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    openGoogleMapLocation(
                                        widget.orderModel.address!.lat ?? 0.0,
                                        widget.orderModel.address!.lng ?? "");
                                  }),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            ContainerDetails(
                                'العنوان : ',
                                widget.orderModel.address != null
                                    ? widget.orderModel.address!.lable
                                    : "لايوجد"),
                            SizedBox(
                              width: 100,
                            ),
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(15),
                                color: Colors.green,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  openGoogleMapLocation(
                                      widget.orderModel.address!.lat ?? 0.0,
                                      widget.orderModel.address!.lng ?? "");
                                })
                          ],
                        ),
                  ContainerDetails(
                      'اجمالي المبلغ : ',
                      widget.orderModel.order!.price.toStringAsFixed(2) +
                          " ريال "),
                  ContainerDetails('تاريخ الطلب : ', formattedDate),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "حالة الطلب : ",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                            fontFamily: "pnuB",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 150,
                        child: OrderCubit.get(context).loadUpdate
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              )
                            : CustomDropDownWidget(
                                currentValue:
                                    OrderCubit.get(context).currentValue,
                                selectCar: false,
                                colorBackRound: Colors.green,
                                textColor: Colors.white,
                                isTwoIcons: false,
                                iconColor: Colors.white,
                                icon2: Icons.add_box_outlined,
                                icon1: Icons.search,
                                list: status
                                    .map((item) => DropdownMenuItem<dynamic>(
                                        value: item,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontFamily: 'pnuB',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                            //   widget.actionBtn(item.id);
                                            // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                          ],
                                        )))
                                    .toList(),
                                onSelect: (value) {
                                  int newStatus = status.indexOf(value);
                                  OrderCubit.get(context).currentValue = null;
                                  OrderCubit.get(context).changeValue(value);

                                  OrderCubit.get(context).updateStatusOrder(
                                      status: newStatus,
                                      id: widget.orderModel.order!.id);
                                },
                                hint: "حالة الطلب"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ResponsiveWidget.isSmallScreen(context)
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: OrderCubit.get(context).orderDetail.length,
                          itemBuilder: (_, index) {
                            ResponseOrder cart =
                            OrderCubit.get(context).orderDetail[index];
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    baseUrlImages +
                                        cart.productModel!.image!,
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Texts(
                                    color: Colors.black,
                                    title: cart.cartModel!.nameProduct,
                                    fSize: 16,
                                    weight: FontWeight.bold,
                                  ),
                                  DetailsProduct(
                                      "رقم القطعة : ",
                                      cart.productModel!.sellerId
                                          .toString(),
                                      Colors.black),
                                  DetailsProduct(
                                      "السعر : ",
                                      cart.cartModel!.price.toString(),
                                      Colors.red),
                                  DetailsProduct(
                                      "العدد المطلوب : ",
                                      cart.cartModel!.quantity.toString(),
                                      Colors.green),
                                  Directionality(
                                    textDirection:ui.TextDirection.ltr,
                                    child: DetailsProduct(
                                        "الاجمالى  : ",
                                        cart.cartModel!.total!.toStringAsFixed(2),
                                        Colors.blue),
                                  )
                                ],
                              ),
                            );
                          })
                      : SizedBox(
                          height: 350,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: OrderCubit.get(context).orderDetail.length,
                              itemBuilder: (_, index) {
                                ResponseOrder cart =
                                OrderCubit.get(context).orderDetail[index];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        baseUrlImages +
                                            cart.productModel!.image!,
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Texts(
                                        color: Colors.black,
                                        title: cart.cartModel!.nameProduct,
                                        fSize: 16,
                                        weight: FontWeight.bold,
                                      ),
                                      DetailsProduct(
                                          "رقم القطعة : ",
                                          cart.productModel!.sellerId
                                              .toString(),
                                          Colors.black),
                                      DetailsProduct(
                                          "السعر : ",
                                          cart.cartModel!.price.toString(),
                                          Colors.red),
                                      DetailsProduct(
                                          "العدد المطلوب : ",
                                          cart.cartModel!.quantity.toString(),
                                          Colors.green),
                                      DetailsProduct(
                                          "الاجمالى  : ",
                                          cart.cartModel!.total.toString(),
                                          Colors.blue)
                                    ],
                                  ),
                                );
                              }),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsProduct extends StatelessWidget {
  final String title, value;
  final Color color;

  DetailsProduct(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Texts(
          color: Colors.black,
          title: title,
          fSize: 16,
          weight: FontWeight.bold,
        ),
        SizedBox(
          width: 10,
        ),
        Texts(
          color: color,
          title: value,
          fSize: 16,
        ),
      ],
    );
  }
}

class ContainerDetails extends StatelessWidget {
  final String? title, value;

  ContainerDetails(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Directionality(
          textDirection: ui.TextDirection.rtl,
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: title,
              style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontFamily: "pnuB",
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "pnuB",
                      color: Colors.green,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_web_dashboard/constants/constans.dart';
import 'package:flutter_web_dashboard/models/workshop_model.dart';
import 'package:flutter_web_dashboard/widgets/texts.dart';

import '../../helpers/function_helper.dart';

class DetailsWorkShop extends StatelessWidget {
  final Workshops workshops;
  DetailsWorkShop(this.workshops);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            CachedNetworkImage(
              imageUrl: baseUrlImages + workshops.image!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Icon(
                  Icons.error,
                  size: 20,
                );
              },
            ),
            RowWidgetDetails(
              title: "اسم الورشة : ",
              value: workshops.name!,
            ),
            Divider(),
            RowWidgetDetails(title: "وصف الورشة : ", value: workshops.desc!),
            Divider(),
            RowWidgetDetails(title: "رقم التواصل: ", value: workshops.phone!)
            ,
            Divider(),
            RowWidgetDetails(title: "تقييم الورشة : ", value: workshops.rate!.toString()),

               Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          //  await Clipboard.setData(ClipboardData(text: model.phone));
                          luncherUrl(Uri.parse('tel://${workshops.phone}'));
                        },
                        icon: Icon(Icons.call)),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () async {
                        await Clipboard.setData(
                                ClipboardData(text: workshops.phone!))
                            .then((value) {
                          flutterToastFun(message: "تم نسخ الرقم", color: Colors.green);
                        });
                      },
                      child: Text(workshops.phone!,
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
                              'https://whatsapp://send?phone=+966${workshops.phone}'));
                        },
                        icon: Icon(Icons.call,color: Colors.green,)),
                  ],
                )
             
          ]),
        ),
      ),
    );
  }
}

class RowWidgetDetails extends StatelessWidget {
  final String title;
  final String value;

  const RowWidgetDetails({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Texts(
            title: title,
            fSize: 16,
            color: Colors.grey,
            weight: FontWeight.normal,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

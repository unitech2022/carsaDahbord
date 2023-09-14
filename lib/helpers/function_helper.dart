import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user_model.dart';

class Helpers {
  static double widthScreen = 0.0;
  static double heightScreen = 0.0;
}


String?
token = "";
UserModel? currentUser = UserModel();

pop(context) {
  Navigator.of(context).pop();
}

pushPage({required context, page}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
Future luncherUrl (url)async{
if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
showSheet(BuildContext context, child) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return Wrap(
        children: [child],
      );
    },
  );
}


flutterToastFun({message,color}){
 return Fluttertoast.showToast(
        msg: message,
        
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:color,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
replacePage({required context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

popMultiplePages(context, count) {
  for (int i = 0; i < count; i++) {
    Navigator.of(context).pop();
  }
}

flexSpace(int f) {
  return Flexible(flex: f, child: Container());
}

bool isLogin() {
  return token != "";
}

readToken() async {
  // await getBaseUrl();

  final prefs = await SharedPreferences.getInstance();

  try {
    //
    // token = (await storage.read(key: "token"));
    // currentUser.id=( await storage.read(key: "id"));
    // // currentUser.role=( await storage.read(key: "role"));
    // currentUser.accessFailedCount =( await storage.read(key: "accessFailedCount"));
    // // currentUser.fullName=( await storage.read(key: "name"));
    // // currentUser.imageUrl=( await storage.read(key: "image"));
    // printFunction("token : ${currentUser.id}");

    token = prefs.getString('token');
    currentUser!.id = prefs.getString('id');

    currentUser!.fullName = prefs.getString('fullName');
    currentUser!.imageUrl = prefs.getString('imageUrl');
    currentUser!.userName = prefs.getString('email');

    // currentUser.id= prefs.getString('id');

  } catch (e) {}
}

isRegistered() {
  return (token != "" && token != null);
}

saveToken() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('token', token!);
  await prefs.setString('id', currentUser!.id!);
  await prefs.setString('fullName', currentUser!.fullName!);
  await prefs.setString('imageUrl', currentUser!.imageUrl ?? "notFound");
  await prefs.setString('email', currentUser!.userName!);

}

Future logOut() async {
  final prefs = await SharedPreferences.getInstance();
  // Remove data for the 'counter' key.
  await prefs.remove('token');
}

// openGoogleMapLocation(lat, lng) async {
//   String mapOptions = [
//     // 'saddr=${locData.latitude},${locData.longitude}',
//     'daddr=$lat,$lng',
//     'dir_action=navigate'
//   ].join('&');

//   final url = 'https://www.google.com/maps?$mapOptions';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

openGoogleMapLocation(lat, lng) async {
  String mapOptions = [
   'saddr=${locData.latitude},${locData.longitude}',
    'daddr=$lat,$lng',
    'dir_action=navigate'
  ].join('&');

  String url = 'https://www.google.com/maps?$mapOptions';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),mode: LaunchMode.inAppWebView);
  } else {
    throw 'Could not launch $url';
  }
}

late String currentLocation = "";
LocationData locData = LocationData.fromMap({});
Future getLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locData = await location.getLocation();
  print("${locData.latitude} lat:${locData.longitude} LNG:");
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
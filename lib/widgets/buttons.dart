import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text, fontFamily;
  final void Function()? onPress;
  final Color? color, textColor;
  final double? height;
  final double? fontSize;
  double width;
  double redius;
  bool isBorder;
  bool isCustomColor;
  CustomButton(
      {this.width=double.infinity,

        this.text,
        this.fontFamily,
        this.onPress,
        this.color,
        this.textColor,
        this.fontSize,
        this.height,
        this.isBorder=true,
        this.redius=50,
        this.isCustomColor=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        elevation: 5,
        color:color,
        padding: const EdgeInsets.symmetric(vertical: 3),
        onPressed: onPress,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(redius),
            side:isBorder  ? BorderSide(color: color!,width: 1.5): BorderSide(color: color!,width: 0)),
        child: Center(
          child:
          Text(
            text!,
            style: TextStyle(

              fontFamily: fontFamily,
              fontSize: fontSize,
              color:Colors.white,
              height: 1.2,
              fontWeight:FontWeight.bold,
            ),

          ),
        ),
      ),
    );
  }
}








class CustomButton3 extends StatelessWidget {
  final String? text, fontFamily;
  final void Function()? onPress;
  final Color? color, textColor;
  final double? height;
  final double? fontSize;
  double width;
  double redius;
  bool isBorder;
  bool isCustomColor;
  CustomButton3(
      {this.width=double.infinity,

        this.text,
        this.fontFamily,
        this.onPress,
        this.color,
        this.textColor,
        this.fontSize,
        this.height,
        this.isBorder=true,
        this.redius=50,
        this.isCustomColor=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        elevation: 5,

        padding: const EdgeInsets.symmetric(vertical: 3),
        onPressed: onPress,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(redius),
            side: BorderSide(color: Colors.black,width: 1)),
        child: Center(
          child:
          Text(
            text!,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              color: Theme.of(context).textTheme.bodyText1!.color,
              height: 1.2,
              fontWeight:FontWeight.bold,
            ),

          ),
        ),
      ),
    );
  }
}
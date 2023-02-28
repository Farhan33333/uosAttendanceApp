import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmallIconButton extends StatelessWidget {
  const SmallIconButton(
      {Key? key,
      @required this.onPressed,
      this.icon = Icons.arrow_back,
      this.height = 78.0,
      this.color = Colors.amber})
      : super(key: key);

  final onPressed;
  final color;
  final icon;
  final height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: 66,
          height: height,
          decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10))),
          child: Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
    );
  }
}

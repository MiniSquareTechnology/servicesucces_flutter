import 'package:flutter/material.dart';

class SpaceInkWell extends StatelessWidget {
  final Widget child;
  final Size size;
  const SpaceInkWell(
      {Key? key,
      required this.child,
      this.size = const Size(
        44,
        44,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Stack(
        alignment: Alignment.center,
        children: [
          // SizedBox(
          //   height: size.height,
          //   width: size.width,
          // ),
          child,
        ],
      ),
    );
  }
}

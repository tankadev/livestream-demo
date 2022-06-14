import 'package:flutter/material.dart';

import 'package:hitalive/configs/configs.dart';

class AWClickContent extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final double borderRadius;
  final Color color;

  const AWClickContent(
      {Key? key,
      required this.child,
      required this.onTap,
      required this.borderRadius,
      this.color = AppColor.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}

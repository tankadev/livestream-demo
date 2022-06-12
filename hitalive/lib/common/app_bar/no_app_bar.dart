import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hitalive/configs/configs.dart';

class AWNoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const AWNoAppBar({Key? key, this.backgroundColor = AppColor.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: backgroundColor
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0.0);
}

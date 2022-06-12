import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hitalive/configs/configs.dart';

class AWCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final dynamic title;
  final bool isShowElevation;
  final bool isShowBackBtn;

  const AWCustomAppBar({
    Key? key,
    this.backgroundColor = AppColor.white,
    required this.title,
    this.isShowElevation = false,
    this.isShowBackBtn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: isShowElevation ? 3.0 : 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: title is Widget
          ? title
          : Text(
              title,
              style: AppTextStyle.mediumText,
            ),
      centerTitle: false,
      leading: isShowBackBtn ? IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.black,
          size: 25,
        ),
        iconSize: 20.0,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ) : null,
      automaticallyImplyLeading: isShowBackBtn,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

import 'package:hitalive/configs/configs.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: Text('Notification'),
        ),
      ),
    );
  }
}
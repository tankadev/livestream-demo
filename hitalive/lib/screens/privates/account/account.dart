import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/configs/configs.dart';

import 'widgets/w_footer.dart';
import 'widgets/w_header.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SizedBox(
          width: double.infinity,
          height: 100.h,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WAccountHeader()
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 90.0,
                left: 0,
                right: 0,
                child: WAccountFooter(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
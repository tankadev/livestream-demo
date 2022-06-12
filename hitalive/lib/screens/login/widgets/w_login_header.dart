import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/configs/configs.dart';

class WLoginHeader extends StatelessWidget {
  const WLoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.appBanner,
          width: SizerUtil.deviceType == DeviceType.mobile ? 50.w : 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 2.h,
        ),
        RichText(
          text: const TextSpan(
            text: 'Đăng nhập ',
            style: AppTextStyle.mediumText,
            children: [
              TextSpan(
                text: 'để bắt đầu ngay',
                style: AppTextStyle.mediumText,
              ),
            ],
          ),
        )
      ],
    );
  }
}

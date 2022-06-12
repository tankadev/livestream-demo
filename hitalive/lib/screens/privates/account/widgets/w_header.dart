import 'package:flutter/material.dart';

import 'package:hitalive/configs/configs.dart';

class WAccountHeader extends StatelessWidget {
  const WAccountHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90.0,
            height: 90.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColor.grey70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nguyễn Văn A',
                  style: AppTextStyle.mediumText,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  'example@gmail.com',
                  style: AppTextStyle.smallTextBlack,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  '0123456788',
                  style: AppTextStyle.smallTextBlack,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/configs/configs.dart';

enum DialogAlertType { success, info, error }

class DialogUtil {
  static final DialogUtil _instance = DialogUtil.internal();

  DialogUtil.internal();

  factory DialogUtil() => _instance;

  static void showAlert(
    BuildContext context, {
    required String title,
    required String content,
    required String btnConfirmText,
    required VoidCallback? onConfirm,
    required DialogAlertType type,
    bool isShowCancelBtn = false,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 55.h,
                maxWidth: SizerUtil.deviceType == DeviceType.mobile
                    ? MediaQuery.of(context).size.width * 0.9
                    : MediaQuery.of(context).size.width * 0.7),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _renderIconType(type),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    title,
                    style: AppTextStyle.mediumTextBold,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    content,
                    style: AppTextStyle.normalText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onConfirm,
                            child: Text(
                              btnConfirmText.toUpperCase(),
                              style: SizerUtil.deviceType == DeviceType.mobile
                                  ? AppTextStyle.smallTextWhite
                                  : AppTextStyle.normalTextWhite,
                            ),
                          ),
                        ),
                        isShowCancelBtn
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColor.grey100,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'HỦY',
                                      style: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? AppTextStyle.smallTextWhite
                                          : AppTextStyle.normalTextWhite,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _renderIconType(DialogAlertType type) {
    switch (type) {
      case DialogAlertType.success:
        return const Icon(
          Icons.check_circle,
          size: 50,
          color: AppColor.success,
        );
      case DialogAlertType.info:
        return const Icon(
          Icons.info,
          size: 50,
          color: AppColor.info,
        );
      case DialogAlertType.error:
        return const Icon(
          Icons.error,
          size: 50,
          color: AppColor.error,
        );
    }
  }

  static Future<DateTime?> showDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showRoundedDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      borderRadius: 15,
      theme: ThemeData(primarySwatch: Palette.kToDark),
      height: 40.h,
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      ),
    );
  }
}

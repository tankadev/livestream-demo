import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hitalive/common/common.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/utilities/utilities.dart';

class WVerifyInfoForm extends StatelessWidget {
  WVerifyInfoForm({Key? key}) : super(key: key);

  late final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<VerifyInfoBloc, VerifyInfoState>(
      builder: (context, state) {
        return ReactiveForm(
          formGroup: state.verifyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    const Text(
                      'Họ',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'lastName',
                      validationMessages: (control) => {
                        'required': 'Vui lòng nhập họ',
                      },
                      textInputAction: TextInputAction.next,
                      style: AppTextStyle.normalText,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Tên',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'firstName',
                      validationMessages: (control) => {
                        'required': 'Vui lòng nhập tên',
                      },
                      textInputAction: TextInputAction.next,
                      style: AppTextStyle.normalText,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Địa chỉ',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'address',
                      validationMessages: (control) => {
                        'required': 'Vui lòng nhập địa chỉ',
                      },
                      textInputAction: TextInputAction.next,
                      style: AppTextStyle.normalText,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Ngày sinh',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'birthday',
                      validationMessages: (control) => {
                        'required': 'Vui lòng chọn ngày sinh',
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        isDense: true,
                        fillColor: AppColor.white,
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.grey90),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.today,
                            size: 20.0,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _showDatePicker(context, state);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Hình CCCD/Bằng lái',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    AWClickContent(
                      onTap: () async {
                        final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          File imageFile = File(photo.path);
                          context
                              .read<VerifyInfoBloc>()
                              .add(SelectedImage(file: imageFile));
                        }
                      },
                      borderRadius: 5.0,
                      child: Container(
                        color: AppColor.grey70,
                        width: double.infinity,
                        height: 30.0,
                        child: const Center(
                          child: Text('Chọn hình'),
                        ),
                      ),
                    ),
                    state.image != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Image.file(
                              state.image ?? File(''),
                              width: double.infinity,
                              height: 30.h,
                            ),
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _showDatePicker(
      BuildContext context, VerifyInfoState state) async {
    DateTime? newDateTime = await DialogUtil.showDatePicker(
      context: context,
      initialDate: state.selectedBirthday ?? DateTime(DateTime.now().year - 10),
      firstDate: DateTime(DateTime.now().year - 90),
      lastDate: DateTime(DateTime.now().year - 10),
    );
    if (newDateTime != null) {
      context.read<VerifyInfoBloc>().add(SelectedBirthday(day: newDateTime));
    }
  }
}

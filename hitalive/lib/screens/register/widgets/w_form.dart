import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/configs/configs.dart';

class WRegisterForm extends StatelessWidget {

  const WRegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return ReactiveForm(
          formGroup: state.registerForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
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
                      'Email',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'email',
                      validationMessages: (control) => {
                        'required': 'Vui lòng nhập email',
                        'email': 'Vui lòng nhập đúng định dạng email'
                      },
                      textInputAction: TextInputAction.next,
                      style: AppTextStyle.normalText,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'example@gmail.com',
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Mật khẩu',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      validationMessages: (control) =>
                      {'required': 'Vui lòng nhập mật khẩu'},
                      textInputAction: TextInputAction.done,
                      style: AppTextStyle.normalText,
                      obscureText: state.obscurePassword,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Nhập mật khẩu đăng nhập mới',
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                              ChangeObscurePassword(
                                  value: !state.obscurePassword),
                            );
                          },
                          child: Icon(
                            state.obscurePassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Xác nhận mật khẩu',
                      style: AppTextStyle.normalText,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ReactiveTextField(
                      formControlName: 'rePassword',
                      validationMessages: (control) =>
                      {'mustMatch': 'Mật khẩu xác nhận không khớp với mật khẩu'},
                      textInputAction: TextInputAction.done,
                      style: AppTextStyle.normalText,
                      obscureText: state.obscureRePassword,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Nhập mật khẩu xác nhận',
                        isDense: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                              ChangeObscureRePassword(
                                  value: !state.obscureRePassword),
                            );
                          },
                          child: Icon(
                            state.obscureRePassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

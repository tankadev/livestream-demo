import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/repositories/repositories.dart';
import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/common/common.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/utilities/utilities.dart';
import 'package:hitalive/http/error_code.dart';

import 'widgets/w_login_footer.dart';
import 'widgets/w_login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: BlocProvider(
        create: (BuildContext context) => LoginBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: const AWCustomAppBar(
            title: '',
            isShowBackBtn: false,
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const WLoginHeader(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 7.w),
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.status == EBlocStateStatus.inProgress) {
                              LoadingOverlay.of(context).show();
                            }

                            if (state.status == EBlocStateStatus.success ||
                                state.status == EBlocStateStatus.failure) {
                              LoadingOverlay.of(context).hide();
                            }

                            if (state.status == EBlocStateStatus.failure) {
                              DialogUtil.showAlert(
                                context,
                                type: DialogAlertType.error,
                                title: 'Thông báo',
                                content: ErrorCode.errorMgs(state.errorCode),
                                btnConfirmText: 'OK',
                                onConfirm: () {
                                  Navigator.pop(context);
                                },
                              );
                            }
                          },
                          builder: (context, state) {
                            return _buildLoginForm(context, state);
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const WLoginFooter()
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginState state) {
    return ReactiveForm(
      formGroup: state.loginForm,
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
                    hintText: 'Nhập mật khẩu',
                    isDense: true,
                    suffixIcon: InkWell(
                      onTap: () {
                        context.read<LoginBloc>().add(
                              ChangeObscurePasswordLogin(
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
                  height: 5.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        },
                        child: Text(
                          'ĐĂNG NHẬP',
                          style: AppTextStyle.normalTextWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

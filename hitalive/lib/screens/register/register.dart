import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:hitalive/common/common.dart';
import 'package:hitalive/configs/configs.dart';
import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/http/error_code.dart';
import 'package:hitalive/utilities/utilities.dart';
import 'package:hitalive/blocs/blocs.dart';
import 'package:hitalive/repositories/repositories.dart';

import 'widgets/w_form.dart';
import 'widgets/w_header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: BlocProvider(
        create: (BuildContext context) => RegisterBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: const AWCustomAppBar(
            title: '',
          ),
          body: SizedBox(
            height: 100.h,
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      const WRegisterHeader(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 3.w),
                        child: BlocListener<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            if (state.status == EBlocStateStatus.inProgress) {
                              LoadingOverlay.of(context).show();
                            }

                            if (state.status == EBlocStateStatus.success ||
                                state.status == EBlocStateStatus.failure) {
                              LoadingOverlay.of(context).hide();
                            }

                            if (state.status == EBlocStateStatus.success) {
                              DialogUtil.showAlert(
                                context,
                                type: DialogAlertType.success,
                                title: 'Đăng ký thành công',
                                content:
                                    'Bạn đã có thể đăng nhập với tài khoản vừa tạo',
                                btnConfirmText: 'OK',
                                onConfirm: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
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
                          child: const WRegisterForm(),
                        ),
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    color: AppColor.white,
                    child: SizedBox(
                      width: double.infinity,
                      child: Builder(
                        builder: (contextRegister) {
                          return ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              contextRegister.read<RegisterBloc>().add(
                                    const RegisterSubmitted(),
                                  );
                            },
                            child: Text(
                              'ĐĂNG KÝ',
                              style: AppTextStyle.normalTextWhite,
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

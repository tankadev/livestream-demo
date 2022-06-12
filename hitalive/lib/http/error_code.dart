class ErrorCode {
  static String errorMgs(String errorCode) {
    String error = '';
    switch (errorCode) {
      // case ErrorString.serverPhoneNumberWaitingActive:
      //   error = '${translate?.apiErrPhoneNumberWaitingActive}';
      //   break;
      default:
        error = 'Lỗi không xác định';
        break;
    }
    return error;
  }
}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpVerifyPressed>(_onOtpVerifyPressed);
  }

  FutureOr<void> _onOtpVerifyPressed(
      OtpVerifyPressed event, Emitter<OtpState> emit) async {
    emit(OtpVerifyLoading());
    try {
      // Verify Otp
      await Future.delayed(Duration(seconds: 3));
      await doVerifyOtp(event.otps);
      emit(OtpVerifySuccess());
    } catch (_) {
      emit(OtpVerifyFail());
    }
  }

  FutureOr<void> doVerifyOtp(List<String> otps) {
    print(otps);
  }
}

part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}

class OtpVerifyPressed extends OtpEvent{
  final List<String> otps;

  OtpVerifyPressed({
    required this.otps,
  });
}
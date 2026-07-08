import 'package:equatable/equatable.dart';

class AuthSessionEntity extends Equatable {
  final String token;
  final String? channel;
  final String? qrCode;
  final bool otpEmail;
  final bool otpSms;
  final bool authMobileApp;
  final bool authQr;
  final bool isOtpRequired;

  const AuthSessionEntity({
    required this.token,
    this.channel,
    this.qrCode,
    this.otpEmail = false,
    this.otpSms = false,
    this.authMobileApp = false,
    this.authQr = false,
    this.isOtpRequired = false,
  });

  @override
  List<Object?> get props => [
    token,
    channel,
    qrCode,
    otpEmail,
    otpSms,
    authMobileApp,
    authQr,
    isOtpRequired,
  ];
}
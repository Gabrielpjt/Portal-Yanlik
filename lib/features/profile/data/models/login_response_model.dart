import '../../domain/entities/auth_session_entity.dart';

class LoginResponseModel extends AuthSessionEntity {
  const LoginResponseModel({
    required super.token,
    super.channel,
    super.qrCode,
    super.otpEmail,
    super.otpSms,
    super.authMobileApp,
    super.authQr,
    super.isOtpRequired,
  });

  factory LoginResponseModel.fromProxyJson(Map<String, dynamic> json) {
    final data = _asMap(json['data']) ?? json;
    final otp = _asMap(data['otp']);
    final authApp = _asMap(data['auth_app']);

    final token = data['token']?.toString() ?? '';
    final otpEmail = _toBool(otp?['email']);
    final otpSms = _toBool(otp?['sms']);
    final authMobileApp = _toBool(authApp?['mobile_app']);
    final authQr = _toBool(authApp?['qr']);

    return LoginResponseModel(
      token: token,
      channel: data['channel']?.toString(),
      qrCode: data['qrcode']?.toString(),
      otpEmail: otpEmail,
      otpSms: otpSms,
      authMobileApp: authMobileApp,
      authQr: authQr,
      isOtpRequired: token.isEmpty &&
          (otpEmail || otpSms || authMobileApp || authQr),
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value == 1;
    }

    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }

    return false;
  }
}
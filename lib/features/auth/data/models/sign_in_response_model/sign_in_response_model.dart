import 'user.dart';

class SignInResponseModel {
  int? statusCode;
  bool? status;
  String? message;
  User? user;

  SignInResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.user,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      statusCode: json['statusCode'] as int?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'status': status,
        'message': message,
        'user': user?.toJson(),
      };
}

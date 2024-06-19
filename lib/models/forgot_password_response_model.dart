class ForgotPasswordResponseModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  ForgotPasswordResponseModel(
      {this.statusCode, this.status, this.message, this.data});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? email;
  Null? profileImage;
  int? role;
  int? status;
  int? emailVerificationOtp;
  int? notification;
  Null? emailNotification;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.fullName,
        this.email,
        this.profileImage,
        this.role,
        this.status,
        this.emailVerificationOtp,
        this.notification,
        this.emailNotification,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    role = json['role'];
    status = json['status'];
    emailVerificationOtp = json['email_verification_otp'];
    notification = json['notification'];
    emailNotification = json['email_notification'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['role'] = this.role;
    data['status'] = this.status;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['notification'] = this.notification;
    data['email_notification'] = this.emailNotification;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

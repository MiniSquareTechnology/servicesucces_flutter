class LoginResponseModel {
  LoginResponseModel({
    num? statusCode,
    String? status,
    String? message,
    Data? data,
  }) {
    _statusCode = statusCode;
    _status = status;
    _message = message;
    _data = data;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _status;
  String? _message;
  Data? _data;

  LoginResponseModel copyWith({
    num? statusCode,
    String? status,
    String? message,
    Data? data,
  }) =>
      LoginResponseModel(
        statusCode: statusCode ?? _statusCode,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get status => _status;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    num? id,
    String? fullName,
    String? email,
    dynamic profileImage,
    num? role,
    num? status,
    dynamic emailVerificationOtp,
    num? notification,
    dynamic emailNotification,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? authToken,
  }) {
    _id = id;
    _fullName = fullName;
    _email = email;
    _profileImage = profileImage;
    _role = role;
    _status = status;
    _emailVerificationOtp = emailVerificationOtp;
    _notification = notification;
    _emailNotification = emailNotification;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _authToken = authToken;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _email = json['email'];
    _profileImage = json['profile_image'];
    _role = json['role'];
    _status = json['status'];
    _emailVerificationOtp = json['email_verification_otp'];
    _notification = json['notification'];
    _emailNotification = json['email_notification'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _authToken = json['auth_token'];
  }

  num? _id;
  String? _fullName;
  String? _email;
  dynamic _profileImage;
  num? _role;
  num? _status;
  dynamic _emailVerificationOtp;
  num? _notification;
  dynamic _emailNotification;
  String? _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  String? _authToken;

  Data copyWith({
    num? id,
    String? fullName,
    String? email,
    dynamic profileImage,
    num? role,
    num? status,
    dynamic emailVerificationOtp,
    num? notification,
    dynamic emailNotification,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? authToken,
  }) =>
      Data(
        id: id ?? _id,
        fullName: fullName ?? _fullName,
        email: email ?? _email,
        profileImage: profileImage ?? _profileImage,
        role: role ?? _role,
        status: status ?? _status,
        emailVerificationOtp: emailVerificationOtp ?? _emailVerificationOtp,
        notification: notification ?? _notification,
        emailNotification: emailNotification ?? _emailNotification,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        authToken: authToken ?? _authToken,
      );

  num? get id => _id;

  String? get fullName => _fullName;

  String? get email => _email;

  dynamic get profileImage => _profileImage;

  num? get role => _role;

  num? get status => _status;

  dynamic get emailVerificationOtp => _emailVerificationOtp;

  num? get notification => _notification;

  dynamic get emailNotification => _emailNotification;

  String? get emailVerifiedAt => _emailVerifiedAt;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get authToken => _authToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['email'] = _email;
    map['profile_image'] = _profileImage;
    map['role'] = _role;
    map['status'] = _status;
    map['email_verification_otp'] = _emailVerificationOtp;
    map['notification'] = _notification;
    map['email_notification'] = _emailNotification;
    map['email_verified_at'] = _emailVerifiedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['auth_token'] = _authToken;
    return map;
  }
}

class AddJobResponseModel {
  AddJobResponseModel({
    num? statusCode,
    String? status,
    String? message,
    AddJobResponseData? data,
  }) {
    _statusCode = statusCode;
    _status = status;
    _message = message;
    _data = data;
  }

  AddJobResponseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? AddJobResponseData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _status;
  String? _message;
  AddJobResponseData? _data;

  AddJobResponseModel copyWith({
    num? statusCode,
    String? status,
    String? message,
    AddJobResponseData? data,
  }) =>
      AddJobResponseModel(
        statusCode: statusCode ?? _statusCode,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get status => _status;

  String? get message => _message;

  AddJobResponseData? get data => _data;

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

class AddJobResponseData {
  AddJobResponseData({
    String? customerName,
    String? serviceTitanNumber,
    String? dispatchTime,
    String? arrivalTime,
    String? checkoutTime,
    String? totalHours,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _customerName = customerName;
    _serviceTitanNumber = serviceTitanNumber;
    _dispatchTime = dispatchTime;
    _arrivalTime = arrivalTime;
    _checkoutTime = checkoutTime;
    _totalHours = totalHours;
    _userId = userId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  AddJobResponseData.fromJson(dynamic json) {
    _customerName = json['customer_name'];
    _serviceTitanNumber = json['service_titan_number'];
    _dispatchTime = json['dispatch_time'];
    _arrivalTime = json['arrival_time'];
    _checkoutTime = json['checkout_time'];
    _totalHours = json['total_hours'];
    _userId = json['user_id'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  String? _customerName;
  String? _serviceTitanNumber;
  String? _dispatchTime;
  String? _arrivalTime;
  String? _checkoutTime;
  String? _totalHours;
  num? _userId;
  String? _updatedAt;
  String? _createdAt;
  num? _id;

  AddJobResponseData copyWith({
    String? customerName,
    String? serviceTitanNumber,
    String? dispatchTime,
    String? arrivalTime,
    String? checkoutTime,
    String? totalHours,
    num? userId,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      AddJobResponseData(
        customerName: customerName ?? _customerName,
        serviceTitanNumber: serviceTitanNumber ?? _serviceTitanNumber,
        dispatchTime: dispatchTime ?? _dispatchTime,
        arrivalTime: arrivalTime ?? _arrivalTime,
        checkoutTime: checkoutTime ?? _checkoutTime,
        totalHours: totalHours ?? _totalHours,
        userId: userId ?? _userId,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );

  String? get customerName => _customerName;

  String? get serviceTitanNumber => _serviceTitanNumber;

  String? get dispatchTime => _dispatchTime;

  String? get arrivalTime => _arrivalTime;

  String? get checkoutTime => _checkoutTime;

  String? get totalHours => _totalHours;

  num? get userId => _userId;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_name'] = _customerName;
    map['service_titan_number'] = _serviceTitanNumber;
    map['dispatch_time'] = _dispatchTime;
    map['arrival_time'] = _arrivalTime;
    map['checkout_time'] = _checkoutTime;
    map['total_hours'] = _totalHours;
    map['user_id'] = _userId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}

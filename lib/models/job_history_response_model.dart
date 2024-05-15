class JobHistoryResponseModel {
  JobHistoryResponseModel({
    num? statusCode,
    String? status,
    String? message,
    List<JobHistoryData>? data,
  }) {
    _statusCode = statusCode;
    _status = status;
    _message = message;
    _data = data;
  }

  JobHistoryResponseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JobHistoryData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _status;
  String? _message;
  List<JobHistoryData>? _data;

  JobHistoryResponseModel copyWith({
    num? statusCode,
    String? status,
    String? message,
    List<JobHistoryData>? data,
  }) =>
      JobHistoryResponseModel(
        statusCode: statusCode ?? _statusCode,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get status => _status;

  String? get message => _message;

  List<JobHistoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class JobHistoryData {
  JobHistoryData(
      {num? id,
      String? customerName,
      String? serviceTitanNumber,
      num? userId,
      String? dispatchTime,
      String? arrivalTime,
      String? checkoutTime,
      String? createdAt,
      String? updatedAt,
      String? totalHours,
      List<JobForm>? jobForm,
      List<EditJobs>? editJobs}) {
    _id = id;
    _customerName = customerName;
    _serviceTitanNumber = serviceTitanNumber;
    _userId = userId;
    _dispatchTime = dispatchTime;
    _arrivalTime = arrivalTime;
    _checkoutTime = checkoutTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _totalHours = totalHours;
    _jobForm = jobForm;
    _editJobs = editJobs;
  }

  JobHistoryData.fromJson(dynamic json) {
    _id = json['id'];
    _customerName = json['customer_name'];
    _serviceTitanNumber = json['service_titan_number'];
    _userId = json['user_id'];
    _dispatchTime = json['dispatch_time'];
    _arrivalTime = json['arrival_time'];
    _checkoutTime = json['checkout_time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _totalHours = json['total_hours'];
    if (json['job_form'] != null) {
      _jobForm = [];
      json['job_form'].forEach((v) {
        _jobForm?.add(JobForm.fromJson(v));
      });
    }
    if (json['edit_jobs'] != null) {
      _editJobs = <EditJobs>[];
      json['edit_jobs'].forEach((v) {
        _editJobs!.add(EditJobs.fromJson(v));
      });
    }
  }

  num? _id;
  String? _customerName;
  String? _serviceTitanNumber;
  num? _userId;
  String? _dispatchTime;
  String? _arrivalTime;
  String? _checkoutTime;
  String? _createdAt;
  String? _updatedAt;
  String? _totalHours;
  List<JobForm>? _jobForm;
  List<EditJobs>? _editJobs;

  JobHistoryData copyWith(
          {num? id,
          String? customerName,
          String? serviceTitanNumber,
          num? userId,
          String? dispatchTime,
          String? arrivalTime,
          String? checkoutTime,
          String? createdAt,
          String? updatedAt,
          String? totalHours,
          List<JobForm>? jobForm,
          List<EditJobs>? editJobs}) =>
      JobHistoryData(
        id: id ?? _id,
        customerName: customerName ?? _customerName,
        serviceTitanNumber: serviceTitanNumber ?? _serviceTitanNumber,
        userId: userId ?? _userId,
        dispatchTime: dispatchTime ?? _dispatchTime,
        arrivalTime: arrivalTime ?? _arrivalTime,
        checkoutTime: checkoutTime ?? _checkoutTime,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        totalHours: totalHours ?? _totalHours,
        jobForm: jobForm ?? _jobForm,
        editJobs: editJobs ?? _editJobs,
      );

  num? get id => _id;

  String? get customerName => _customerName;

  String? get serviceTitanNumber => _serviceTitanNumber;

  num? get userId => _userId;

  String? get dispatchTime => _dispatchTime;

  String? get arrivalTime => _arrivalTime;

  String? get checkoutTime => _checkoutTime;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get totalHours => _totalHours;

  List<JobForm>? get jobForm => _jobForm;

  List<EditJobs>? get editJobs => _editJobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_name'] = _customerName;
    map['service_titan_number'] = _serviceTitanNumber;
    map['user_id'] = _userId;
    map['dispatch_time'] = _dispatchTime;
    map['arrival_time'] = _arrivalTime;
    map['checkout_time'] = _checkoutTime;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['total_hours'] = _totalHours;
    if (_jobForm != null) {
      map['job_form'] = _jobForm?.map((v) => v.toJson()).toList();
    }
    if (editJobs != null) {
      map['edit_jobs'] = editJobs!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class JobForm {
  JobForm({
    num? id,
    num? jobId,
    num? userId,
    String? serviceTitanNumber,
    num? totalAmount,
    num? comission,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _jobId = jobId;
    _userId = userId;
    _serviceTitanNumber = serviceTitanNumber;
    _totalAmount = totalAmount;
    _comission = comission;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  JobForm.fromJson(dynamic json) {
    _id = json['id'];
    _jobId = json['job_id'];
    _userId = json['user_id'];
    _serviceTitanNumber = json['service_titan_number'];
    _totalAmount = json['total_amount'];
    _comission = json['comission'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _jobId;
  num? _userId;
  String? _serviceTitanNumber;
  num? _totalAmount;
  num? _comission;
  num? _status;
  String? _createdAt;
  String? _updatedAt;

  JobForm copyWith({
    num? id,
    num? jobId,
    num? userId,
    String? serviceTitanNumber,
    num? totalAmount,
    num? comission,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      JobForm(
        id: id ?? _id,
        jobId: jobId ?? _jobId,
        userId: userId ?? _userId,
        serviceTitanNumber: serviceTitanNumber ?? _serviceTitanNumber,
        totalAmount: totalAmount ?? _totalAmount,
        comission: comission ?? _comission,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get jobId => _jobId;

  num? get userId => _userId;

  String? get serviceTitanNumber => _serviceTitanNumber;

  num? get totalAmount => _totalAmount;

  num? get comission => _comission;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_id'] = _jobId;
    map['user_id'] = _userId;
    map['service_titan_number'] = _serviceTitanNumber;
    map['total_amount'] = _totalAmount;
    map['comission'] = _comission;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class EditJobs {
  int? id;
  int? userId;
  int? jobId;
  dynamic oldData;
  dynamic newData;
  String? comment;
  String? createdAt;
  String? updatedAt;

  EditJobs(
      {this.id,
      this.userId,
      this.jobId,
      this.oldData,
      this.newData,
      this.comment,
      this.createdAt,
      this.updatedAt});

  EditJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobId = json['job_id'];
    oldData = json['old_data'];
    newData = json['new_data'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['job_id'] = jobId;
    data['old_data'] = oldData;
    data['new_data'] = newData;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

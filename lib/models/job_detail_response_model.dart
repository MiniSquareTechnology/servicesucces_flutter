class JobDetailResponseModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  JobDetailResponseModel(
      {this.statusCode, this.status, this.message, this.data});

  JobDetailResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? customerName;
  String? serviceTitanNumber;
  int? userId;
  String? dispatchTime;
  String? dispatchAddress;
  String? dispatchLat;
  String? dispatchLong;
  String? arrivalTime;
  String? arrivalAddress;
  String? arrivalLat;
  String? arrivalLong;
  String? checkoutTime;
  String? checkoutAddress;
  String? checkoutLat;
  String? checkoutLong;
  String? createdAt;
  String? updatedAt;
  String? totalHours;
  List<JobForm>? jobForm;
  List<EditJobs>? editJobs;

  Data(
      {this.id,
        this.customerName,
        this.serviceTitanNumber,
        this.userId,
        this.dispatchTime,
        this.dispatchAddress,
        this.dispatchLat,
        this.dispatchLong,
        this.arrivalTime,
        this.arrivalAddress,
        this.arrivalLat,
        this.arrivalLong,
        this.checkoutTime,
        this.checkoutAddress,
        this.checkoutLat,
        this.checkoutLong,
        this.createdAt,
        this.updatedAt,
        this.totalHours,
        this.jobForm,
        this.editJobs});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    serviceTitanNumber = json['service_titan_number'];
    userId = json['user_id'];
    dispatchTime = json['dispatch_time'];
    dispatchAddress = json['dispatch_address'];
    dispatchLat = json['dispatch_lat'];
    dispatchLong = json['dispatch_long'];
    arrivalTime = json['arrival_time'];
    arrivalAddress = json['arrival_address'];
    arrivalLat = json['arrival_lat'];
    arrivalLong = json['arrival_long'];
    checkoutTime = json['checkout_time'];
    checkoutAddress = json['checkout_address'];
    checkoutLat = json['checkout_lat'];
    checkoutLong = json['checkout_long'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalHours = json['total_hours'];
    if (json['job_form'] != null) {
      jobForm = <JobForm>[];
      json['job_form'].forEach((v) {
        jobForm!.add( JobForm.fromJson(v));
      });
    }
    if (json['edit_jobs'] != null) {
      editJobs = <EditJobs>[];
      json['edit_jobs'].forEach((v) {
        editJobs!.add( EditJobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['service_titan_number'] = serviceTitanNumber;
    data['user_id'] = userId;
    data['dispatch_time'] = dispatchTime;
    data['dispatch_address'] = dispatchAddress;
    data['dispatch_lat'] = dispatchLat;
    data['dispatch_long'] = dispatchLong;
    data['arrival_time'] = arrivalTime;
    data['arrival_address'] = arrivalAddress;
    data['arrival_lat'] = arrivalLat;
    data['arrival_long'] = arrivalLong;
    data['checkout_time'] = checkoutTime;
    data['checkout_address'] = checkoutAddress;
    data['checkout_lat'] = checkoutLat;
    data['checkout_long'] = checkoutLong;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_hours'] = totalHours;
    if (jobForm != null) {
      data['job_form'] = jobForm!.map((v) => v.toJson()).toList();
    }
    if (editJobs != null) {
      data['edit_jobs'] = editJobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobForm {
  int? id;
  int? jobId;
  int? userId;
  String? serviceTitanNumber;
  int? totalAmount;
  int? comission;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic comissionAmount;
  int? jobFormType;
  int? isLead;
  dynamic adminComissionPer;
  dynamic adminComissionAmountPer;

  JobForm(
      {this.id,
        this.jobId,
        this.userId,
        this.serviceTitanNumber,
        this.totalAmount,
        this.comission,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.comissionAmount,
        this.jobFormType,
        this.isLead,
        this.adminComissionPer,
        this.adminComissionAmountPer});

  JobForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    userId = json['user_id'];
    serviceTitanNumber = json['service_titan_number'];
    totalAmount = json['total_amount'];
    comission = json['comission'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    comissionAmount = json['comission_amount'];
    jobFormType = json['job_form_type'];
    isLead = json['is_lead'];
    adminComissionPer = json['admin_comission_per'];
    adminComissionAmountPer = json['admin_comission_amount_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['user_id'] = userId;
    data['service_titan_number'] = serviceTitanNumber;
    data['total_amount'] = totalAmount;
    data['comission'] = comission;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['comission_amount'] = comissionAmount;
    data['job_form_type'] = jobFormType;
    data['is_lead'] = isLead;
    data['admin_comission_per'] = adminComissionPer;
    data['admin_comission_amount_per'] = adminComissionAmountPer;
    return data;
  }
}

class EditJobs {
  int? id;
  int? userId;
  int? jobId;
  String? oldData;
  String? ejData;
  String? comment;
  String? createdAt;
  String? updatedAt;

  EditJobs(
      {this.id,
        this.userId,
        this.jobId,
        this.oldData,
        this.ejData,
        this.comment,
        this.createdAt,
        this.updatedAt});

  EditJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobId = json['job_id'];
    oldData = json['old_data'];
    ejData = json['_data'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['job_id'] = jobId;
    data['old_data'] = oldData;
    data['_data'] = ejData;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

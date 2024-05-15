class AddCommentResponseModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  AddCommentResponseModel({statusCode, status, message, data});

  AddCommentResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  String? jobId;
  int? userId;
  String? comment;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({jobId, userId, comment, updatedAt, createdAt, id});

  Data.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    userId = json['user_id'];
    comment = json['comment'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

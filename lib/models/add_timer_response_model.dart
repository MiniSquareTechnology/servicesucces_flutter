class AddTimerResponseModel {
  int? statusCode;
  String? status;
  String? message;
  int? data;

  AddTimerResponseModel(
      {this.statusCode, this.status, this.message, this.data});

  AddTimerResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'] is int) {
        data = json['data'];
      } else {
        data = int.parse(json['data']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

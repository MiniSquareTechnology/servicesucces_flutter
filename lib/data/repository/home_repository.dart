import 'package:employee_clock_in/data/resources/endpoints.dart';
import 'package:employee_clock_in/data/services/http_client.dart';
import 'package:employee_clock_in/models/add_comment_response_model.dart';
import 'package:employee_clock_in/models/add_job_response_model.dart';
import 'package:employee_clock_in/models/job_detail_response_model.dart';
import 'package:employee_clock_in/models/job_history_response_model.dart';

class HomeRepository {
  final HttpClient iClient = HttpClient.instance;

  HomeRepository();

  Future<AddJobResponseModel> addJobApi(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.addJob,
      body: params,
      responseConverter: (json) => AddJobResponseModel.fromJson(json),
    );
  }

  Future<AddJobResponseModel> updateJobApi(
      String jobId, Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.updateJob(jobId),
      body: params,
      responseConverter: (json) => AddJobResponseModel.fromJson(json),
    );
  }

  Future<AddJobResponseModel> addJobFormApi(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.addJobForm,
      body: params,
      responseConverter: (json) => AddJobResponseModel.fromJson(json),
    );
  }

/*  Future<AddJobResponseModel> addUpdatePlumbingJobFormApi(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.addUpdatePlumbingJobForm,
      body: params,
      responseConverter: (json) => AddJobResponseModel.fromJson(json),
    );
  }

  Future<AddJobResponseModel> addUpdateTechnicianJobFormApi(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.addUpdateTechnicianJobForm,
      body: params,
      responseConverter: (json) => AddJobResponseModel.fromJson(json),
    );
  }*/

  Future<JobDetailResponseModel> getJobDetailApi(String jobId) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.getJobDetail(jobId),
      // body: params,
      responseConverter: (json) => JobDetailResponseModel.fromJson(json),
    );
  }

  Future<JobHistoryResponseModel> getJobHistoryApi(
      Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.jobHistory(params),
      // body: params,
      responseConverter: (json) => JobHistoryResponseModel.fromJson(json),
    );
  }

  Future<AddCommentResponseModel> postJobCommentApi(
      Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.addComment,
      body: params,
      responseConverter: (json) => AddCommentResponseModel.fromJson(json),
    );
  }
}

import 'package:employee_clock_in/data/resources/endpoints.dart';
import 'package:employee_clock_in/data/services/http_client.dart';
import 'package:employee_clock_in/models/add_job_response_model.dart';
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

  Future<JobHistoryResponseModel> getJobHistoryApi(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().homeEndPoints.jobHistory,
      body: params,
      responseConverter: (json) => JobHistoryResponseModel.fromJson(json),
    );
  }
}

import 'package:employee_clock_in/data/resources/endpoints.dart';
import 'package:employee_clock_in/data/services/http_client.dart';
import 'package:employee_clock_in/models/add_job_response_model.dart';

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
}

import '../services/http_client.dart';

class ApiEndpointProvider {
  final String baseUrl = "https://booking.minisquaretechnologies.com/api/v1/";

  ApiEndpointProvider();

  final ApiAuthEndpoints authEndPoints = ApiAuthEndpoints();
  final ApiJobEndPoints homeEndPoints = ApiJobEndPoints();
}

class ApiEndpoint {
  final String path;
  final RequestType method;
  final bool needsAuthorization;

  ApiEndpoint(
      {required this.path,
      required this.method,
      this.needsAuthorization = false});
}

class ApiAuthEndpoints {
  final ApiEndpoint emailLogin = ApiEndpoint(
    path: "login",
    method: RequestType.Post,
  );

  final ApiEndpoint changePassword = ApiEndpoint(
      path: "changePassword",
      method: RequestType.Post,
      needsAuthorization: true);

  final ApiEndpoint logout = ApiEndpoint(
      path: "logout", method: RequestType.Get, needsAuthorization: true);
}

class ApiJobEndPoints {
  final ApiEndpoint addJob = ApiEndpoint(
      path: "add-job",
      method: RequestType.Post,
      needsAuthorization: true);

   ApiEndpoint updateJob(String jobId) => ApiEndpoint(
      path: "update-job/$jobId",
      method: RequestType.MultiPart,
      needsAuthorization: true);

  final ApiEndpoint addJobForm = ApiEndpoint(
      path: "add-update-job-form",
      method: RequestType.Post,
      needsAuthorization: true);

  final ApiEndpoint addUpdatePlumbingJobForm = ApiEndpoint(
      path: "add-update-job-form-plumbing",
      method: RequestType.Post,
      needsAuthorization: true);

  final ApiEndpoint addUpdateTechnicianJobForm = ApiEndpoint(
      path: "add-update-job-form-technician",
      method: RequestType.Post,
      needsAuthorization: true);

  final ApiEndpoint jobHistory = ApiEndpoint(
      path: "job-history",
      method: RequestType.Get,
      needsAuthorization: true);

}

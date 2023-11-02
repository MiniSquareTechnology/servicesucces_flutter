import '../services/http_client.dart';

class ApiEndpointProvider {
  final String baseUrl = "https://booking.minisquaretechnologies.com/api/v1/";

  ApiEndpointProvider();

  final ApiAuthEndpoints authEndPoints = ApiAuthEndpoints();
  final ApiHomeEndPoints homeEndPoints = ApiHomeEndPoints();
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

class ApiHomeEndPoints {
  final ApiEndpoint addJob = ApiEndpoint(
      path: "add-job",
      method: RequestType.Post,
      needsAuthorization: true);

   ApiEndpoint updateJob(String jobId) => ApiEndpoint(
      path: "update-job/$jobId",
      method: RequestType.MultiPart,
      needsAuthorization: true);
}

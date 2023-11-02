import 'package:employee_clock_in/data/resources/endpoints.dart';
import 'package:employee_clock_in/data/services/http_client.dart';
import 'package:employee_clock_in/models/login_response_model.dart';

class AuthRepository {
  final HttpClient iClient = HttpClient.instance;

  AuthRepository();

  Future<LoginResponseModel> loginWithEmail(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.emailLogin,
      body: params,
      responseConverter: (json) => LoginResponseModel.fromJson(json),
    );
  }

  Future<LoginResponseModel> changePassword(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.changePassword,
      body: params,
      responseConverter: (json) => LoginResponseModel.fromJson(json),
    );
  }

Future<LoginResponseModel> logOut() async {
  return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.logout,
      responseConverter: (json) => LoginResponseModel.fromJson(json));
}
}

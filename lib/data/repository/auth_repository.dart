import 'package:employee_clock_in/data/resources/endpoints.dart';
import 'package:employee_clock_in/data/services/http_client.dart';
import 'package:employee_clock_in/models/forgot_password_response_model.dart';
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

  Future<ForgotPasswordResponseModel> forgotPassword(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.forgotPassword,
      body: params,
      responseConverter: (json) => ForgotPasswordResponseModel.fromJson(json),
    );
  }

  Future<ForgotPasswordResponseModel> verifyOtp(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.verifyOtp,
      body: params,
      responseConverter: (json) => ForgotPasswordResponseModel.fromJson(json),
    );
  }

  Future<ForgotPasswordResponseModel> resendOtp(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.resendOtp,
      body: params,
      responseConverter: (json) => ForgotPasswordResponseModel.fromJson(json),
    );
  }

  Future<ForgotPasswordResponseModel> resetPassword(Map<String, String> params) async {
    return await iClient.handleRequest(
      apiEndpoint: ApiEndpointProvider().authEndPoints.resetPassword,
      body: params,
      responseConverter: (json) => ForgotPasswordResponseModel.fromJson(json),
    );
  }
}

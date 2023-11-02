// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:employee_clock_in/data/resources/endpoints.dart';
import 'package:employee_clock_in/res/utils/error/app_error.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

enum RequestType { Post, Get, Patch, MultiPart, MultiPartPatch, Delete }

typedef JsonModelBuilder<TEntity> = TEntity Function(dynamic json);

class HttpClient {
  // make this a singleton class
  HttpClient._privateConstructor();

  static final HttpClient instance = HttpClient._privateConstructor();

  void logRequest(url, body, bool auth) {
    AppLogger.logMessage('Url: $url,Body: $body, Authorized: $auth');
  }

  Future<Entity> handleRequest<Entity>(
      {required ApiEndpoint apiEndpoint,
      Map<String, String>? body,
      Map<String, File>? parts,
      JsonModelBuilder<Entity>? responseConverter}) async {
    var url = Uri.parse(ApiEndpointProvider().baseUrl + apiEndpoint.path);
    Map<String, String> headers = {};

    body ??= {};
    RequestType request = apiEndpoint.method;
    bool needAuthorization = apiEndpoint.needsAuthorization;
    if (needAuthorization) {
      String token = await AppPreferenceStorage.getStringValuesSF(
              AppPreferenceStorage.authToken) ??
          "";
      AppLogger.logMessage("Token is $token");
      headers.addAll(
          {'Authorization': 'Bearer $token', "Accept": "application/json"});
    }

    try {
      logRequest(url, body, needAuthorization);
      late http.Response response;
      switch (request) {
        case RequestType.Get:
          {
            response = await http.get(url, headers: headers);
            break;
          }
        case RequestType.Post:
          {
            response = await http.post(url, body: body, headers: headers);
            break;
          }
        case RequestType.Delete:
          {
            body.addAll({'_method': 'delete'});
            response = await http.post(url, body: body, headers: headers);
            break;
          }
        case RequestType.Patch:
          {
            body.addAll({'_method': 'patch'});
            response = await http.post(url, body: body, headers: headers);
            break;
          }
        case RequestType.MultiPart:
          {
            if (request == RequestType.MultiPart) {
              body.addAll({'_method': 'PUT'});
            }
            var reguest = http.MultipartRequest('POST', url);
            reguest.fields.addAll(body);
            reguest.headers.addAll(headers);
            if(parts != null) {
              for (int i = 0; i < parts.length; i++) {
                reguest.files.add(await http.MultipartFile.fromPath(
                  parts.keys.toList()[i],
                  parts.values.toList()[i].path,
                ));
              }
            }

            http.StreamedResponse streamedResponse = await reguest.send();
            response = await Response.fromStream(streamedResponse);
            break;
          }
        case RequestType.MultiPartPatch:
          {
            if (request == RequestType.MultiPartPatch) {
              body.addAll({'_method': 'POST'});
            }
            var reguest = http.MultipartRequest('POST', url);
            reguest.fields.addAll(body);
            reguest.headers.addAll(headers);
            for (int i = 0; i < parts!.length; i++) {
              reguest.files.add(await http.MultipartFile.fromPath(
                parts.keys.toList()[i],
                parts.values.toList()[i].path,
              ));
            }
            http.StreamedResponse streamedResponse = await reguest.send();
            response = await Response.fromStream(streamedResponse);
            break;
          }
      }
      AppLogger.logMessage(
          "Status Code ${response.statusCode} Response Body ${response.body}");
      if (response.statusCode == 200) {
        /// Since API has the default code for error response i.e 200,
        /// we need to handle error and success calls manually
        if ((jsonDecode(response.body) as Map<String, dynamic>)
            .containsKey("error")) {
          throw AppError(
              message: jsonDecode(response.body)['error']['message'],
              code: response.statusCode);
        } else {
          if (responseConverter != null) {
            return responseConverter(jsonDecode(response.body));
          } else {
            return Future.value();
          }
        }
      } else if (response.statusCode == 201) {
        if ((jsonDecode(response.body) as Map<String, dynamic>)
            .containsKey("error")) {
          throw AppError(
              message: jsonDecode(response.body)['error']['message'],
              code: response.statusCode);
        } else {
          if (responseConverter != null) {
            return responseConverter(jsonDecode(response.body));
          } else {
            return Future.value();
          }
        }
      } else if (response.statusCode == 422) {
        throw AppError(message: '${jsonDecode(response.body)['message']}', code: 422);
      } else {
        if ((jsonDecode(response.body) as Map<String, dynamic>)
            .containsKey("error")) {
          throw AppError(
              message: jsonDecode(response.body)['error']['message'],
              code: response.statusCode);
        }
        if ((jsonDecode(response.body) as Map<String, dynamic>)
            .containsKey("errors")) {
          throw AppError(
              message: jsonDecode(response.body)['errors']['message'],
              code: response.statusCode);
        } else if (response.body.contains('error')) {
          throw AppError(
              message: jsonDecode(response.body)['error'],
              code: response.statusCode);
        } else {
          // throw AppError(message: 'Unexpected Server Response');
          throw AppError(message: '${jsonDecode(response.body)['message']}', code: 404);
        }
      }
    } on SocketException catch (e, s) {
      AppLogger.logMessage("Error $e with trace $s");
      // ErrorLogging.log("http-library-impl", getUserId() + " - " + e.message);
      throw AppError(message: 'No Internet connection', code: 1);
    } on TimeoutException catch (e, s) {
      AppLogger.logError("Error $e with trace $s");
      // ErrorLogging.log("http-library-impl", "${getUserId()} - ${e.message}");
      throw AppError(message: 'Timeout Error', code: 2);
    } on FormatException catch (e, s) {
      AppLogger.logError("Error $e with trace $s");
      // ErrorLogging.log("http-library-impl", getUserId() + " - " + e.message);
      throw AppError(message: 'Server Error! Invalid Response', code: 3);
    } on AppError catch (e, s) {
      AppLogger.logError("Error $e with trace $s");
      // ErrorLogging.log("http-library-impl", getUserId() + " - " + e.message);
      throw AppError(message: e.message, code: e.code);
    } catch (e, s) {
      AppLogger.logError("Error $e with trace $s");
      // ErrorLogging.log("http-library-impl", getUserId() + " - " + "$e");
      throw AppError(message: 'Oops! Something went wrong', code: 400);
    }
  }

/*String getUserId() {
    if(memberSession.connectedMemberProfile != null){
     return memberSession.connectedMemberProfile!.userDetail.id.toString();
    } else {
      return "";
    }
  }*/
}

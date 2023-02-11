import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/resources/components/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiResponse();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      var response =
          await _apiServices.getPostApiResponse(AppUrls.loginUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      var response =
          await _apiServices.getPostApiResponse(AppUrls.registrationUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

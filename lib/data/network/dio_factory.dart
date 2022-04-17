import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_demo/app/app_prefs.dart';
import 'package:mvvm_demo/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    int _timeOut = 60 * 1000; // 1 min
    String language = await _appPreferences.getAppLanguage();

    // CREATE A HEADERS MAP,
    // CHANGE THE AUTHORIZATION AS PER BUSINESS LOGIN
    Map<String, String> _headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: 'en' // GET LANGUAGE PREFS FROM APP PREFERENCES
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        headers: _headers);

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ));
    }

    return dio;
  }
}

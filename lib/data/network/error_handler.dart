import 'package:mvvm_demo/data/network/failure_response.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
}

extension DataSourceExtension on DataSource {
  FailureResponse getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return FailureResponse(
            ResponseCode.BAD_REQUEST.toString(), ResponseMESSAGE.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return FailureResponse(
            ResponseCode.FORBIDDEN.toString(), ResponseMESSAGE.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return FailureResponse(
            ResponseCode.UNAUTHORISED.toString(), ResponseMESSAGE.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return FailureResponse(
            ResponseCode.NOT_FOUND.toString(), ResponseMESSAGE.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return FailureResponse(
            ResponseCode.INTERNAL_SERVER_ERROR.toString(), ResponseMESSAGE.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return FailureResponse(
            ResponseCode.CONNECT_TIMEOUT.toString(), ResponseMESSAGE.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return FailureResponse(
            ResponseCode.CANCEL.toString(), ResponseMESSAGE.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return FailureResponse(
            ResponseCode.RECEIVE_TIMEOUT.toString(), ResponseMESSAGE.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return FailureResponse(
            ResponseCode.SEND_TIMEOUT.toString(), ResponseMESSAGE.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return FailureResponse(
            ResponseCode.CACHE_ERROR.toString(), ResponseMESSAGE.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return FailureResponse(
            ResponseCode.NO_INTERNET_CONNECTION.toString(), ResponseMESSAGE.NO_INTERNET_CONNECTION);
      default:
        return FailureResponse(
            ResponseCode.BAD_REQUEST.toString(), ResponseMESSAGE.BAD_REQUEST);
    }
  }
}

class ResponseCode {
  // Api status code
  static const int SUCCESS = 200; // SUCCESS WITH DATA
  static const int NO_CONTENT = 201; // SUCCESS with no data
  static const int BAD_REQUEST = 400; // FAILURE, api rejected the request
  static const int FORBIDDEN = 403; // FAILURE, api rejected the request
  static const int UNAUTHORISED = 401; // FAILURE, user is not authorised
  static const int NOT_FOUND =
      404; // FAILURE, API URL IS NOT CORRECT AND NOT FOUND
  static const int INTERNAL_SERVER_ERROR =
      500; // FAILURE, crash happened in server

  // local status code
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMESSAGE {
  // Api status code
  static const String SUCCESS = 'Success'; // SUCCESS WITH DATA
  static const String NO_CONTENT =
      'Success with no content'; // SUCCESS with no data
  static const String BAD_REQUEST =
      'Bad request, try again later'; // FAILURE, api rejected the request
  static const String FORBIDDEN =
      'forbidden request, try again later'; // FAILURE, api rejected the request
  static const String UNAUTHORISED =
      'user is unauthorised, try again later'; // FAILURE, user is not authorised
  static const String NOT_FOUND =
      'Url is not found, try again later'; // FAILURE, API URL IS NOT CORRECT AND NOT FOUND
  static const String INTERNAL_SERVER_ERROR =
      'Something went wrong, try again later'; // FAILURE, crash happened in server

  // local status code
  static const String UNKNOWN = 'Some thing went wrong, try again later';
  static const String CONNECT_TIMEOUT = 'time out error, try again later';
  static const String CANCEL = 'request was cancelled, try again later';
  static const String RECEIVE_TIMEOUT = 'timeout error, try again later';
  static const String SEND_TIMEOUT = 'timeout error, try again later';
  static const String CACHE_ERROR = 'Cached error, try again later';
  static const String NO_INTERNET_CONNECTION =
      'Please check your internet connectivity';
}

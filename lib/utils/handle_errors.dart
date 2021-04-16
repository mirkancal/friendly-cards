import 'package:dio/dio.dart';

String handleError(dynamic error) {
  var errorDescription = '';
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        errorDescription = 'Connection timeout with API server';
        break;

      case DioErrorType.receiveTimeout:
        errorDescription = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.response:
        errorDescription = getErrorMessage(error);
        break;
      case DioErrorType.sendTimeout:
        errorDescription = 'Request sent timeout';
        break;
      case DioErrorType.other:
        errorDescription =
            'Connection to API server failed due to internet connection';
        break;
    }
  } else {
    errorDescription = 'Unexpected error occurred';
  }
  return errorDescription;
}

String getErrorMessage(DioError error) {
  try {
    if (error.response?.data is Map) {
      final list =
          (error.response?.data['fieldErrors'] as Map).values.first as List;
      final errorDescription = (list.first as Map)['message'];
      errorDescription == null ? throw Exception() : null;
      return errorDescription as String;
    } else {
      throw Exception();
    }
  } catch (e) {
    if (error.response?.statusCode == 429) {
      return 'Too many requests, wait a little bit...';
    }
    return 'Received invalid status code: ${error.response!.statusCode}';
  }
}

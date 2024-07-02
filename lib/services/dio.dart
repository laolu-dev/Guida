import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';

class GuidaMapAPI {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: GuidaConstants.placesApiUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([PrettyDioLogger()]);
}

class GuidaSheetAPI {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: GuidaConstants.sheetBaseUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([PrettyDioLogger()]);
}

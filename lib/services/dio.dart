import 'package:dio/dio.dart';
import 'package:guida/constants/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class GuidaApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: GuidaConstants.baseUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      PrettyDioLogger(),
    ]);
  }

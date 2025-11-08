import 'package:crud_app/config/config.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

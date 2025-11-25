import 'package:crud_app/config/config.dart';
import 'package:dio/dio.dart';

final dioCfg = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

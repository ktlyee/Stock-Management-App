import 'package:dio/dio.dart';

class Api {
  static Dio dio = Dio(BaseOptions(
    //ios emulator http://127.0.0.1:3000 or localhost
    //android emulator http://10.0.2.2:3000
    //dev server http://pintobangkachao.sit.kmutt.ac.th:3000
    baseUrl: 'http://10.0.2.2:5000',
  ));
}



//http://127.0.0.1:5000/predict
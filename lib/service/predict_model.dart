import 'package:csc344_project/service/api.dart';
import 'package:dio/dio.dart';

class PredictModel {
  static Future <List<dynamic>> fetchData () async {
    try{
      var data = await Api.dio.get('/predict');
      print(data.data);
      return data.data;

    }on DioError catch (err) {
      print(err.response!.data);
      return err.response!.data;
    }
  }

  static Future <double> predictData (Map<String, dynamic> body) async {
    try{
      FormData formData = FormData.fromMap(body);
      print(body);

      var data = await Api.dio.post('/predict', data: formData);
      print(data.data);
      return data.data['ans'];

    }on DioError catch (err) {
      print(err.response!.data);
      return err.response!.data;
    }
  }

  // static Future<double> getAns() async {}
}
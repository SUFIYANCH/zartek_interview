import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:levelx_interview/model/api_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<ApiModel>?> getDishData() async {
    try {
      Response response = await dio
          .get("https://run.mocky.io/v3/4d116e3e-808c-43ab-93ed-6c70540d4e18");
      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        return apiModelFromJson(jsonResponse);
      }
    } on DioException catch (e) {
      log("Dio error:${e.message}");
    }
    return null;
  }
}

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:prueba_flutter_2/service/http_api.dart';
import 'package:prueba_flutter_2/service/token_service.dart';

class DataService {
  static Future<int> getLatestProductValue() async {
    ApiResponse response = ApiResponse(data: {}, statusCode: 404);
    response = await Api().getWithoutToken('/light/latest');

    if (response.statusCode == 200) {
      dynamic latestData = response.data;
      if (latestData is Map<String, dynamic> && latestData.containsKey('value')) {
        return latestData['value'] as int;
      } else {
        print('Error: La respuesta no contiene el valor esperado.');
        return -1; // or handle the error in another way
      }
    } else {
      print('Error en la solicitud: ${response.statusCode}');
      return -1; // or handle the error in another way
    }
  }
}


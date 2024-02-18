import 'package:dio/dio.dart';
import 'package:grafana_test_app/data/network/api/endpoints.dart';
import 'package:grafana_test_app/data/network/dio_client.dart';

class MessagesApi {
  final DioClient dioClient;

  MessagesApi({required this.dioClient});

  Future<Response> sendMessage(String message) async {
    try {
      final Response response = await dioClient.post(
        '${Endpoints.baseUrl}api/',
        data: {'message': message},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMessage() async {
    try {
      final Response response = await dioClient.get('${Endpoints.baseUrl}api/');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> streamMessages() async {
    try {
      var response = await dioClient.get(
        '${Endpoints.baseUrl}api/',
        options: Options(responseType: ResponseType.stream),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

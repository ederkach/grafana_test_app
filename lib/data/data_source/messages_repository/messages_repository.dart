import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grafana_test_app/core/exceptions/exceptions.dart';
import 'package:grafana_test_app/data/data_source/messages_repository/base_messages_repository.dart';
import 'package:grafana_test_app/data/message_model/message_model.dart';
import 'package:grafana_test_app/data/network/api/messages_api.dart';
import 'package:grafana_test_app/data/network/dio_exceptions.dart';

class MessagesRepository extends BaseMessagesRepository {
  final MessagesApi _messagesApi;

  MessagesRepository({required MessagesApi messagesApi})
      : _messagesApi = messagesApi;

  @override
  Future<Either<ServerException, MessageModel>> getMessage() async {
    try {
      final response = await _messagesApi.getMessage();

      final MessageModel messageModel =
          MessageModel.fromJson(response.data as Map<String, dynamic>);
      return Right(messageModel);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Left(ServerException(message: errorMessage));
    } catch (e) {
      return const Left(ServerException(message: 'Failed to get messages'));
    }
  }

  @override
  Future<Either<ServerException, bool>> sendMessage(
      MessageModel message) async {
    try {
      final response = await _messagesApi.sendMessage(message.title ?? '');
      return Right(response.statusCode == 200);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Left(ServerException(message: errorMessage));
    } catch (e) {
      return const Left(ServerException(message: 'Failed to send message'));
    }
  }

  @override
  Future<Either<ServerException, Stream<Response>>> streamMessages() async {
    try {
      final response = _messagesApi.streamMessages();
      return Right(response.asStream());
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Left(ServerException(message: errorMessage));
    } catch (e) {
      return const Left(ServerException(message: 'Failed to stream messages'));
    }
  }
}

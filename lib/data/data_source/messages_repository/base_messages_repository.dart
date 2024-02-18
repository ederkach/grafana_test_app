import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grafana_test_app/core/exceptions/exceptions.dart';
import 'package:grafana_test_app/data/message_model/message_model.dart';

abstract class BaseMessagesRepository {
  Future<Either<ServerException, MessageModel>> getMessage();
  Future<Either<ServerException, bool>> sendMessage(MessageModel message);
  Future<Either<ServerException, Stream<Response>>> streamMessages();
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grafana_test_app/core/exceptions/exceptions.dart';
import 'package:grafana_test_app/data/data_source/messages_repository/messages_repository.dart';
import 'package:grafana_test_app/data/message_model/message_model.dart';

part 'messages_event.dart';
part 'messages_state.dart';
part 'messages_bloc.freezed.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessagesRepository _messagesService;

  late StreamSubscription _streamSub;
  dynamic streamRepo;

  MessagesBloc({required MessagesRepository messagesService})
      : _messagesService = messagesService,
        super(const MessagesState.loadingMessages()) {
    on<GetStreamMessages>(_getStreamMessages);
    on<StopStreamMessages>(_stopStreamMessages);
    on<GetMessage>(_getMessage);
  }

  void _getStreamMessages(
      GetStreamMessages event, Emitter<MessagesState> emit) async {
    emit(const MessagesState.loadingMessages());

    try {
      await _streamSub.cancel();
      debugPrint('Stream Cancelled');
    } catch (e) {
      debugPrint('Error cancel Stream: $e');
    }
    streamRepo = await _messagesService.streamMessages();

    streamRepo.fold(
        (failure) => emit(MessagesState.failureLoadingMessages(
            ServerException(message: failure.message))), (streamMessages) {
      _streamSub = streamMessages.listen((value) {
        if (value.messages.isNotEmpty) {
          add(GetMessage(value.messages));
        }
      });
    });
  }

  void _getMessage(GetMessage event, Emitter<MessagesState> emit) async {
    emit(MessagesState.loadedMessages(event.messageModel));
    //add(const StopStreamMessages());
  }

  void _stopStreamMessages(
      StopStreamMessages event, Emitter<MessagesState> emit) async {
    if (!_streamSub.isPaused) await _streamSub.cancel();
    emit(const MessagesState.emptyMessages());
  }

  @override
  Future<void> close() async {
    //if (streamRepo != null) {
    try {
      await _streamSub.cancel();
      debugPrint('Stream Cancelled');
    } catch (e) {
      debugPrint('Error cancel Stream: $e');
    }

    //}
    return super.close();
  }
}

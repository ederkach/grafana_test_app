import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grafana_test_app/core/exceptions/exceptions.dart';
import 'package:grafana_test_app/data/data_source/messages_repository/messages_repository.dart';
import 'package:grafana_test_app/data/message_model/message_model.dart';

part 'sender_event.dart';
part 'sender_state.dart';
part 'sender_bloc.freezed.dart';

class SenderBloc extends Bloc<SenderSender, SenderState> {
  final MessagesRepository _messagesService;

  SenderBloc({required MessagesRepository messagesService})
      : _messagesService = messagesService,
        super(const SenderState.initialSenders()) {
    on<SentMessage>(_sentMessage);
  }

  void _sentMessage(SentMessage event, Emitter<SenderState> emit) async {
    emit(const SenderState.loadingSenders());

    var eventsData = await _messagesService.sendMessage(event.messageModel);

    eventsData.fold(
        (failure) => emit(SenderState.failureSenders(
            ServerException(message: failure.message))), (listEvents) {
      emit(const SenderState.successSenders());
    });
  }
}

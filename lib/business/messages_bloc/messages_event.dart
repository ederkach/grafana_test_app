part of 'messages_bloc.dart';

@freezed
class MessagesEvent with _$MessagesEvent {
  const factory MessagesEvent.getStreamMessages() = GetStreamMessages;
  const factory MessagesEvent.stopStreamMessages() = StopStreamMessages;
  const factory MessagesEvent.getMessage(MessageModel messageModel) =
      GetMessage;
}

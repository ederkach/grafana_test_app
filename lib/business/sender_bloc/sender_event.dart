part of 'sender_bloc.dart';

@freezed
class SenderSender with _$SenderSender {
  const factory SenderSender.sentMessage(MessageModel messageModel) =
      SentMessage;
}

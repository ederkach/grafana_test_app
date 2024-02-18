part of 'messages_bloc.dart';

@freezed
abstract class MessagesState with _$MessagesState {
  const factory MessagesState.emptyMessages() = EmptyMessages;
  const factory MessagesState.loadingMessages() = LoadingMessages;
  const factory MessagesState.loadedMessages(MessageModel messageModel) =
      loadedMessages;
  const factory MessagesState.failureLoadingMessages(ServerException failure) =
      FailureLoadingMessages;
}

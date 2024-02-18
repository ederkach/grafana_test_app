part of 'sender_bloc.dart';

@freezed
abstract class SenderState with _$SenderState {
  const factory SenderState.initialSenders() = InitialSenders;
  const factory SenderState.loadingSenders() = LoadingSenders;
  const factory SenderState.successSenders() = LoadedSenders;
  const factory SenderState.failureSenders(ServerException exception) =
      FailureSenders;
}

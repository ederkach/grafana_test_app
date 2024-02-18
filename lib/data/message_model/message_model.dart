import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel implements _$MessageModel {
  const MessageModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageModel({
    @JsonKey(name: 'title') final String? title,
  }) = _MessageModel;

  factory MessageModel.empty() => const MessageModel();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

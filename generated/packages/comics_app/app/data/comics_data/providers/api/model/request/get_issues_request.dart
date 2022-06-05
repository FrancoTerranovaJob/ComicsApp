import 'package:freezed_annotation/freezed_annotation.dart';
part './generated/get_issues_request.freezed.dart';
part './generated/get_issues_request.g.dart';

@freezed
class GetIssuesRequest with _$GetIssuesRequest {
  const factory GetIssuesRequest(
      {required int maxLength,
      required int startIndex,
      required int endIndex}) = _GetIssuesRequest;

  factory GetIssuesRequest.fromJson(Map<String, Object?> json) =>
      _$GetIssuesRequestFromJson(json);
}
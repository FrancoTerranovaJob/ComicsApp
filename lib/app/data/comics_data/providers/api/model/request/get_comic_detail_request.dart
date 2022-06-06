import 'package:equatable/equatable.dart';

class GetComicDetailRequest extends Equatable {
  final String detailUrl;
  final String responseFormat;
  final String requiredFields;

  const GetComicDetailRequest(
      {this.responseFormat = 'json',
      required this.detailUrl,
      this.requiredFields = ''});

  @override
  List<Object> get props => [detailUrl, responseFormat, requiredFields];
}
import 'package:equatable/equatable.dart';

class GetComicDetailRequest extends Equatable {
  final String detailUrl;
  final String responseFormat;

  const GetComicDetailRequest(
      {this.responseFormat = 'json', required this.detailUrl});

  @override
  List<Object> get props => [detailUrl, responseFormat];
}